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
- **Rojo sync** - Code and images auto-sync to Roblox Studio instantly
- **Multiple destinations** - Workspace or ReplicatedStorage
- **Error handling** - Robust error checking and user guidance
- **Quick commits** - Use `.\auto_commit.ps1` for easy Git commits

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

## Project Structure

```
okAPI/
├── 📄 Scripts & Tools
│   ├── model_to_roblox.ps1          # Main unified workflow script
│   ├── model_to_roblox.py            # Python alternative
│   ├── auto_commit.ps1               # Quick Git commit helper
│   ├── search_roblox_store.ps1      # Roblox store search helper
│   ├── figma_to_roblox.ps1           # Figma export workflow
│   ├── fusion360_control.py          # Fusion 360 MCP interface
│   ├── setup_fusion360_mcp.ps1      # Fusion 360 setup
│   └── start_fusion_mcp_server.bat  # MCP server startup
│
├── 📁 assets/                        # All game assets
│   ├── animations/                   # Animation files (see README.md)
│   ├── models/                       # ReplicatedStorage models (see README.md)
│   ├── sounds/                       # Audio files (see README.md)
│   ├── textures/                     # Texture files (see README.md)
│   ├── ui/                           # UI assets (see README.md)
│   └── workspace_models/              # Workspace models (see README.md)
│
├── 📁 src/                           # Game source code
│   ├── client/                       # Client scripts (see README.md)
│   │   └── ui/                       # UI scripts (see README.md)
│   ├── server/                       # Server scripts (see README.md)
│   └── shared/                       # Shared modules (see README.md)
│
└── 📚 Documentation
    ├── README.md                     # This file
    ├── WORKFLOW_EXPLAINED.md         # Complete workflow guide
    ├── ROBLOX_WORKFLOW.md            # Basic Roblox workflow
    ├── UI_TOOLS_INTEGRATION.md       # Design tools integration
    ├── ROBLOX_STORE_GUIDE.md         # Roblox store guide
    └── [folder]/README.md            # Each folder has its own README
```

**📖 Every folder has a README.md with detailed descriptions!**

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

## Code & Images Auto-Sync

**Important:** Code (`.lua`) and images (`.png`, `.jpg`) **auto-sync to Roblox Studio** via Rojo when you save files. They do NOT auto-commit to Git.

**Quick commit helper:**
```powershell
# Commit and push everything
.\auto_commit.ps1 -Message "Add new feature" -Push

# Just commit (don't push)
.\auto_commit.ps1 -Message "Update UI"
```

**Workflow:**
1. Edit code/images → **Auto-syncs to Studio** ✨
2. Test in Studio
3. Commit when ready → `.\auto_commit.ps1 -Push`

See `WORKFLOW_EXPLAINED.md` for detailed workflow information.

## Documentation

### 📚 Main Guides
- `WORKFLOW_EXPLAINED.md` - **Start here!** Complete workflow explanation
- `ROBLOX_WORKFLOW.md` - Basic Roblox + GitHub workflow
- `UI_TOOLS_INTEGRATION.md` - Figma, Cursor, and design tools integration
- `ROBLOX_STORE_GUIDE.md` - How to find and import models from Roblox store

### 🛠️ Setup Guides
- `BLENDER_TO_ROBLOX_README.md` - Blender-specific details
- `FUSION360_MCP_SETUP.md` - Fusion 360 MCP setup guide

### 📁 Folder Documentation
Each folder has its own README.md with detailed descriptions:
- `assets/README.md` - Assets overview
- `assets/animations/README.md` - Animation files
- `assets/models/README.md` - ReplicatedStorage models
- `assets/workspace_models/README.md` - Workspace models
- `assets/sounds/README.md` - Audio files
- `assets/textures/README.md` - Texture files
- `assets/ui/README.md` - UI assets guide
- `assets/ui/ORGANIZATION.md` - UI organization guide
- `src/README.md` - Source code overview
- `src/client/README.md` - Client scripts
- `src/server/README.md` - Server scripts
- `src/shared/README.md` - Shared modules
- `src/client/ui/README.md` - UI scripts

