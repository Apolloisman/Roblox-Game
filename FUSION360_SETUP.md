# Fusion 360 Integration Setup

## Current Status

**Fusion 360 MCP does NOT exist** - Unlike Blender, there's no MCP server for Fusion 360.

## Available Solutions

### Option 1: Manual Export Workflow (Easiest)

1. **Export from Fusion 360:**
   - File → Export → FBX (if available) or STEP/STL
   - Save to: `assets/workspace_models/your_model.fbx`

2. **Use existing workflow:**
   ```powershell
   .\fusion360_to_roblox.ps1 -ModelName "your_model" -Destination "Workspace"
   ```

### Option 2: Fusion 360 Python Script

1. **Install the script in Fusion 360:**
   - Open Fusion 360
   - Tools → Add-Ins → Scripts → Create
   - Copy `fusion360_export_script.py` into the script
   - Run it to export automatically

2. **Note:** Fusion 360 doesn't export FBX natively
   - Export as STEP or STL
   - Import into Blender
   - Export from Blender as FBX

### Option 3: Hybrid Workflow

```
Fusion 360 (Parametric CAD)
    ↓ Export STEP/STL
Blender (Game Optimization)
    ↓ Export FBX
Your Workflow Script
    ↓ Convert to .rbxm
Roblox Studio
```

## Recommended Approach

**For parametric modeling:**
1. Design in Fusion 360 (parametric)
2. Export as STEP
3. Import to Blender (optimize for games)
4. Use Blender MCP to automate
5. Use your existing `blender_to_roblox.ps1` workflow

## Future Possibilities

If you want true Fusion 360 MCP integration, you would need to:
1. Create a custom MCP server using Fusion 360 API
2. This requires significant development work
3. Fusion 360 API is Python-based but limited compared to Blender

## Files

- `fusion360_to_roblox.ps1` - Workflow script for Fusion 360 exports
- `fusion360_export_script.py` - Python script to run inside Fusion 360
- `FUSION360_SETUP.md` - This file

