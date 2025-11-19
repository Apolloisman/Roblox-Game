"""
Fusion 360 MCP Control Interface
Connects to Fusion 360 MCP Server and exports models
"""

import sys
import os
import json
from pathlib import Path

# Add Fusion MCP Server to path
FUSION_MCP_PATH = Path(r"C:\Users\Tyler\Fusion-MCP-Server")
sys.path.insert(0, str(FUSION_MCP_PATH))

try:
    from client import MCPClient
except ImportError:
    print("ERROR: Could not import MCPClient")
    print(f"Make sure Fusion MCP Server is installed at: {FUSION_MCP_PATH}")
    sys.exit(1)


def export_model(model_name: str, output_path: str, format_type: str = "step") -> bool:
    """
    Export model from Fusion 360 via MCP server
    
    Args:
        model_name: Name of the model
        output_path: Full path to save the exported file
        format_type: Export format (step, stl, etc.)
    
    Returns:
        True if successful, False otherwise
    """
    client = MCPClient('127.0.0.1', 8080)
    
    if not client.connect():
        print("ERROR: Failed to connect to Fusion 360 MCP server")
        print("Make sure:")
        print("  1. Fusion 360 MCP server is running")
        print("  2. Fusion 360 add-in is installed and connected")
        return False
    
    try:
        # Get model information
        print(f"Getting model information for: {model_name}")
        model_info = client.get_model_info()
        print(f"Model info: {json.dumps(model_info, indent=2)}")
        
        # Export model
        print(f"Exporting model as {format_type.upper()} to: {output_path}")
        result = client.execute_fusion_command('export_model', {
            'format': format_type,
            'path': output_path,
            'name': model_name
        })
        
        if result and 'success' in str(result).lower():
            print("SUCCESS: Model exported")
            return True
        else:
            print(f"WARNING: Export result: {result}")
            print("Model may need to be exported manually from Fusion 360")
            return False
            
    except Exception as e:
        print(f"ERROR: {e}")
        import traceback
        traceback.print_exc()
        return False
    finally:
        client.disconnect()


def main():
    """Main entry point"""
    if len(sys.argv) < 3:
        print("Usage: python fusion360_control.py <model_name> <output_path> [format]")
        print("Example: python fusion360_control.py my_model C:\\path\\to\\export.step step")
        sys.exit(1)
    
    model_name = sys.argv[1]
    output_path = sys.argv[2]
    format_type = sys.argv[3] if len(sys.argv) > 3 else "step"
    
    success = export_model(model_name, output_path, format_type)
    sys.exit(0 if success else 1)


if __name__ == '__main__':
    main()
