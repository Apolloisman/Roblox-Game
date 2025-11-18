# Streamlined Blender to Roblox Workflow
# Handles: Export from Blender → Git → Convert to .rbxm → Sync to Studio

param(
    [Parameter(Mandatory=$false)]
    [string]$ModelName = "blackjack_table",
    
    [Parameter(Mandatory=$false)]
    [string]$ObjectPrefix = "BJ_",
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("Workspace", "ReplicatedStorage")]
    [string]$Destination = "Workspace",
    
    [Parameter(Mandatory=$false)]
    [switch]$AutoCommit,
    
    [Parameter(Mandatory=$false)]
    [switch]$SkipBlenderExport
)

$ErrorActionPreference = "Continue"
$repoRoot = $PSScriptRoot
if (-not $repoRoot) { $repoRoot = Get-Location }
Set-Location $repoRoot

# Determine paths based on destination
if ($Destination -eq "Workspace") {
    $modelsDir = "assets\workspace_models"
    $targetLocation = "Workspace > Models"
} else {
    $modelsDir = "assets\models"
    $targetLocation = "ReplicatedStorage > Assets > Models"
}

$fbxPath = "$modelsDir\$ModelName.fbx"
$rbxmPath = "$modelsDir\$ModelName.rbxm"

function Write-Step {
    param([string]$Message, [string]$Color = "Cyan")
    Write-Host "`n========================================" -ForegroundColor $Color
    Write-Host $Message -ForegroundColor $Color
    Write-Host "========================================`n" -ForegroundColor $Color
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

# STEP 1: Export from Blender
Write-Step "STEP 1: Exporting from Blender" "Cyan"

if (-not $SkipBlenderExport) {
    if (Test-Path $fbxPath) {
        Write-Host "✓ FBX file found: $fbxPath" -ForegroundColor Green
    } else {
        Write-Host "✗ FBX file not found: $fbxPath" -ForegroundColor Yellow
        Write-Host "`nExport from Blender:" -ForegroundColor White
        Write-Host "  1. Select all objects starting with '$ObjectPrefix'" -ForegroundColor Gray
        Write-Host "  2. File > Export > FBX (.fbx)" -ForegroundColor Gray
        Write-Host "  3. Save to: $((Resolve-Path .).Path)\$fbxPath" -ForegroundColor Gray
        if (-not (Test-Path $fbxPath)) {
            Write-Host "`nWaiting for FBX file... (or press Ctrl+C to skip)" -ForegroundColor Yellow
            $maxWait = 300
            $start = Get-Date
            while (-not (Test-Path $fbxPath)) {
                if (((Get-Date) - $start).TotalSeconds -gt $maxWait) {
                    Write-Host "Timeout. Please export manually and run again with -SkipBlenderExport" -ForegroundColor Red
                    exit 1
                }
                Start-Sleep -Seconds 2
            }
            Write-Host "✓ FBX file found!" -ForegroundColor Green
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

try {
    git add $fbxPath 2>&1 | Out-Null
    if ($AutoCommit) {
        git commit -m "Export $ModelName from Blender" 2>&1 | Out-Null
        git push 2>&1 | Out-Null
        Write-Host "✓ Committed and pushed to GitHub" -ForegroundColor Green
    } else {
        Write-Host "✓ File staged. Commit with: git commit -m 'Export $ModelName from Blender'" -ForegroundColor Yellow
    }
} catch {
    Write-Host "⚠ Git operation skipped" -ForegroundColor Yellow
}

# STEP 3: Convert to .rbxm
Write-Step "STEP 3: Converting FBX to .rbxm" "Cyan"

if (Test-Path $rbxmPath) {
    $overwrite = Read-Host "File exists: $rbxmPath. Overwrite? (y/n)"
    if ($overwrite -ne 'y') {
        Write-Host "Using existing .rbxm file" -ForegroundColor Gray
    } else {
        Remove-Item $rbxmPath -Force
    }
}

if (-not (Test-Path $rbxmPath)) {
    $studioPath = Find-RobloxStudio
    if (-not $studioPath) {
        Write-Host "✗ Roblox Studio not found" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host "CONVERSION INSTRUCTIONS:" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host "1. Open Roblox Studio" -ForegroundColor White
    Write-Host "2. Make sure Rojo is connected (localhost:34872)" -ForegroundColor White
    Write-Host "3. Go to $targetLocation" -ForegroundColor White
    Write-Host "4. Drag and drop this file:" -ForegroundColor White
    Write-Host "   $((Resolve-Path $fbxPath).Path)" -ForegroundColor Cyan
    Write-Host "5. Wait for import" -ForegroundColor White
    Write-Host "6. Right-click model > Export Selection..." -ForegroundColor White
    Write-Host "7. Save as: $((Resolve-Path .).Path)\$rbxmPath" -ForegroundColor Cyan
    Write-Host "========================================`n" -ForegroundColor Yellow
    
    $studioRunning = Get-Process | Where-Object { $_.ProcessName -like "*RobloxStudio*" }
    if (-not $studioRunning) {
        Write-Host "Opening Roblox Studio..." -ForegroundColor Green
        Start-Process $studioPath
        Start-Sleep -Seconds 3
    }
    
    Write-Host "Waiting for $ModelName.rbxm..." -ForegroundColor Cyan
    Write-Host "Complete import/export in Studio, then press Enter when done.`n" -ForegroundColor Gray
    
    $maxWait = 600
    $start = Get-Date
    while (-not (Test-Path $rbxmPath)) {
        if (((Get-Date) - $start).TotalSeconds -gt $maxWait) {
            Write-Host "`nTimeout. Please complete conversion manually." -ForegroundColor Red
            exit 1
        }
        if ([Console]::KeyAvailable) {
            $key = [Console]::ReadKey($true)
            if ($key.Key -eq "Enter") { Write-Host "`nChecking..." -ForegroundColor Yellow }
        }
        Start-Sleep -Seconds 2
        Write-Host "." -NoNewline -ForegroundColor Gray
    }
    Write-Host "`n✓ File created: $rbxmPath" -ForegroundColor Green
}

# STEP 4: Commit .rbxm and sync
Write-Step "STEP 4: Committing .rbxm and Syncing" "Cyan"

try {
    git add $rbxmPath 2>&1 | Out-Null
    if ($AutoCommit) {
        git commit -m "Add $ModelName to $Destination" 2>&1 | Out-Null
        git push 2>&1 | Out-Null
        Write-Host "✓ Committed and pushed to GitHub" -ForegroundColor Green
    } else {
        Write-Host "✓ File staged. Commit with: git commit -m 'Add $ModelName to $Destination'" -ForegroundColor Yellow
    }
} catch {
    Write-Host "⚠ Git operation skipped" -ForegroundColor Yellow
}

# Check Rojo
$rojoRunning = Get-NetTCPConnection -LocalPort 34872 -ErrorAction SilentlyContinue
if ($rojoRunning) {
    Write-Host "✓ Rojo is running" -ForegroundColor Green
    Write-Host "`nNOTE: .rbxm files don't auto-sync via Rojo." -ForegroundColor Yellow
    Write-Host "Drag the file into Studio's $targetLocation to import it." -ForegroundColor White
    Write-Host "File location: $((Resolve-Path $rbxmPath).Path)" -ForegroundColor Gray
} else {
    Write-Host "⚠ Rojo is not running. Start with: C:\Users\Tyler\Tools\rojo\rojo.exe serve" -ForegroundColor Yellow
}

Write-Step "WORKFLOW COMPLETE!" "Green"
Write-Host "Model: $ModelName" -ForegroundColor White
Write-Host "FBX: $fbxPath" -ForegroundColor Gray
Write-Host ".rbxm: $rbxmPath" -ForegroundColor Gray
Write-Host "Destination: $targetLocation" -ForegroundColor Gray
