# Unified Model to Roblox Workflow
# Supports: Blender, Fusion 360, or manual FBX files
# Handles: Export → Git → Convert to .rbxm → Sync to Studio

param(
    [Parameter(Mandatory=$false)]
    [string]$ModelName = "model",
    
    [Parameter(Mandatory=$false)]
    [string]$Source = "blender",
    
    [Parameter(Mandatory=$false)]
    [string]$ObjectPrefix = "",
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("Workspace", "ReplicatedStorage")]
    [string]$Destination = "Workspace",
    
    [Parameter(Mandatory=$false)]
    [switch]$AutoCommit,
    
    [Parameter(Mandatory=$false)]
    [switch]$SkipExport
)

$ErrorActionPreference = "Stop"
$repoRoot = if ($PSScriptRoot) { $PSScriptRoot } else { Get-Location }
Set-Location $repoRoot

# Configuration
$FUSION_MCP_PATH = "C:\Users\Tyler\Fusion-MCP-Server"
$FUSION_MCP_PORT = 8080
$ROJO_PORT = 34872
$ROJO_PATH = "C:\Users\Tyler\Tools\rojo\rojo.exe"

# Determine paths
$modelsDir = if ($Destination -eq "Workspace") { "assets\workspace_models" } else { "assets\models" }
$targetLocation = if ($Destination -eq "Workspace") { "Workspace > Models" } else { "ReplicatedStorage > Assets > Models" }
$fbxPath = Join-Path $modelsDir "$ModelName.fbx"
$rbxmPath = Join-Path $modelsDir "$ModelName.rbxm"
$stepPath = Join-Path $modelsDir "$ModelName.step"

# Ensure directories exist
New-Item -ItemType Directory -Force -Path $modelsDir | Out-Null

# Shared Functions
function Write-Step {
    param([string]$Message, [string]$Color = "Cyan")
    Write-Host ""
    Write-Host ("=" * 40) -ForegroundColor $Color
    Write-Host $Message -ForegroundColor $Color
    Write-Host ("=" * 40) -ForegroundColor $Color
    Write-Host ""
}

function Invoke-GitCommand {
    param([string[]]$Commands, [string]$Message)
    try {
        $env:PATH += ";C:\Program Files\Git\cmd"
        foreach ($cmd in $Commands) {
            $result = Invoke-Expression "git $cmd" 2>&1
            if ($LASTEXITCODE -ne 0 -and $cmd -notmatch "add") {
                Write-Host "⚠ Git warning: $result" -ForegroundColor Yellow
            }
        }
        Write-Host "✓ $Message" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "⚠ Git operation skipped: $_" -ForegroundColor Yellow
        return $false
    }
}

function Find-RobloxStudio {
    $paths = @(
        "$env:LOCALAPPDATA\Roblox\Versions\*\RobloxStudioBeta.exe",
        "C:\Program Files (x86)\Roblox\Versions\*\RobloxStudioBeta.exe"
    )
    foreach ($path in $paths) {
        $found = Get-ChildItem -Path $path -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($found) { return $found.FullName }
    }
    return $null
}

function Wait-ForFile {
    param([string]$FilePath, [int]$MaxWaitSeconds = 300, [string]$Description = "file")
    $start = Get-Date
    while (-not (Test-Path $FilePath)) {
        if (((Get-Date) - $start).TotalSeconds -gt $MaxWaitSeconds) {
            Write-Host "`n✗ Timeout waiting for $Description" -ForegroundColor Red
            return $false
        }
        Start-Sleep -Seconds 2
        Write-Host "." -NoNewline -ForegroundColor Gray
    }
    Write-Host ""
    return $true
}

function Export-FromFusion360 {
    param([string]$OutputPath)
    Write-Host "Connecting to Fusion 360 MCP server..." -ForegroundColor Yellow
    
    $mcpRunning = Get-NetTCPConnection -LocalPort $FUSION_MCP_PORT -ErrorAction SilentlyContinue
    if (-not $mcpRunning) {
        Write-Host "✗ Fusion 360 MCP Server is not running!" -ForegroundColor Red
        Write-Host "Start it with: .\start_fusion_mcp_server.bat" -ForegroundColor Yellow
        return $false
    }
    
    $pythonScript = @"
import sys
import os
sys.path.insert(0, r'$FUSION_MCP_PATH')
from client import MCPClient
import json

client = MCPClient('127.0.0.1', $FUSION_MCP_PORT)
if not client.connect():
    print('ERROR: Failed to connect')
    sys.exit(1)

try:
    model_info = client.get_model_info()
    print('Model info retrieved')
    # Export command - customize based on MCP server capabilities
    result = client.execute_fusion_command('export_model', {
        'format': 'step',
        'path': r'$((Resolve-Path .).Path)\$OutputPath'
    })
    print('SUCCESS')
except Exception as e:
    print(f'ERROR: {e}')
    sys.exit(1)
finally:
    client.disconnect()
"@
    
    $tempScript = Join-Path $env:TEMP "fusion360_export_$(Get-Random).py"
    $pythonScript | Out-File -FilePath $tempScript -Encoding UTF8
    
    try {
        $output = python $tempScript 2>&1
        Write-Host $output
        return ($output -notmatch "ERROR")
    } finally {
        Remove-Item $tempScript -ErrorAction SilentlyContinue
    }
}

# Main Workflow
Write-Host ""
Write-Host ("=" * 50) -ForegroundColor Magenta
Write-Host "  MODEL TO ROBLOX WORKFLOW" -ForegroundColor Magenta
Write-Host ("=" * 50) -ForegroundColor Magenta
Write-Host "Model: $ModelName" -ForegroundColor White
Write-Host "Source: $Source" -ForegroundColor White
Write-Host "Destination: $targetLocation" -ForegroundColor White
Write-Host ""

# STEP 1: Export Model
Write-Step "STEP 1: Exporting Model" "Cyan"

if (-not $SkipExport) {
    switch ($Source.ToLower()) {
        "blender" {
            if (-not $ObjectPrefix) { $ObjectPrefix = "BJ_" }
            if (Test-Path $fbxPath) {
                Write-Host "✓ FBX file found: $fbxPath" -ForegroundColor Green
            } else {
                Write-Host "Export from Blender:" -ForegroundColor Yellow
                Write-Host "  1. Select objects with prefix: $ObjectPrefix" -ForegroundColor Gray
                Write-Host "  2. File -> Export -> FBX" -ForegroundColor Gray
                Write-Host "  3. Save to: $((Resolve-Path $fbxPath).Path)" -ForegroundColor Gray
                if (-not (Wait-ForFile -FilePath $fbxPath -Description "FBX file")) {
                    exit 1
                }
                Write-Host "✓ FBX file found!" -ForegroundColor Green
            }
        }
        "fusion360" {
            if (Export-FromFusion360 -OutputPath $stepPath) {
                if (-not (Wait-ForFile -FilePath $stepPath -Description "STEP file")) {
                    Write-Host "Please export manually from Fusion 360" -ForegroundColor Yellow
                    exit 1
                }
                Write-Host "✓ STEP file exported" -ForegroundColor Green
                Write-Host "Converting STEP to FBX..." -ForegroundColor Yellow
                Write-Host "Import STEP into Blender and export as FBX to: $fbxPath" -ForegroundColor Gray
                if (-not (Wait-ForFile -FilePath $fbxPath -MaxWaitSeconds 600 -Description "FBX file")) {
                    exit 1
                }
            } else {
                exit 1
            }
        }
        default {
            if (-not (Test-Path $fbxPath)) {
                Write-Host "✗ FBX file not found: $fbxPath" -ForegroundColor Red
                exit 1
            }
            Write-Host "✓ Using existing FBX: $fbxPath" -ForegroundColor Green
        }
    }
} else {
    if (-not (Test-Path $fbxPath)) {
        Write-Host "✗ FBX file not found: $fbxPath" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ Using existing FBX: $fbxPath" -ForegroundColor Green
}

# STEP 2: Commit to Git
Write-Step "STEP 2: Committing to Git" "Cyan"

$filesToAdd = @($fbxPath)
if (Test-Path $stepPath) { $filesToAdd += $stepPath }

Invoke-GitCommand -Commands @("add $($filesToAdd -join ' ')") -Message "Files staged"

if ($AutoCommit) {
    $commitMsg = "Export $ModelName from $Source"
    Invoke-GitCommand -Commands @("commit -m `"$commitMsg`"", "push") -Message "Committed and pushed to GitHub"
}

# STEP 3: Convert to .rbxm
Write-Step "STEP 3: Converting FBX to .rbxm" "Cyan"

if (Test-Path $rbxmPath) {
    $overwrite = Read-Host "File exists: $rbxmPath. Overwrite? (y/n)"
    if ($overwrite -eq 'y') { Remove-Item $rbxmPath -Force }
    else { Write-Host "Using existing .rbxm file" -ForegroundColor Gray; exit 0 }
}

$studioPath = Find-RobloxStudio
if (-not $studioPath) {
    Write-Host "✗ Roblox Studio not found" -ForegroundColor Red
    exit 1
}

Write-Host "CONVERSION INSTRUCTIONS:" -ForegroundColor Yellow
Write-Host "1. Open Roblox Studio" -ForegroundColor White
Write-Host "2. Ensure Rojo is connected (localhost:$ROJO_PORT)" -ForegroundColor White
Write-Host "3. Navigate to: $targetLocation" -ForegroundColor White
Write-Host "4. Drag and drop: $((Resolve-Path $fbxPath).Path)" -ForegroundColor Cyan
Write-Host "5. Right-click model -> Export Selection..." -ForegroundColor White
Write-Host "6. Save as: $((Resolve-Path $rbxmPath).Path)" -ForegroundColor Cyan
Write-Host ""

$studioRunning = Get-Process | Where-Object { $_.ProcessName -like "*RobloxStudio*" }
if (-not $studioRunning) {
    Write-Host "Opening Roblox Studio..." -ForegroundColor Green
    Start-Process $studioPath
    Start-Sleep -Seconds 3
}

Write-Host "Waiting for conversion..." -ForegroundColor Cyan
if (-not (Wait-ForFile -FilePath $rbxmPath -MaxWaitSeconds 600 -Description ".rbxm file")) {
    exit 1
}
Write-Host "✓ File created: $rbxmPath" -ForegroundColor Green

# STEP 4: Final Commit
Write-Step "STEP 4: Final Commit" "Cyan"

Invoke-GitCommand -Commands @("add $rbxmPath") -Message "File staged"

if ($AutoCommit) {
    $commitMsg = "Add $ModelName to $Destination"
    Invoke-GitCommand -Commands @("commit -m `"$commitMsg`"", "push") -Message "Committed and pushed to GitHub"
}

# Check Rojo
$rojoRunning = Get-NetTCPConnection -LocalPort $ROJO_PORT -ErrorAction SilentlyContinue
if ($rojoRunning) {
    Write-Host "✓ Rojo is running" -ForegroundColor Green
    Write-Host "NOTE: Drag .rbxm file into Studio's $targetLocation to import" -ForegroundColor Yellow
} else {
    Write-Host "⚠ Rojo not running. Start with: $ROJO_PATH serve" -ForegroundColor Yellow
}

Write-Step "WORKFLOW COMPLETE!" "Green"
Write-Host "Model: $ModelName" -ForegroundColor White
Write-Host "Files: $fbxPath -> $rbxmPath" -ForegroundColor Gray
Write-Host "Destination: $targetLocation" -ForegroundColor Gray
Write-Host ""

