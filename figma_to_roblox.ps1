# Figma to Roblox UI Workflow
# Exports Figma designs and prepares them for Roblox

param(
    [Parameter(Mandatory=$false)]
    [string]$DesignName = "ui_design",
    
    [Parameter(Mandatory=$false)]
    [string]$FigmaFile = "",
    
    [Parameter(Mandatory=$false)]
    [switch]$AutoCommit
)

$ErrorActionPreference = "Continue"
$repoRoot = if ($PSScriptRoot) { $PSScriptRoot } else { Get-Location }
Set-Location $repoRoot

$uiDir = "assets\ui"
$imagesDir = Join-Path $uiDir "images"
$iconsDir = Join-Path $uiDir "icons"
$designsDir = Join-Path $uiDir "designs"

# Ensure directories exist
New-Item -ItemType Directory -Force -Path $imagesDir | Out-Null
New-Item -ItemType Directory -Force -Path $iconsDir | Out-Null
New-Item -ItemType Directory -Force -Path $designsDir | Out-Null

function Write-Step {
    param([string]$Message, [string]$Color = "Cyan")
    Write-Host ""
    Write-Host ("=" * 50) -ForegroundColor $Color
    Write-Host $Message -ForegroundColor $Color
    Write-Host ("=" * 50) -ForegroundColor $Color
    Write-Host ""
}

Write-Step "FIGMA TO ROBLOX UI WORKFLOW" "Magenta"

Write-Host "This workflow helps you export Figma designs to Roblox" -ForegroundColor White
Write-Host ""

Write-Host "STEP 1: Export from Figma" -ForegroundColor Cyan
Write-Host "1. Open your design in Figma" -ForegroundColor White
Write-Host "2. Select frames/components to export" -ForegroundColor White
Write-Host "3. Use Figma's Export feature:" -ForegroundColor White
Write-Host "   - Right-click → Export → PNG/JPG" -ForegroundColor Gray
Write-Host "   - Or use Figma plugins for batch export" -ForegroundColor Gray
Write-Host "4. Save exported images to:" -ForegroundColor White
Write-Host "   $((Resolve-Path $imagesDir).Path)" -ForegroundColor Cyan
Write-Host ""

Write-Host "STEP 2: Organize Assets" -ForegroundColor Cyan
Write-Host "Place files in:" -ForegroundColor White
Write-Host "  - UI Images: $imagesDir" -ForegroundColor Gray
Write-Host "  - Icons: $iconsDir" -ForegroundColor Gray
Write-Host "  - Design Files: $designsDir" -ForegroundColor Gray
Write-Host ""

Write-Host "STEP 3: Generate UI Code with Cursor" -ForegroundColor Cyan
Write-Host "Use Cursor AI to:" -ForegroundColor White
Write-Host "  - Generate Luau UI component code" -ForegroundColor Gray
Write-Host "  - Create UI management scripts" -ForegroundColor Gray
Write-Host "  - Build responsive UI systems" -ForegroundColor Gray
Write-Host ""
Write-Host "Example prompt for Cursor:" -ForegroundColor Yellow
Write-Host '  "Create a Roblox UI component for a main menu with buttons' -ForegroundColor Gray
Write-Host '   using the images from assets/ui/images/ menu_background.png"' -ForegroundColor Gray
Write-Host ""

Write-Host "STEP 4: Commit to Git" -ForegroundColor Cyan
if ($AutoCommit) {
    try {
        $env:PATH += ";C:\Program Files\Git\cmd"
        git add $uiDir 2>&1 | Out-Null
        git commit -m "Add UI design: $DesignName" 2>&1 | Out-Null
        git push 2>&1 | Out-Null
        Write-Host "✓ Committed and pushed to GitHub" -ForegroundColor Green
    } catch {
        Write-Host "⚠ Git operation skipped" -ForegroundColor Yellow
    }
} else {
    Write-Host "Files ready. Commit with:" -ForegroundColor Yellow
    Write-Host "  git add assets/ui/" -ForegroundColor White
    Write-Host "  git commit -m 'Add UI design: $DesignName'" -ForegroundColor White
    Write-Host "  git push" -ForegroundColor White
}

Write-Host ""
Write-Host "STEP 5: Sync to Roblox Studio" -ForegroundColor Cyan
Write-Host "Images will sync via Rojo to StarterGui" -ForegroundColor White
Write-Host "UI scripts will sync to StarterPlayerScripts" -ForegroundColor White
Write-Host ""

Write-Step "WORKFLOW COMPLETE!" "Green"
Write-Host "Next: Use Cursor to generate UI code based on your Figma designs" -ForegroundColor White
Write-Host ""

