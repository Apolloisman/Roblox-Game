"""
Streamlined Blender to Roblox Workflow
Handles: Export from Blender → Git → Convert to .rbxm → Sync to Studio
"""

import os
import sys
import subprocess
import time
from pathlib import Path

def main():
    # Parse arguments
    model_name = sys.argv[1] if len(sys.argv) > 1 else "blackjack_table"
    object_prefix = sys.argv[2] if len(sys.argv) > 2 else "BJ_"
    destination = sys.argv[3] if len(sys.argv) > 3 else "Workspace"
    auto_commit = "--commit" in sys.argv
    skip_export = "--skip-export" in sys.argv
    
    if destination not in ["Workspace", "ReplicatedStorage"]:
        destination = "Workspace"
    
    repo_root = Path(__file__).parent
    
    # Determine paths
    if destination == "Workspace":
        models_dir = repo_root / "assets" / "workspace_models"
        target_location = "Workspace > Models"
    else:
        models_dir = repo_root / "assets" / "models"
        target_location = "ReplicatedStorage > Assets > Models"
    
    models_dir.mkdir(parents=True, exist_ok=True)
    
    fbx_path = models_dir / f"{model_name}.fbx"
    rbxm_path = models_dir / f"{model_name}.rbxm"
    
    def print_step(message, color_code=36):
        print(f"\n{'='*60}")
        print(f"\033[{color_code}m{message}\033[0m")
        print(f"{'='*60}\n")
    
    # STEP 1: Export from Blender
    print_step("STEP 1: Exporting from Blender", 36)
    
    if not skip_export:
        if fbx_path.exists():
            print(f"✓ FBX file found: {fbx_path}")
        else:
            print(f"✗ FBX file not found: {fbx_path}")
            print("\nExport from Blender:")
            print(f"  1. Select all objects starting with '{object_prefix}'")
            print(f"  2. File > Export > FBX (.fbx)")
            print(f"  3. Save to: {fbx_path}")
            print("\nWaiting for FBX file... (or press Ctrl+C to skip)")
            max_wait = 300
            start = time.time()
            while not fbx_path.exists():
                if time.time() - start > max_wait:
                    print("Timeout. Please export manually and run again with --skip-export")
                    sys.exit(1)
                time.sleep(2)
            print("✓ FBX file found!")
    else:
        if not fbx_path.exists():
            print(f"✗ FBX file not found: {fbx_path}")
            sys.exit(1)
        print(f"✓ Using existing FBX: {fbx_path}")
    
    # STEP 2: Commit to Git
    print_step("STEP 2: Committing to Git", 36)
    
    try:
        subprocess.run(["git", "add", str(fbx_path)], check=True, cwd=repo_root, 
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        if auto_commit:
            subprocess.run(["git", "commit", "-m", f"Export {model_name} from Blender"], 
                          check=True, cwd=repo_root, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            subprocess.run(["git", "push"], check=True, cwd=repo_root, 
                          stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            print("✓ Committed and pushed to GitHub")
        else:
            print(f"✓ File staged. Commit with: git commit -m 'Export {model_name} from Blender'")
    except (subprocess.CalledProcessError, FileNotFoundError):
        print("⚠ Git operation skipped")
    
    # STEP 3: Convert to .rbxm
    print_step("STEP 3: Converting FBX to .rbxm", 36)
    
    if rbxm_path.exists():
        response = input(f"File exists: {rbxm_path}. Overwrite? (y/n): ")
        if response.lower() != 'y':
            print("Using existing .rbxm file")
        else:
            rbxm_path.unlink()
    
    if not rbxm_path.exists():
        print("="*60)
        print("CONVERSION INSTRUCTIONS:")
        print("="*60)
        print("1. Open Roblox Studio")
        print("2. Make sure Rojo is connected (localhost:34872)")
        print(f"3. Go to {target_location}")
        print("4. Drag and drop this file:")
        print(f"   {fbx_path.resolve()}")
        print("5. Wait for import")
        print("6. Right-click model > Export Selection...")
        print(f"7. Save as: {rbxm_path.resolve()}")
        print("="*60 + "\n")
        
        # Try to open Studio
        studio_paths = [
            Path.home() / "AppData" / "Local" / "Roblox" / "Versions",
            Path("C:/Program Files (x86)/Roblox/Versions"),
        ]
        
        studio_exe = None
        for base in studio_paths:
            if base.exists():
                for folder in base.iterdir():
                    exe = folder / "RobloxStudioBeta.exe"
                    if exe.exists():
                        studio_exe = exe
                        break
                if studio_exe:
                    break
        
        if studio_exe:
            try:
                import psutil
                studio_running = any("RobloxStudio" in p.name() for p in psutil.process_iter())
                if not studio_running:
                    print("Opening Roblox Studio...")
                    subprocess.Popen([str(studio_exe)])
                    time.sleep(3)
            except:
                pass
        
        print(f"\nWaiting for {model_name}.rbxm...")
        print("Complete import/export in Studio, then press Enter when done.\n")
        
        max_wait = 600
        start = time.time()
        try:
            while not rbxm_path.exists():
                if time.time() - start > max_wait:
                    print("\nTimeout. Please complete conversion manually.")
                    sys.exit(1)
                time.sleep(2)
                print(".", end="", flush=True)
            print(f"\n✓ File created: {rbxm_path}")
        except KeyboardInterrupt:
            print("\nCancelled.")
            sys.exit(1)
    
    # STEP 4: Commit .rbxm
    print_step("STEP 4: Committing .rbxm and Syncing", 36)
    
    try:
        subprocess.run(["git", "add", str(rbxm_path)], check=True, cwd=repo_root,
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        if auto_commit:
            subprocess.run(["git", "commit", "-m", f"Add {model_name} to {destination}"],
                          check=True, cwd=repo_root, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            subprocess.run(["git", "push"], check=True, cwd=repo_root,
                          stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            print("✓ Committed and pushed to GitHub")
        else:
            print(f"✓ File staged. Commit with: git commit -m 'Add {model_name} to {destination}'")
    except (subprocess.CalledProcessError, FileNotFoundError):
        print("⚠ Git operation skipped")
    
    # Check Rojo
    try:
        import socket
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        result = sock.connect_ex(('localhost', 34872))
        sock.close()
        if result == 0:
            print("✓ Rojo is running")
            print("\nNOTE: .rbxm files don't auto-sync via Rojo.")
            print(f"Drag the file into Studio's {target_location} to import it.")
            print(f"File location: {rbxm_path.resolve()}")
        else:
            print("⚠ Rojo is not running. Start with: rojo serve")
    except:
        pass
    
    print_step("WORKFLOW COMPLETE!", 32)
    print(f"Model: {model_name}")
    print(f"FBX: {fbx_path}")
    print(f".rbxm: {rbxm_path}")
    print(f"Destination: {target_location}")

if __name__ == "__main__":
    try:
        import psutil
    except ImportError:
        subprocess.check_call([sys.executable, "-m", "pip", "install", "psutil", "-q"])
        import psutil
    
    main()
