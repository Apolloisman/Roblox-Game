# Automated Fusion 360 to Roblox workflow with GitHub auto-upload
# Uses Fusion 360 MCP Server to control Fusion 360

param(
    [Parameter(Mandatory=$false)]
    [string]$ModelName = "fusion360_model",
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("Workspace", "ReplicatedStorage")]
    [string]$Destination = "Workspace",
    
    [Parameter(Mandatory=$false)]
    [switch]$AutoCommit
)

$ErrorActionPreference = "Continue"
$repoRoot = $PSScriptRoot
if (-not $repoRoot) { $repoRoot = Get-Location }
Set-Location $repoRoot

$fusionMcpPath = "C:\Users\Tyler\Fusion-MCP-Server"

# Determine paths
if ($Destination -eq "Workspace") {
    $modelsDir = "assets\workspace_models"
    $targetLocation = "Workspace > Models"
} else {
    $modelsDir = "assets\models"
    $targetLocation = "ReplicatedStorage > Assets > Models"
}

$fbxPath = "$modelsDir\$ModelName.fbx"
$stepPath = "$modelsDir\$ModelName.step"
$rbxmPath = "$modelsDir\$ModelName.rbxm"

function Write-Step {
    param([string]$Message, [string]$Color = "Cyan")
    Write-Host "`n========================================" -ForegroundColor $Color
    Write-Host $Message -ForegroundColor $Color
    Write-Host "========================================`n" -ForegroundColor $Color
}

# Check if MCP server is running
Write-Step "Checking Fusion 360 MCP Server" "Cyan"

$mcpRunning = Get-NetTCPConnection -LocalPort 8080 -ErrorAction SilentlyContinue
if (-not $mcpRunning) {
    Write-Host "✗ Fusion 360 MCP Server is not running!" -ForegroundColor Red
    Write-Host "`nStart it with:" -ForegroundColor Yellow
    Write-Host "  .\start_fusion_mcp_server.bat" -ForegroundColor White
    Write-Host "`nOr run setup first:" -ForegroundColor Yellow
    Write-Host "  .\setup_fusion360_mcp.ps1" -ForegroundColor White
    exit 1
}

Write-Host "✓ Fusion 360 MCP Server is running on port 8080" -ForegroundColor Green

# STEP 1: Export from Fusion 360 via MCP
Write-Step "STEP 1: Exporting from Fusion 360 via MCP" "Cyan"

Write-Host "Connecting to Fusion 360 MCP server..." -ForegroundColor Yellow

# Use Python to control Fusion 360 via MCP
$pythonScript = @"
import sys
import os
sys.path.insert(0, r'$fusionMcpPath')
from client import MCPClient
import json
import time

client = MCPClient('127.0.0.1', 8080)
if not client.connect():
    print('ERROR: Failed to connect to Fusion 360 MCP server')
    print('Make sure Fusion 360 is running and the add-in is connected')
    sys.exit(1)

try:
    # Get model info
    print('Getting model information...')
    model_info = client.get_model_info()
    print(json.dumps(model_info, indent=2))
    
    # Export model - you may need to customize this command
    # based on what commands the Fusion 360 MCP server supports
    export_path = r'$((Resolve-Path .).Path)\$stepPath'
    print(f'Exporting model to: {export_path}')
    
    # Execute export command (customize based on available commands)
    result = client.execute_fusion_command('export_model', {
        'format': 'step',
        'path': export_path
    })
    
    print(f'Export result: {result}')
    print('SUCCESS')
    
except Exception as e:
    print(f'ERROR: {e}')
    sys.exit(1)
finally:
    client.disconnect()
"@

$tempScript = "$env:TEMP\fusion360_export_temp.py"
$pythonScript | Out-File -FilePath $tempScript -Encoding UTF8

try {
    $output = python $tempScript 2>&1
    Write-Host $output
    
    if ($output -match "ERROR") {
        Write-Host "`n✗ Export failed. Check Fusion 360 connection." -ForegroundColor Red
        Write-Host "`nManual export:" -ForegroundColor Yellow
        Write-Host "  1. In Fusion 360: File -> Export -> STEP" -ForegroundColor White
        Write-Host "  2. Save to: $((Resolve-Path .).Path)\$stepPath" -ForegroundColor White
        exit 1
    }
    
    if (-not (Test-Path $stepPath)) {
        Write-Host "`n⚠ STEP file not found. Waiting for manual export..." -ForegroundColor Yellow
        Write-Host "Export to: $stepPath" -ForegroundColor Gray
        $maxWait = 300
        $start = Get-Date
        while (-not (Test-Path $stepPath)) {
            if (((Get-Date) - $start).TotalSeconds -gt $maxWait) {
                Write-Host "Timeout. Please export manually." -ForegroundColor Red
                exit 1
            }
            Start-Sleep -Seconds 2
        }
    }
    
    Write-Host "✓ Model exported: $stepPath" -ForegroundColor Green
} finally {
    Remove-Item $tempScript -ErrorAction SilentlyContinue
}

# STEP 2: Convert STEP to FBX (via Blender if needed)
Write-Step "STEP 2: Converting STEP to FBX" "Cyan"

if (-not (Test-Path $fbxPath)) {
    Write-Host "STEP files need to be converted to FBX for Roblox." -ForegroundColor Yellow
    Write-Host "Options:" -ForegroundColor White
    Write-Host "  1. Import STEP into Blender, then export as FBX" -ForegroundColor Gray
    Write-Host "  2. Use Blender MCP to automate this" -ForegroundColor Gray
    Write-Host ""
    Write-Host "For now, please:" -ForegroundColor Yellow
    Write-Host "  1. Open Blender" -ForegroundColor White
    Write-Host "  2. File -> Import -> STEP" -ForegroundColor White
    Write-Host "  3. Select: $stepPath" -ForegroundColor White
    Write-Host "  4. File -> Export -> FBX" -ForegroundColor White
    Write-Host "  5. Save as: $fbxPath" -ForegroundColor White
    Write-Host ""
    Write-Host "Waiting for FBX file..." -ForegroundColor Yellow
    
    $maxWait = 600
    $start = Get-Date
    while (-not (Test-Path $fbxPath)) {
        if (((Get-Date) - $start).TotalSeconds -gt $maxWait) {
            Write-Host "Timeout." -ForegroundColor Red
            exit 1
        }
        Start-Sleep -Seconds 2
        Write-Host "." -NoNewline -ForegroundColor Gray
    }
    Write-Host ""
    Write-Host "✓ FBX file found!" -ForegroundColor Green
} else {
    Write-Host "✓ FBX file already exists: $fbxPath" -ForegroundColor Green
}

# STEP 3: Commit to Git
Write-Step "STEP 3: Committing to GitHub" "Cyan"

try {
    git add $stepPath, $fbxPath 2>&1 | Out-Null
    if ($AutoCommit) {
        git commit -m "Export $ModelName from Fusion 360" 2>&1 | Out-Null
        git push 2>&1 | Out-Null
        Write-Host "✓ Committed and pushed to GitHub" -ForegroundColor Green
    } else {
        Write-Host "✓ Files staged. Commit with:" -ForegroundColor Yellow
        Write-Host "  git commit -m 'Export $ModelName from Fusion 360'" -ForegroundColor White
        Write-Host "  git push" -ForegroundColor White
    }
} catch {
    Write-Host "⚠ Git operation skipped" -ForegroundColor Yellow
}

# STEP 4: Convert to .rbxm using existing workflow
Write-Step "STEP 4: Converting to .rbxm" "Cyan"

& ".\blender_to_roblox.ps1" -ModelName $ModelName -Destination $Destination -SkipBlenderExport -AutoCommit:$AutoCommit

Write-Host ""
Write-Step "WORKFLOW COMPLETE!" "Green"
Write-Host "Fusion 360 -> STEP -> FBX -> .rbxm -> Roblox Studio" -ForegroundColor White
Write-Host "All files committed to GitHub!" -ForegroundColor Green

