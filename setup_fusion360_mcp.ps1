# Fusion 360 MCP Server Setup
# Installs and configures Fusion 360 MCP Server integration

$ErrorActionPreference = "Stop"
$repoRoot = if ($PSScriptRoot) { $PSScriptRoot } else { Get-Location }
$fusionMcpPath = "C:\Users\Tyler\Fusion-MCP-Server"

Write-Host ""
Write-Host ("=" * 50) -ForegroundColor Cyan
Write-Host "  FUSION 360 MCP SERVER SETUP" -ForegroundColor Cyan
Write-Host ("=" * 50) -ForegroundColor Cyan
Write-Host ""

# Check if Fusion MCP Server exists
if (-not (Test-Path $fusionMcpPath)) {
    Write-Host "Fusion MCP Server not found. Cloning repository..." -ForegroundColor Yellow
    $env:PATH += ";C:\Program Files\Git\cmd"
    git clone https://github.com/Joelalbon/Fusion-MCP-Server.git $fusionMcpPath
    if ($LASTEXITCODE -ne 0) {
        Write-Host "✗ Failed to clone repository" -ForegroundColor Red
        exit 1
    }
}

Write-Host "✓ Fusion MCP Server found" -ForegroundColor Green

# Create startup script
$serverScript = @"
@echo off
cd /d $fusionMcpPath
python server.py
pause
"@

$serverScriptPath = Join-Path $repoRoot "start_fusion_mcp_server.bat"
$serverScript | Out-File -FilePath $serverScriptPath -Encoding ASCII -NoNewline
Write-Host "✓ Created server startup script" -ForegroundColor Green

# Display instructions
Write-Host ""
Write-Host ("=" * 50) -ForegroundColor Yellow
Write-Host "NEXT STEPS:" -ForegroundColor Yellow
Write-Host ("=" * 50) -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Install Fusion 360 Add-in:" -ForegroundColor White
Write-Host "   - Copy folder to: %APPDATA%\Autodesk\Autodesk Fusion 360\API\AddIns" -ForegroundColor Gray
Write-Host "   - In Fusion 360: Shift+S -> Add-ins -> Load from my computer" -ForegroundColor Gray
Write-Host "   - Select folder and click Run" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Start MCP Server:" -ForegroundColor White
Write-Host "   - Run: .\start_fusion_mcp_server.bat" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Connect Fusion 360:" -ForegroundColor White
Write-Host "   - Look for 'MCP Controls' panel in Fusion 360" -ForegroundColor Gray
Write-Host "   - Click 'Connect to MCP Server'" -ForegroundColor Gray
Write-Host "   - Enter: 127.0.0.1:8080" -ForegroundColor Gray
Write-Host ""
Write-Host "4. Use workflow:" -ForegroundColor White
Write-Host "   - Run: .\model_to_roblox.ps1 -Source fusion360 -ModelName my_model" -ForegroundColor Gray
Write-Host ""
Write-Host ("=" * 50) -ForegroundColor Green
Write-Host "Setup complete!" -ForegroundColor Green
Write-Host ("=" * 50) -ForegroundColor Green
Write-Host ""
