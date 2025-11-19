import sys
import os
sys.path.insert(0, r'C:\Users\Tyler\Fusion-MCP-Server')
from client import MCPClient
import json

def export_model_to_roblox(model_name, output_path):
    """Export model from Fusion 360 and prepare for Roblox"""
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

