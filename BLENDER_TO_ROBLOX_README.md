# Blender to Roblox Workflow

**Streamlined automation** - One script handles everything: Export from Blender → Git → Convert to .rbxm → Sync to Studio

## Quick Start

### PowerShell (Windows - Recommended)

```powershell
# Basic usage
.\blender_to_roblox.ps1

# With options
.\blender_to_roblox.ps1 -ModelName "my_model" -ObjectPrefix "MY_" -Destination "Workspace" -AutoCommit
```

### Python (Cross-platform)

```bash
# Basic usage
python blender_to_roblox.py

# With options
python blender_to_roblox.py my_model MY_ Workspace --commit
```

## Parameters

- `-ModelName` / `model_name`: Name of the model (default: "model")
- `-ObjectPrefix` / `object_prefix`: Prefix for Blender objects to export (default: "MODEL_")
- `-Destination`: Where to place model - "Workspace" or "ReplicatedStorage" (default: "Workspace")
- `-AutoCommit` / `--commit`: Automatically commit and push to Git
- `-SkipBlenderExport` / `--skip-export`: Skip Blender export step (if FBX already exists)

## Examples

```powershell
# Export model to Workspace with auto-commit
.\blender_to_roblox.ps1 -ModelName "my_model" -AutoCommit

# Export custom model to ReplicatedStorage
.\blender_to_roblox.ps1 -ModelName "weapon_model" -ObjectPrefix "WP_" -Destination "ReplicatedStorage"

# Skip Blender export (FBX already exists)
.\blender_to_roblox.ps1 -ModelName "my_model" -SkipBlenderExport
```

## Workflow Steps

The script automates:

1. **Export from Blender**: Checks for FBX file, waits if needed
2. **Commit to Git**: Stages and commits the FBX file
3. **Convert to .rbxm**: Guides you through importing FBX into Studio and exporting as .rbxm
4. **Sync to Studio**: Commits .rbxm and provides instructions for final import

## Prerequisites

- Blender (for export)
- Roblox Studio installed
- Rojo server running (`C:\Users\Tyler\Tools\rojo\rojo.exe serve`)
- Git configured
- Rojo plugin installed in Roblox Studio and connected

## Important Notes

- **.rbxm files don't auto-sync via Rojo** - You need to manually drag the .rbxm file into Studio's Workspace or ReplicatedStorage
- The script handles Git commits, but you can skip with `-AutoCommit` flag
- FBX files are stored in `assets/models/` or `assets/workspace_models/` based on destination

## Troubleshooting

### Rojo not running
```powershell
C:\Users\Tyler\Tools\rojo\rojo.exe serve
```

### Model not appearing in Studio
- Make sure you manually drag the .rbxm file into Studio
- Check that Rojo plugin is connected (localhost:34872)
- Verify the file exists in the correct `assets/` folder

### Blender export not working
- Export manually from Blender: File > Export > FBX
- Save to the correct `assets/` folder
- Run script with `-SkipBlenderExport` flag

## Files

- `blender_to_roblox.ps1` - Main PowerShell script (all-in-one)
- `blender_to_roblox.py` - Python version (all-in-one)

That's it! Just two files for the complete workflow.
