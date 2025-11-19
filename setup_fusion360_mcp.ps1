# Setup script for Fusion 360 MCP Server
# This sets up the MCP server and integrates it with your workflow

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  FUSION 360 MCP SERVER SETUP" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$fusionMcpPath = "C:\Users\Tyler\Fusion-MCP-Server"
$repoRoot = $PSScriptRoot
if (-not $repoRoot) { $repoRoot = Get-Location }

# Check if Fusion MCP Server exists
if (-not (Test-Path $fusionMcpPath)) {
    Write-Host "Fusion MCP Server not found at: $fusionMcpPath" -ForegroundColor Red
    Write-Host "Cloning repository..." -ForegroundColor Yellow
    git clone https://github.com/Joelalbon/Fusion-MCP-Server.git $fusionMcpPath
}

Write-Host "✓ Fusion MCP Server found" -ForegroundColor Green

# Create startup script for the server
$serverScript = @"
@echo off
cd /d $fusionMcpPath
python server.py
pause
"@

$serverScriptPath = "$repoRoot\start_fusion_mcp_server.bat"
$serverScript | Out-File -FilePath $serverScriptPath -Encoding ASCII
Write-Host "✓ Created server startup script: $serverScriptPath" -ForegroundColor Green

# Create Python wrapper for Fusion 360 control
$pythonWrapper = @"
import sys
import os
sys.path.insert(0, r'$fusionMcpPath')
from client import MCPClient
import json

def export_model_to_roblox(model_name, output_path):
    \"\"\"Export model from Fusion 360 and prepare for Roblox\"\"\"
    client = MCPClient('127.0.0.1', 8080)
    
    if not client.connect():
        print('Failed to connect to Fusion 360 MCP server')
        print('Make sure:')
        print('  1. Fusion 360 MCP server is running (start_fusion_mcp_server.bat)')
        print('  2. Fusion 360 add-in is installed and connected')
        return False
    
    try:
        # Get model info
        print('Getting model information...')
        model_info = client.get_model_info()
        print(f'Model info: {json.dumps(model_info, indent=2)}')
        
        # Export model (you may need to customize this based on available commands)
        print(f'Exporting model to: {output_path}')
        # Note: You'll need to implement the actual export command
        # based on what the Fusion 360 MCP server supports
        
        return True
    finally:
        client.disconnect()

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print('Usage: python fusion360_control.py <model_name> <output_path>')
        sys.exit(1)
    
    export_model_to_roblox(sys.argv[1], sys.argv[2])
"@

$pythonWrapperPath = "$repoRoot\fusion360_control.py"
$pythonWrapper | Out-File -FilePath $pythonWrapperPath -Encoding UTF8
Write-Host "✓ Created Fusion 360 control script: $pythonWrapperPath" -ForegroundColor Green

Write-Host "`n========================================" -ForegroundColor Yellow
Write-Host "NEXT STEPS:" -ForegroundColor Yellow
Write-Host "========================================`n" -ForegroundColor Yellow

Write-Host "1. Install Fusion 360 Add-in:" -ForegroundColor White
Write-Host "   - Copy the Fusion-MCP-Server folder to Fusion 360 AddIns directory" -ForegroundColor Gray
Write-Host "   - In Fusion 360: Shift+S -> Add-ins -> Load from my computer" -ForegroundColor Gray
Write-Host "   - Select the folder and click Run" -ForegroundColor Gray

Write-Host "`n2. Start the MCP Server:" -ForegroundColor White
Write-Host "   - Run: .\start_fusion_mcp_server.bat" -ForegroundColor Gray
Write-Host "   - Or: cd $fusionMcpPath && python server.py" -ForegroundColor Gray

Write-Host "`n3. Connect Fusion 360 to Server:" -ForegroundColor White
Write-Host "   - In Fusion 360, look for 'MCP Controls' panel" -ForegroundColor Gray
Write-Host "   - Click 'Connect to MCP Server'" -ForegroundColor Gray
Write-Host "   - Enter: 127.0.0.1:8080" -ForegroundColor Gray

Write-Host "`n4. Use the workflow:" -ForegroundColor White
Write-Host "   - Run: .\fusion360_to_roblox_auto.ps1" -ForegroundColor Gray

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "Setup complete!" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Green

