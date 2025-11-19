# Auto-Commit Helper Script
# Quickly commit and push changes to GitHub

param(
    [Parameter(Mandatory=$false)]
    [string]$Message = "Update project files",
    
    [Parameter(Mandatory=$false)]
    [switch]$Push
)

$ErrorActionPreference = "Continue"
$repoRoot = if ($PSScriptRoot) { $PSScriptRoot } else { Get-Location }
Set-Location $repoRoot

# Add Git to PATH if needed
$env:PATH += ";C:\Program Files\Git\cmd"

Write-Host "`n=== Auto-Commit Helper ===" -ForegroundColor Cyan
Write-Host ""

# Check for changes
$status = & git status --porcelain
if (-not $status) {
    Write-Host "No changes to commit." -ForegroundColor Yellow
    exit 0
}

# Show what will be committed
Write-Host "Changes to commit:" -ForegroundColor Green
& git status --short
Write-Host ""

# Add all changes
Write-Host "Staging files..." -ForegroundColor Cyan
& git add -A

# Commit
Write-Host "Committing..." -ForegroundColor Cyan
& git commit -m $Message

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Committed: $Message" -ForegroundColor Green
    
    if ($Push) {
        Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
        & git push
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ Pushed to GitHub" -ForegroundColor Green
        } else {
            Write-Host "⚠ Push failed. Check your connection." -ForegroundColor Yellow
        }
    } else {
        Write-Host "ℹ Use -Push flag to push to GitHub" -ForegroundColor Gray
    }
} else {
    Write-Host "⚠ Commit failed" -ForegroundColor Red
}

Write-Host ""

