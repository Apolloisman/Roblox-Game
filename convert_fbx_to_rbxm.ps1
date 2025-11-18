# PowerShell script to convert FBX to .rbxm format
# This script guides you through the conversion process

param(
    [string]$FbxPath = "assets\models\blackjack_table.fbx",
    [string]$OutputDir = "assets\models"
)

$ErrorActionPreference = "Stop"

function Find-RobloxStudio {
    $possiblePaths = @(
        "$env:LOCALAPPDATA\Roblox\Versions\*\RobloxStudioBeta.exe",
        "C:\Program Files (x86)\Roblox\Versions\*\RobloxStudioBeta.exe",
        "C:\Program Files\Roblox\Versions\*\RobloxStudioBeta.exe"
    )
    
    foreach ($path in $possiblePaths) {
        $found = Get-ChildItem -Path $path -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($found) {
            return $found.FullName
        }
    }
    
    return $null
}

function Convert-FbxToRbxm {
    param(
        [string]$FbxFile,
        [string]$OutputDirectory
    )
    
    $fbxPath = Resolve-Path $FbxFile -ErrorAction Stop
    $outputPath = Join-Path $OutputDirectory "$([System.IO.Path]::GetFileNameWithoutExtension($fbxPath)).rbxm"
    
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "FBX to .rbxm Conversion Script" -ForegroundColor Cyan
    Write-Host "========================================`n" -ForegroundColor Cyan
    
    Write-Host "Source FBX: $fbxPath" -ForegroundColor Green
    Write-Host "Target .rbxm: $outputPath`n" -ForegroundColor Green
    
    # Check if output already exists
    if (Test-Path $outputPath) {
        Write-Host "Warning: $outputPath already exists!" -ForegroundColor Yellow
        $overwrite = Read-Host "Overwrite? (y/n)"
        if ($overwrite -ne 'y') {
            Write-Host "Cancelled." -ForegroundColor Red
            return $false
        }
    }
    
    Write-Host "`n========================================" -ForegroundColor Yellow
    Write-Host "CONVERSION INSTRUCTIONS:" -ForegroundColor Yellow
    Write-Host "========================================`n" -ForegroundColor Yellow
    
    Write-Host "1. Open Roblox Studio (if not already open)" -ForegroundColor White
    Write-Host "2. Make sure Rojo is connected (localhost:34872)" -ForegroundColor White
    Write-Host "3. Navigate to: ReplicatedStorage > Assets > Models" -ForegroundColor White
    Write-Host "4. Right-click 'Models' folder > 'Import from file...'" -ForegroundColor White
    Write-Host "   OR drag and drop the FBX file into Studio" -ForegroundColor White
    Write-Host "5. Select: $fbxPath" -ForegroundColor Cyan
    Write-Host "6. Wait for import to complete" -ForegroundColor White
    Write-Host "7. Right-click the imported model > 'Export Selection...'" -ForegroundColor White
    Write-Host "8. Save as: $outputPath" -ForegroundColor Cyan
    Write-Host "`n========================================`n" -ForegroundColor Yellow
    
    # Try to open Roblox Studio
    $studioPath = Find-RobloxStudio
    if ($studioPath) {
        Write-Host "Opening Roblox Studio..." -ForegroundColor Green
        try {
            Start-Process $studioPath
            Start-Sleep -Seconds 3
            Write-Host "Roblox Studio opened. Follow the instructions above.`n" -ForegroundColor Green
        } catch {
            Write-Host "Could not open Roblox Studio automatically." -ForegroundColor Yellow
            Write-Host "Please open it manually and follow the instructions.`n" -ForegroundColor Yellow
        }
    } else {
        Write-Host "Could not find Roblox Studio installation." -ForegroundColor Yellow
        Write-Host "Please open Roblox Studio manually.`n" -ForegroundColor Yellow
    }
    
    # Wait for file to be created
    Write-Host "Waiting for $([System.IO.Path]::GetFileName($outputPath)) to be created..." -ForegroundColor Cyan
    Write-Host "(Complete the import/export in Studio, then press any key when done)" -ForegroundColor Gray
    Write-Host "(Or press Ctrl+C to cancel)`n" -ForegroundColor Gray
    
    $maxWait = 600  # 10 minutes
    $startTime = Get-Date
    $checkInterval = 2
    
    try {
        while (-not (Test-Path $outputPath)) {
            if (((Get-Date) - $startTime).TotalSeconds -gt $maxWait) {
                Write-Host "`nTimeout: File was not created within 10 minutes." -ForegroundColor Red
                Write-Host "Please complete the conversion manually." -ForegroundColor Red
                return $false
            }
            
            # Check if user pressed a key (non-blocking)
            if ([Console]::KeyAvailable) {
                $key = [Console]::ReadKey($true)
                Write-Host "`nChecking for file..." -ForegroundColor Yellow
            }
            
            Start-Sleep -Seconds $checkInterval
            Write-Host "." -NoNewline -ForegroundColor Gray
        }
        
        Write-Host "`n`nSUCCESS! File created: $outputPath" -ForegroundColor Green
        
        # Add to git
        Write-Host "`nAdding to Git..." -ForegroundColor Cyan
        try {
            Push-Location (Split-Path $outputPath -Parent).Parent.Parent
            git add $outputPath
            Write-Host "File staged for commit." -ForegroundColor Green
            Write-Host "Run: git commit -m 'Add $([System.IO.Path]::GetFileName($outputPath))'" -ForegroundColor Yellow
            Write-Host "Then: git push" -ForegroundColor Yellow
            Pop-Location
        } catch {
            Write-Host "Git add failed. Add manually: git add $outputPath" -ForegroundColor Yellow
        }
        
        return $true
        
    } catch {
        Write-Host "`nCancelled or error occurred." -ForegroundColor Red
        return $false
    }
}

# Main execution
try {
    Convert-FbxToRbxm -FbxFile $FbxPath -OutputDirectory $OutputDir
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
}


