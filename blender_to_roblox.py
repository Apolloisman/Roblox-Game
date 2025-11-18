"""
Complete workflow: Blender -> GitHub -> Roblox Studio
Exports from Blender, commits to Git, converts to .rbxm, and syncs to Studio
"""

import os
import sys
import subprocess
import time
from pathlib import Path

def export_from_blender_mcp(object_prefix, output_path):
    """
    Export objects from Blender using MCP
    Note: This requires the Blender MCP server to be running
    """
    print("\n" + "="*60)
    print("STEP 1: Exporting from Blender")
    print("="*60 + "\n")
    
    print(f"Exporting objects with prefix '{object_prefix}'")
    print(f"Output: {output_path}")
    print("\nNote: Blender export via MCP requires manual setup.")
    print("For now, please export manually from Blender:")
    print(f"  1. Select all objects starting with '{object_prefix}'")
    print(f"  2. File > Export > FBX (.fbx)")
    print(f"  3. Save to: {output_path}\n")
    
    # Check if file exists
    if os.path.exists(output_path):
        print(f"✓ FBX file found: {output_path}")
        return output_path
    else:
        print(f"✗ FBX file not found: {output_path}")
        return None

def commit_to_git(file_path, commit_message, auto_commit=False):
    """Commit file to Git"""
    print("\n" + "="*60)
    print("STEP 2: Committing to Git")
    print("="*60 + "\n")
    
    if not os.path.exists(file_path):
        print(f"✗ File not found: {file_path}")
        return False
    
    try:
        repo_root = Path(file_path).parent.parent.parent
        print(f"Adding file to Git: {file_path}")
        subprocess.run(["git", "add", file_path], check=True, cwd=repo_root)
        
        if auto_commit:
            print("Committing changes...")
            subprocess.run(["git", "commit", "-m", commit_message], check=True, cwd=repo_root)
            print("Pushing to GitHub...")
            subprocess.run(["git", "push"], check=True, cwd=repo_root)
            print("✓ Successfully pushed to GitHub!")
        else:
            print("✓ File staged. Run:")
            print(f"  git commit -m '{commit_message}'")
            print("  git push")
        
        return True
    except subprocess.CalledProcessError as e:
        print(f"✗ Git operation failed: {e}")
        return False
    except FileNotFoundError:
        print("✗ Git not found. Please install Git.")
        return False

def find_roblox_studio():
    """Find Roblox Studio installation"""
    possible_paths = [
        os.path.expanduser(r"~\AppData\Local\Roblox\Versions"),
        r"C:\Program Files (x86)\Roblox\Versions",
        r"C:\Program Files\Roblox\Versions",
    ]
    
    for base_path in possible_paths:
        if os.path.exists(base_path):
            for folder in os.listdir(base_path):
                studio_exe = os.path.join(base_path, folder, "RobloxStudioBeta.exe")
                if os.path.exists(studio_exe):
                    return studio_exe
    
    return None

def convert_fbx_to_rbxm(fbx_path, output_dir):
    """Convert FBX to .rbxm format"""
    print("\n" + "="*60)
    print("STEP 3: Converting FBX to .rbxm")
    print("="*60 + "\n")
    
    fbx_path = Path(fbx_path).resolve()
    output_path = output_dir / f"{fbx_path.stem}.rbxm"
    
    print(f"Source: {fbx_path}")
    print(f"Target: {output_path}\n")
    
    # Check if already exists
    if output_path.exists():
        response = input(f"File already exists: {output_path}\nOverwrite? (y/n): ")
        if response.lower() != 'y':
            print("Using existing file.")
            return output_path
    
    # Find Roblox Studio
    studio_path = find_roblox_studio()
    if not studio_path:
        print("✗ Roblox Studio not found. Please install Roblox Studio.")
        return None
    
    print("\n" + "="*60)
    print("CONVERSION INSTRUCTIONS:")
    print("="*60 + "\n")
    print("1. Open Roblox Studio (if not already open)")
    print("2. Make sure Rojo is connected (localhost:34872)")
    print("3. Navigate to: ReplicatedStorage > Assets > Models")
    print("4. Drag and drop this file into Studio:")
    print(f"   {fbx_path}")
    print("5. Wait for import to complete")
    print("6. Right-click the imported model > 'Export Selection...'")
    print(f"7. Save as: {output_path}")
    print("="*60 + "\n")
    
    # Open Studio if not running
    studio_running = any("RobloxStudio" in p.name() for p in psutil.process_iter() if hasattr(p, 'name'))
    if not studio_running:
        print("Opening Roblox Studio...")
        try:
            subprocess.Popen([studio_path])
            time.sleep(5)
        except Exception as e:
            print(f"Could not open Studio: {e}")
    else:
        print("Roblox Studio is already running.")
    
    # Wait for file creation
    print("\nWaiting for conversion to complete...")
    print("Complete the import/export in Studio, then press Enter when done.")
    print("(Or press Ctrl+C to cancel)\n")
    
    max_wait = 600  # 10 minutes
    start_time = time.time()
    
    try:
        while not output_path.exists():
            if time.time() - start_time > max_wait:
                print("\n✗ Timeout: File was not created within 10 minutes.")
                return None
            
            # Check every 2 seconds
            time.sleep(2)
            print(".", end="", flush=True)
        
        print(f"\n\n✓ SUCCESS! File created: {output_path}")
        return output_path
        
    except KeyboardInterrupt:
        print("\n\nCancelled.")
        return None

def sync_to_studio(rbxm_path):
    """Sync .rbxm file to Studio via Rojo"""
    print("\n" + "="*60)
    print("STEP 4: Syncing to Roblox Studio via Rojo")
    print("="*60 + "\n")
    
    if not rbxm_path.exists():
        print(f"✗ File not found: {rbxm_path}")
        return False
    
    # Check if Rojo is running (port 34872)
    try:
        import socket
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        result = sock.connect_ex(('localhost', 34872))
        sock.close()
        
        if result == 0:
            print("✓ Rojo is running on port 34872")
            print("The .rbxm file will sync automatically to Studio when:")
            print("  1. Roblox Studio is open")
            print("  2. Rojo plugin is connected (localhost:34872)")
            print("  3. File is in the correct location")
            print(f"\nThe model will appear in: ReplicatedStorage > Assets > Models")
            return True
        else:
            print("✗ Rojo server is not running!")
            print("Start it with: rojo serve")
            return False
    except Exception as e:
        print(f"Could not check Rojo status: {e}")
        return False

def main():
    """Main workflow"""
    model_name = sys.argv[1] if len(sys.argv) > 1 else "blackjack_table"
    object_prefix = sys.argv[2] if len(sys.argv) > 2 else "BJ_"
    auto_commit = "--commit" in sys.argv
    
    repo_root = Path(__file__).parent
    output_dir = repo_root / "assets" / "models"
    output_dir.mkdir(parents=True, exist_ok=True)
    
    fbx_path = output_dir / f"{model_name}.fbx"
    rbxm_path = None
    
    print("\n" + "="*60)
    print("  BLENDER TO ROBLOX WORKFLOW")
    print("="*60)
    print(f"Model: {model_name}")
    print(f"Object Prefix: {object_prefix}")
    print(f"Output: {output_dir}\n")
    
    # Step 1: Export from Blender
    exported_path = export_from_blender_mcp(object_prefix, fbx_path)
    if not exported_path:
        print("\n✗ Cannot proceed without FBX file. Please export from Blender first.")
        sys.exit(1)
    
    # Step 2: Commit to Git
    commit_to_git(fbx_path, f"Export {model_name} from Blender", auto_commit)
    
    # Step 3: Convert to .rbxm
    rbxm_path = convert_fbx_to_rbxm(fbx_path, output_dir)
    if not rbxm_path:
        print("\n✗ Conversion failed or cancelled.")
        sys.exit(1)
    
    # Step 4: Commit .rbxm to Git
    commit_to_git(rbxm_path, f"Add {model_name} as Roblox model (.rbxm)", auto_commit)
    
    # Step 5: Sync to Studio
    sync_to_studio(rbxm_path)
    
    print("\n" + "="*60)
    print("  WORKFLOW COMPLETE!")
    print("="*60)
    print(f"FBX: {fbx_path}")
    print(f".rbxm: {rbxm_path}")
    print("\nThe model should now be available in Roblox Studio!")

if __name__ == "__main__":
    try:
        import psutil
    except ImportError:
        print("Installing psutil for process checking...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", "psutil"])
        import psutil
    
    main()

