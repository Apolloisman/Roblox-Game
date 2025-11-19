# Import All Models to Roblox
# Imports all FBX models from assets/models/ to Roblox Studio

param(
    [Parameter(Mandatory=$false)]
    [switch]$AutoCommit
)

$ErrorActionPreference = "Continue"
$repoRoot = if ($PSScriptRoot) { $PSScriptRoot } else { Get-Location }
Set-Location $repoRoot

Write-Host "`n=== Importing Models to Roblox ===" -ForegroundColor Cyan
Write-Host ""

# Models to import
$models = @(
    @{Name = "school"; File = "school.fbx"; Destination = "Workspace"; Prefix = "SCHOOL_"},
    @{Name = "townhall"; File = "townhall.fbx"; Destination = "Workspace"; Prefix = "TOWNHALL_"},
    @{Name = "shops"; File = "shops.fbx"; Destination = "Workspace"; Prefix = "SHOP_"},
    @{Name = "teleporters"; File = "teleporters.fbx"; Destination = "Workspace"; Prefix = "TELEPORTER_"},
    @{Name = "work_stations"; File = "work_stations.fbx"; Destination = "Workspace"; Prefix = "WORK_"},
    @{Name = "npc_stands"; File = "npc_stands.fbx"; Destination = "Workspace"; Prefix = "NPC_"},
    @{Name = "environment"; File = "environment.fbx"; Destination = "Workspace"; Prefix = ""}
)

foreach ($model in $models) {
    $fbxPath = Join-Path "assets\models" $model.File
    
    if (Test-Path $fbxPath) {
        Write-Host "Importing $($model.Name)..." -ForegroundColor Green
        
        # Use the model_to_roblox script
        $params = @{
            Source = "manual"
            ModelName = $model.Name
            Destination = $model.Destination
            SkipExport = $true
        }
        
        if ($model.Prefix) {
            $params.ObjectPrefix = $model.Prefix
        }
        
        if ($AutoCommit) {
            $params.AutoCommit = $true
        }
        
        & .\model_to_roblox.ps1 @params
        
        Write-Host "✓ $($model.Name) imported" -ForegroundColor Green
    } else {
        Write-Host "⚠ File not found: $fbxPath" -ForegroundColor Yellow
    }
}

Write-Host "`n=== Import Complete ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Open Roblox Studio" -ForegroundColor White
Write-Host "2. Import each .rbxm file from assets/workspace_models/" -ForegroundColor White
Write-Host "3. Models will appear in Workspace" -ForegroundColor White
Write-Host ""

