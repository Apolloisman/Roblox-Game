# Roblox Game Development Workflow

Complete automation pipeline for Blender and Fusion 360 models to Roblox Studio with GitHub integration.

## Quick Start

### Single Unified Workflow

```powershell
# From Blender
.\model_to_roblox.ps1 -Source blender -ModelName "my_model" -ObjectPrefix "MY_" -AutoCommit

# From Fusion 360
.\model_to_roblox.ps1 -Source fusion360 -ModelName "my_model" -AutoCommit

# From existing FBX
.\model_to_roblox.ps1 -Source manual -ModelName "my_model" -SkipExport -AutoCommit
```

## Features

- **Unified workflow** - One script handles all sources (Blender, Fusion 360, manual)
- **Auto Git integration** - Automatically commits and pushes to GitHub
- **Rojo sync** - Integrates with Rojo for Studio synchronization
- **Multiple destinations** - Workspace or ReplicatedStorage
- **Error handling** - Robust error checking and user guidance

## Prerequisites

- Roblox Studio installed
- Rojo server running (`C:\Users\Tyler\Tools\rojo\rojo.exe serve`)
- Git configured
- Rojo plugin installed in Studio and connected

### For Blender
- Blender installed
- Blender MCP server configured (already set up)

### For Fusion 360
- Fusion 360 installed
- Run `.\setup_fusion360_mcp.ps1` first
- Fusion 360 MCP add-in installed

## Workflow

```
Source (Blender/Fusion360/Manual)
    ↓
Export as FBX
    ↓
Commit to Git (auto)
    ↓
Convert to .rbxm
    ↓
Commit to Git (auto)
    ↓
Roblox Studio
```

## Parameters

- `-ModelName`: Name of the model (default: "model")
- `-Source`: Source type - "blender", "fusion360", or "manual" (default: "blender")
- `-ObjectPrefix`: Prefix for Blender objects (default: empty)
- `-Destination`: "Workspace" or "ReplicatedStorage" (default: "Workspace")
- `-AutoCommit`: Automatically commit and push to GitHub
- `-SkipExport`: Skip export step (use existing FBX)

## Examples

```powershell
# Blender model to Workspace
.\model_to_roblox.ps1 -Source blender -ModelName "tree" -ObjectPrefix "TREE_" -AutoCommit

# Fusion 360 model to ReplicatedStorage
.\model_to_roblox.ps1 -Source fusion360 -ModelName "gear" -Destination ReplicatedStorage -AutoCommit

# Manual FBX file
.\model_to_roblox.ps1 -Source manual -ModelName "imported_model" -SkipExport -AutoCommit
```

## File Structure

```
okAPI/
├── model_to_roblox.ps1          # Main unified workflow script
├── blender_to_roblox.py         # Python alternative
├── fusion360_control.py          # Fusion 360 MCP interface
├── setup_fusion360_mcp.ps1      # Fusion 360 setup
├── start_fusion_mcp_server.bat  # MCP server startup
├── assets/
│   ├── models/                  # ReplicatedStorage models
│   └── workspace_models/         # Workspace models
└── src/                          # Game scripts
```

## Troubleshooting

### Rojo not running
```powershell
C:\Users\Tyler\Tools\rojo\rojo.exe serve
```

### Fusion 360 MCP not working
1. Run `.\setup_fusion360_mcp.ps1`
2. Install add-in in Fusion 360
3. Start server: `.\start_fusion_mcp_server.bat`
4. Connect in Fusion 360

### Model not appearing in Studio
- .rbxm files don't auto-sync via Rojo
- Manually drag the .rbxm file into Studio's Workspace or ReplicatedStorage

## Documentation

- `ROBLOX_WORKFLOW.md` - Basic Roblox + GitHub workflow
- `BLENDER_TO_ROBLOX_README.md` - Blender-specific details
- `FUSION360_MCP_SETUP.md` - Fusion 360 MCP setup guide

