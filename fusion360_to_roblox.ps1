# Fusion 360 to Roblox Workflow
# Exports from Fusion 360, imports to Blender, then uses existing workflow

param(
    [Parameter(Mandatory=$false)]
    [string]$ModelName = "parametric_model",
    
    [Parameter(Mandatory=$false)]
    [string]$Fusion360ExportPath = "",
    
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

# Determine paths
if ($Destination -eq "Workspace") {
    $modelsDir = "assets\workspace_models"
} else {
    $modelsDir = "assets\models"
}

$fbxPath = "$modelsDir\$ModelName.fbx"

function Write-Step {
    param([string]$Message, [string]$Color = "Cyan")
    Write-Host "`n========================================" -ForegroundColor $Color
    Write-Host $Message -ForegroundColor $Color
    Write-Host "========================================`n" -ForegroundColor $Color
}

Write-Step "FUSION 360 TO ROBLOX WORKFLOW" "Magenta"

Write-Host "STEP 1: Export from Fusion 360" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "In Fusion 360:" -ForegroundColor White
Write-Host "1. Open your parametric model" -ForegroundColor Gray
Write-Host "2. File -> Export -> FBX" -ForegroundColor Gray
Write-Host "3. Save to: $((Resolve-Path .).Path)\$fbxPath" -ForegroundColor Gray
Write-Host ""
Write-Host "Or if you already exported, provide the path with -Fusion360ExportPath" -ForegroundColor Yellow
Write-Host ""

if ($Fusion360ExportPath -and (Test-Path $Fusion360ExportPath)) {
    Write-Host "Copying exported file..." -ForegroundColor Green
    Copy-Item $Fusion360ExportPath -Destination $fbxPath -Force
    Write-Host "✓ File copied to: $fbxPath" -ForegroundColor Green
} elseif (Test-Path $fbxPath) {
    Write-Host "✓ FBX file already exists: $fbxPath" -ForegroundColor Green
} else {
    Write-Host "Waiting for FBX file..." -ForegroundColor Yellow
    Write-Host "Export from Fusion 360 and save to: $fbxPath" -ForegroundColor Gray
    Write-Host "(Press Ctrl+C to cancel)" -ForegroundColor Gray
    Write-Host ""
    
    $maxWait = 600
    $start = Get-Date
    while (-not (Test-Path $fbxPath)) {
        if (((Get-Date) - $start).TotalSeconds -gt $maxWait) {
            Write-Host "Timeout. Please export manually." -ForegroundColor Red
            exit 1
        }
        Start-Sleep -Seconds 2
        Write-Host "." -NoNewline -ForegroundColor Gray
    }
    Write-Host ""
    Write-Host "✓ FBX file found!" -ForegroundColor Green
}

# STEP 2: Optional - Import to Blender for optimization
Write-Step "STEP 2: Optional Blender Optimization" "Cyan"
Write-Host "You can optionally import the FBX into Blender to:" -ForegroundColor White
Write-Host "  - Optimize polygon count" -ForegroundColor Gray
Write-Host "  - Adjust materials" -ForegroundColor Gray
Write-Host "  - Add game-specific details" -ForegroundColor Gray
Write-Host ""
$useBlender = Read-Host "Import to Blender for optimization? (y/n)"
if ($useBlender -eq 'y') {
    Write-Host "Use Blender MCP to import and optimize the model" -ForegroundColor Yellow
    Write-Host "Then re-export from Blender" -ForegroundColor Yellow
}

# STEP 3: Use existing workflow
Write-Step "STEP 3: Convert to .rbxm" "Cyan"
Write-Host "Now using your existing Blender-to-Roblox workflow..." -ForegroundColor White
Write-Host ""

# Call the existing blender_to_roblox script
& ".\blender_to_roblox.ps1" -ModelName $ModelName -Destination $Destination -SkipBlenderExport -AutoCommit:$AutoCommit

Write-Host ""
Write-Step "WORKFLOW COMPLETE!" "Green"
Write-Host "Fusion 360 -> FBX -> Blender (optional) -> Roblox Studio" -ForegroundColor White

