# Blender to Roblox Workflow

Complete automation script to export models from Blender, commit to GitHub, convert to .rbxm, and sync to Roblox Studio.

## Quick Start

### PowerShell (Recommended for Windows)

```powershell
cd C:\Users\Tyler\okAPI
.\blender_to_roblox.ps1 -ModelName "blackjack_table" -BlenderObjectPrefix "BJ_" -AutoCommit
```

### Python

```bash
cd C:\Users\Tyler\okAPI
python blender_to_roblox.py blackjack_table BJ_ --commit
```

## Parameters

- `-ModelName` / `model_name`: Name of the model (default: "blackjack_table")
- `-BlenderObjectPrefix` / `object_prefix`: Prefix for Blender objects to export (default: "BJ_")
- `-AutoCommit`: Automatically commit and push to Git (optional)
- `-SkipBlenderExport`: Skip Blender export step (if FBX already exists)
- `-SkipGit`: Skip Git operations

## Workflow Steps

1. **Export from Blender**: Exports all objects with the specified prefix to FBX
2. **Commit to Git**: Stages and commits the FBX file to GitHub
3. **Convert to .rbxm**: Guides you through importing FBX into Roblox Studio and exporting as .rbxm
4. **Sync to Studio**: The .rbxm file automatically syncs to Studio via Rojo

## Prerequisites

- Blender installed and running (for export)
- Roblox Studio installed
- Rojo server running (`rojo serve` or `C:\Users\Tyler\Tools\rojo\rojo.exe serve`)
- Git configured
- Rojo plugin installed in Roblox Studio and connected

## Manual Steps

If automation fails, you can complete steps manually:

1. **Export from Blender**:
   - Select all objects with your prefix (e.g., "BJ_")
   - File > Export > FBX (.fbx)
   - Save to `assets/models/your_model.fbx`

2. **Commit to Git**:
   ```powershell
   git add assets/models/your_model.fbx
   git commit -m "Export your_model from Blender"
   git push
   ```

3. **Convert to .rbxm**:
   - Open Roblox Studio
   - Make sure Rojo is connected
   - Navigate to: ReplicatedStorage > Assets > Models
   - Drag and drop the FBX file into Studio
   - Right-click imported model > Export Selection...
   - Save as `assets/models/your_model.rbxm`

4. **Commit .rbxm**:
   ```powershell
   git add assets/models/your_model.rbxm
   git commit -m "Add your_model as Roblox model"
   git push
   ```

The .rbxm file will automatically sync to Studio via Rojo!

## Troubleshooting

### Rojo not running
```powershell
C:\Users\Tyler\Tools\rojo\rojo.exe serve
```

### Blender export not working
- Make sure Blender is running
- Check that objects have the correct prefix
- Export manually from Blender if needed

### Studio import fails
- Make sure Rojo plugin is connected (localhost:34872)
- Check that the Models folder exists in ReplicatedStorage > Assets
- Try restarting Studio and reconnecting Rojo

## Files

- `blender_to_roblox.ps1` - Main PowerShell workflow script
- `blender_to_roblox.py` - Python version of workflow script
- `export_blender_model.py` - Blender export helper (for MCP integration)
- `convert_fbx_to_rbxm.ps1` - Standalone FBX to .rbxm converter
- `convert_fbx_to_rbxm.py` - Python version of converter

