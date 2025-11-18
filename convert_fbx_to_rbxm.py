"""
Script to convert FBX files to Roblox .rbxm format
This script automates the import/export process using Roblox Studio
"""

import os
import sys
import time
import subprocess
from pathlib import Path

def find_roblox_studio():
    """Find Roblox Studio installation path"""
    possible_paths = [
        r"C:\Program Files (x86)\Roblox\Versions\RobloxStudioBeta.exe",
        r"C:\Program Files\Roblox\Versions\RobloxStudioBeta.exe",
        r"C:\Users\{}\AppData\Local\Roblox\Versions\RobloxStudioBeta.exe".format(os.getenv('USERNAME')),
    ]
    
    for path in possible_paths:
        if os.path.exists(path):
            return path
    
    # Try to find it in common version folders
    version_dirs = [
        r"C:\Program Files (x86)\Roblox\Versions",
        r"C:\Users\{}\AppData\Local\Roblox\Versions".format(os.getenv('USERNAME')),
    ]
    
    for version_dir in version_dirs:
        if os.path.exists(version_dir):
            for folder in os.listdir(version_dir):
                studio_path = os.path.join(version_dir, folder, "RobloxStudioBeta.exe")
                if os.path.exists(studio_path):
                    return studio_path
    
    return None

def convert_fbx_to_rbxm(fbx_path, output_dir=None):
    """
    Convert FBX file to .rbxm format
    This requires manual steps in Roblox Studio, but the script provides guidance
    """
    fbx_path = Path(fbx_path).resolve()
    
    if not fbx_path.exists():
        print(f"Error: FBX file not found: {fbx_path}")
        return False
    
    if output_dir is None:
        output_dir = fbx_path.parent
    else:
        output_dir = Path(output_dir)
        output_dir.mkdir(parents=True, exist_ok=True)
    
    output_path = output_dir / f"{fbx_path.stem}.rbxm"
    
    print(f"Converting: {fbx_path.name} -> {output_path.name}")
    print("\n" + "="*60)
    print("AUTOMATED CONVERSION INSTRUCTIONS:")
    print("="*60)
    print("\n1. Open Roblox Studio")
    print("2. Make sure Rojo is connected (localhost:34872)")
    print("3. Navigate to: ReplicatedStorage > Assets > Models")
    print("4. Right-click on 'Models' folder")
    print("5. Select 'Import from file...'")
    print(f"6. Select: {fbx_path}")
    print("7. Wait for import to complete")
    print("8. Right-click on the imported model")
    print("9. Select 'Export Selection...'")
    print(f"10. Save as: {output_path}")
    print("\n" + "="*60)
    print("\nAlternatively, you can:")
    print("1. Drag and drop the FBX file directly into Roblox Studio")
    print("2. It will import automatically")
    print("3. Then export it as .rbxm")
    print("\n" + "="*60)
    
    # Try to open Roblox Studio
    studio_path = find_roblox_studio()
    if studio_path:
        print(f"\nOpening Roblox Studio...")
        try:
            subprocess.Popen([studio_path])
            print("Roblox Studio should open shortly.")
            print("Follow the instructions above to complete the conversion.")
        except Exception as e:
            print(f"Could not open Roblox Studio automatically: {e}")
            print("Please open Roblox Studio manually and follow the instructions.")
    else:
        print("\nCould not find Roblox Studio installation.")
        print("Please open Roblox Studio manually and follow the instructions above.")
    
    # Wait and check if file was created
    print(f"\nWaiting for {output_path.name} to be created...")
    print("(Press Ctrl+C to cancel)")
    
    max_wait = 300  # 5 minutes
    start_time = time.time()
    
    try:
        while not output_path.exists():
            if time.time() - start_time > max_wait:
                print("\nTimeout: File was not created within 5 minutes.")
                print("Please complete the conversion manually.")
                return False
            time.sleep(2)
            print(".", end="", flush=True)
        
        print(f"\n\nSuccess! {output_path.name} has been created!")
        
        # Add to git
        print("\nAdding to Git...")
        try:
            subprocess.run(["git", "add", str(output_path)], check=True, cwd=output_dir.parent.parent)
            print("File staged for commit.")
            print(f"Run: git commit -m 'Add {output_path.name}'")
            print(f"Then: git push")
        except subprocess.CalledProcessError:
            print("Git add failed. You can add it manually later.")
        except FileNotFoundError:
            print("Git not found. Add the file manually later.")
        
        return True
        
    except KeyboardInterrupt:
        print("\n\nCancelled. You can complete the conversion manually.")
        return False

def main():
    """Main entry point"""
    if len(sys.argv) < 2:
        # Default to blackjack table if no argument
        fbx_file = Path("assets/models/blackjack_table.fbx")
        if fbx_file.exists():
            print(f"Using default file: {fbx_file}")
        else:
            print("Usage: python convert_fbx_to_rbxm.py <path_to_fbx_file>")
            print(f"Or place an FBX file at: {fbx_file}")
            return
    else:
        fbx_file = Path(sys.argv[1])
    
    convert_fbx_to_rbxm(fbx_file)

if __name__ == "__main__":
    main()

