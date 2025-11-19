# Roblox Store Model Search Helper
# Helps you find and import models from the Roblox Creator Store

param(
    [Parameter(Mandatory=$true)]
    [string]$SearchTerm,
    
    [Parameter(Mandatory=$false)]
    [string]$Category = "all",
    
    [Parameter(Mandatory=$false)]
    [switch]$OpenInBrowser
)

$ErrorActionPreference = "Continue"

Write-Host "`n=== Roblox Store Model Search ===" -ForegroundColor Cyan
Write-Host ""

# Category mapping
$categories = @{
    "landscape" = "landscape"
    "buildings" = "buildings"
    "vehicles" = "vehicles"
    "characters" = "characters"
    "props" = "props"
    "decorations" = "decorations"
    "all" = ""
}

$categoryPath = if ($categories.ContainsKey($Category.ToLower())) {
    if ($categories[$Category.ToLower()] -eq "") {
        ""
    } else {
        "/categories/$($categories[$Category.ToLower()])"
    }
} else {
    ""
}

# Build search URL
$baseUrl = "https://create.roblox.com/store"
$searchUrl = if ($categoryPath -ne "") {
    "$baseUrl$categoryPath"
} else {
    "$baseUrl/models"
}

Write-Host "Searching for: $SearchTerm" -ForegroundColor Green
Write-Host "Category: $Category" -ForegroundColor Gray
Write-Host ""

# Open browser if requested
if ($OpenInBrowser) {
    Write-Host "Opening Roblox Store in browser..." -ForegroundColor Cyan
    Start-Process $searchUrl
    Write-Host "✓ Browser opened" -ForegroundColor Green
    Write-Host ""
}

Write-Host "=== How to Import Models ===" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Browse the store at: $searchUrl" -ForegroundColor White
Write-Host "2. Search for: '$SearchTerm'" -ForegroundColor White
Write-Host "3. Click on a model you want" -ForegroundColor White
Write-Host "4. Click 'Get' or 'Buy' button" -ForegroundColor White
Write-Host "5. In Roblox Studio:" -ForegroundColor White
Write-Host "   - Go to View → Toolbox" -ForegroundColor Gray
Write-Host "   - Click 'Inventory' tab" -ForegroundColor Gray
Write-Host "   - Find your model and drag it into the game" -ForegroundColor Gray
Write-Host ""
Write-Host "=== Alternative: Manual Import ===" -ForegroundColor Yellow
Write-Host ""
Write-Host "If you want to track models in Git:" -ForegroundColor White
Write-Host "1. Import model into Studio" -ForegroundColor Gray
Write-Host "2. Right-click model → Save to File" -ForegroundColor Gray
Write-Host "3. Save as .rbxm to assets/workspace_models/ or assets/models/" -ForegroundColor Gray
Write-Host "4. Run: .\auto_commit.ps1 -Message 'Add model from store' -Push" -ForegroundColor Gray
Write-Host ""

# Store URL for reference
Write-Host "Store URL: $searchUrl" -ForegroundColor Cyan
Write-Host ""

