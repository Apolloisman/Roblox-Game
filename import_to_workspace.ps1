# Quick script to import blackjack table to Workspace
param(
    [string]$ModelName = "blackjack_table"
)

$ErrorActionPreference = "Continue"
$repoRoot = $PSScriptRoot
if (-not $repoRoot) { $repoRoot = Get-Location }
Set-Location $repoRoot

$fbxPath = "assets\models\$ModelName.fbx"
$workspacePath = "assets\workspace_models\$ModelName.rbxm"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  IMPORT TO WORKSPACE" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

if (-not (Test-Path $fbxPath)) {
    Write-Host "FBX file not found: $fbxPath" -ForegroundColor Red
    exit 1
}

Write-Host "Source FBX: $fbxPath" -ForegroundColor Green
Write-Host "Target: Workspace > Models > $ModelName`n" -ForegroundColor Green

Write-Host "========================================" -ForegroundColor Yellow
Write-Host "INSTRUCTIONS:" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "1. Open Roblox Studio" -ForegroundColor White
Write-Host "2. Make sure Rojo is connected (localhost:34872)" -ForegroundColor White
Write-Host "3. In Studio, go to Workspace" -ForegroundColor White
Write-Host "4. Drag and drop this file into Workspace:" -ForegroundColor White
Write-Host "   $((Resolve-Path $fbxPath).Path)" -ForegroundColor Cyan
Write-Host "5. Wait for import to complete" -ForegroundColor White
Write-Host "6. Right-click the imported model > 'Export Selection...'" -ForegroundColor White
Write-Host "7. Save as: $workspacePath" -ForegroundColor Cyan
Write-Host "`n========================================`n" -ForegroundColor Yellow

# Find and open Studio
$studioPaths = @(
    "$env:LOCALAPPDATA\Roblox\Versions\*\RobloxStudioBeta.exe",
    "C:\Program Files (x86)\Roblox\Versions\*\RobloxStudioBeta.exe"
)

$studioPath = $null
foreach ($path in $studioPaths) {
    $found = Get-ChildItem -Path $path -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($found) {
        $studioPath = $found.FullName
        break
    }
}

if ($studioPath) {
    $studioRunning = Get-Process | Where-Object { $_.ProcessName -like "*RobloxStudio*" }
    if (-not $studioRunning) {
        Write-Host "Opening Roblox Studio..." -ForegroundColor Green
        Start-Process $studioPath
        Start-Sleep -Seconds 3
    } else {
        Write-Host "Roblox Studio is already running." -ForegroundColor Green
    }
}

# Wait for .rbxm file
Write-Host "`nWaiting for $ModelName.rbxm to be created..." -ForegroundColor Cyan
Write-Host "Complete the import/export in Studio, then press Enter when done.`n" -ForegroundColor Gray

$maxWait = 600
$startTime = Get-Date

try {
    while (-not (Test-Path $workspacePath)) {
        if (((Get-Date) - $startTime).TotalSeconds -gt $maxWait) {
            Write-Host "`nTimeout: File was not created." -ForegroundColor Red
            exit 1
        }
        
        if ([Console]::KeyAvailable) {
            $key = [Console]::ReadKey($true)
            if ($key.Key -eq "Enter") {
                Write-Host "`nChecking for file..." -ForegroundColor Yellow
            }
        }
        
        Start-Sleep -Seconds 2
        Write-Host "." -NoNewline -ForegroundColor Gray
    }
    
    Write-Host "`n`nSUCCESS! File created: $workspacePath" -ForegroundColor Green
    
    # Add to git
    Write-Host "`nAdding to Git..." -ForegroundColor Cyan
    git add $workspacePath
    git add default.project.json
    Write-Host "Files staged. Commit with:" -ForegroundColor Yellow
    Write-Host "  git commit -m 'Add $ModelName to Workspace'" -ForegroundColor White
    Write-Host "  git push" -ForegroundColor White
    
    Write-Host "`nThe model will sync to Workspace via Rojo!" -ForegroundColor Green
    
} catch {
    Write-Host "`nCancelled." -ForegroundColor Red
    exit 1
}

