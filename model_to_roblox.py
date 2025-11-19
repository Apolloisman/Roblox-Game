"""
Unified Model to Roblox Workflow (Python)
Supports: Blender, Fusion 360, or manual FBX files
"""

import os
import sys
import subprocess
import time
from pathlib import Path

# Configuration
FUSION_MCP_PATH = Path(r"C:\Users\Tyler\Fusion-MCP-Server")
ROJO_PORT = 34872
ROJO_PATH = r"C:\Users\Tyler\Tools\rojo\rojo.exe"


def print_step(message, color_code=36):
    """Print a formatted step header"""
    print(f"\n{'='*50}")
    print(f"\033[{color_code}m{message}\033[0m")
    print(f"{'='*50}\n")


def git_command(commands, message):
    """Execute git commands"""
    try:
        for cmd in commands:
            result = subprocess.run(["git"] + cmd.split(), cwd=Path(__file__).parent,
                                  capture_output=True, text=True)
            if result.returncode != 0 and "add" not in cmd:
                print(f"⚠ Git warning: {result.stderr}")
        print(f"✓ {message}")
        return True
    except Exception as e:
        print(f"⚠ Git operation skipped: {e}")
        return False


def wait_for_file(file_path, max_wait=300, description="file"):
    """Wait for a file to be created"""
    start = time.time()
    while not Path(file_path).exists():
        if time.time() - start > max_wait:
            print(f"\n✗ Timeout waiting for {description}")
            return False
        time.sleep(2)
        print(".", end="", flush=True)
    print("")
    return True


def find_roblox_studio():
    """Find Roblox Studio installation"""
    paths = [
        Path.home() / "AppData" / "Local" / "Roblox" / "Versions",
        Path("C:/Program Files (x86)/Roblox/Versions"),
    ]
    for base in paths:
        if base.exists():
            for folder in base.iterdir():
                exe = folder / "RobloxStudioBeta.exe"
                if exe.exists():
                    return exe
    return None


def export_from_fusion360(output_path):
    """Export model from Fusion 360 via MCP"""
    import socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    result = sock.connect_ex(('localhost', 8080))
    sock.close()
    
    if result != 0:
        print("✗ Fusion 360 MCP Server is not running!")
        print("Start it with: .\\start_fusion_mcp_server.bat")
        return False
    
    sys.path.insert(0, str(FUSION_MCP_PATH))
    try:
        from client import MCPClient
        client = MCPClient('127.0.0.1', 8080)
        if not client.connect():
            print("ERROR: Failed to connect to Fusion 360")
            return False
        
        try:
            model_info = client.get_model_info()
            print(f"Model info: {model_info}")
            result = client.execute_fusion_command('export_model', {
                'format': 'step',
                'path': str(Path(output_path).resolve())
            })
            print("SUCCESS")
            return True
        finally:
            client.disconnect()
    except ImportError:
        print("ERROR: Fusion MCP Server not found")
        return False
    except Exception as e:
        print(f"ERROR: {e}")
        return False


def main():
    """Main workflow"""
    model_name = sys.argv[1] if len(sys.argv) > 1 else "model"
    source = sys.argv[2] if len(sys.argv) > 2 else "blender"
    destination = sys.argv[3] if len(sys.argv) > 3 else "Workspace"
    auto_commit = "--commit" in sys.argv
    skip_export = "--skip-export" in sys.argv
    
    repo_root = Path(__file__).parent
    models_dir = repo_root / "assets" / ("workspace_models" if destination == "Workspace" else "models")
    models_dir.mkdir(parents=True, exist_ok=True)
    
    fbx_path = models_dir / f"{model_name}.fbx"
    rbxm_path = models_dir / f"{model_name}.rbxm"
    step_path = models_dir / f"{model_name}.step"
    target_location = "Workspace > Models" if destination == "Workspace" else "ReplicatedStorage > Assets > Models"
    
    print_step("MODEL TO ROBLOX WORKFLOW", 35)
    print(f"Model: {model_name}")
    print(f"Source: {source}")
    print(f"Destination: {target_location}\n")
    
    # STEP 1: Export
    print_step("STEP 1: Exporting Model", 36)
    
    if not skip_export:
        if source.lower() == "fusion360":
            if export_from_fusion360(step_path):
                if not wait_for_file(step_path, description="STEP file"):
                    print("Please export manually from Fusion 360")
                    sys.exit(1)
                print("✓ STEP file exported")
                print("Import STEP into Blender and export as FBX")
                if not wait_for_file(fbx_path, max_wait=600, description="FBX file"):
                    sys.exit(1)
            else:
                sys.exit(1)
        elif source.lower() == "blender":
            if not fbx_path.exists():
                print(f"Export from Blender and save to: {fbx_path}")
                if not wait_for_file(fbx_path, description="FBX file"):
                    sys.exit(1)
            print(f"✓ FBX file found: {fbx_path}")
        else:
            if not fbx_path.exists():
                print(f"✗ FBX file not found: {fbx_path}")
                sys.exit(1)
            print(f"✓ Using existing FBX: {fbx_path}")
    else:
        if not fbx_path.exists():
            print(f"✗ FBX file not found: {fbx_path}")
            sys.exit(1)
        print(f"✓ Using existing FBX: {fbx_path}")
    
    # STEP 2: Git Commit
    print_step("STEP 2: Committing to Git", 36)
    
    files_to_add = [str(fbx_path)]
    if step_path.exists():
        files_to_add.append(str(step_path))
    
    git_command([f"add {' '.join(files_to_add)}"], "Files staged")
    
    if auto_commit:
        git_command([
            f'commit -m "Export {model_name} from {source}"',
            "push"
        ], "Committed and pushed to GitHub")
    
    # STEP 3: Convert to .rbxm
    print_step("STEP 3: Converting FBX to .rbxm", 36)
    
    if rbxm_path.exists():
        response = input(f"File exists: {rbxm_path}. Overwrite? (y/n): ")
        if response.lower() != 'y':
            print("Using existing .rbxm file")
            sys.exit(0)
        rbxm_path.unlink()
    
    studio_path = find_roblox_studio()
    if not studio_path:
        print("✗ Roblox Studio not found")
        sys.exit(1)
    
    print("CONVERSION INSTRUCTIONS:")
    print("1. Open Roblox Studio")
    print(f"2. Ensure Rojo is connected (localhost:{ROJO_PORT})")
    print(f"3. Navigate to: {target_location}")
    print(f"4. Drag and drop: {fbx_path.resolve()}")
    print("5. Right-click model -> Export Selection...")
    print(f"6. Save as: {rbxm_path.resolve()}")
    print("")
    
    try:
        import psutil
        studio_running = any("RobloxStudio" in p.name() for p in psutil.process_iter())
        if not studio_running:
            print("Opening Roblox Studio...")
            subprocess.Popen([str(studio_path)])
            time.sleep(3)
    except ImportError:
        subprocess.check_call([sys.executable, "-m", "pip", "install", "psutil", "-q"])
        import psutil
    
    print("Waiting for conversion...")
    if not wait_for_file(rbxm_path, max_wait=600, description=".rbxm file"):
        sys.exit(1)
    print(f"✓ File created: {rbxm_path}")
    
    # STEP 4: Final Commit
    print_step("STEP 4: Final Commit", 36)
    
    git_command([f"add {rbxm_path}"], "File staged")
    
    if auto_commit:
        git_command([
            f'commit -m "Add {model_name} to {destination}"',
            "push"
        ], "Committed and pushed to GitHub")
    
    # Check Rojo
    import socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    result = sock.connect_ex(('localhost', ROJO_PORT))
    sock.close()
    
    if result == 0:
        print("✓ Rojo is running")
        print(f"NOTE: Drag .rbxm file into Studio's {target_location} to import")
    else:
        print(f"⚠ Rojo not running. Start with: {ROJO_PATH} serve")
    
    print_step("WORKFLOW COMPLETE!", 32)
    print(f"Model: {model_name}")
    print(f"Files: {fbx_path} -> {rbxm_path}")
    print(f"Destination: {target_location}\n")


if __name__ == '__main__':
    try:
        import psutil
    except ImportError:
        subprocess.check_call([sys.executable, "-m", "pip", "install", "psutil", "-q"])
        import psutil
    
    main()

