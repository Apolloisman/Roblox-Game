# Fusion 360 MCP Server Setup & Auto-Upload to GitHub

Complete guide to set up Fusion 360 MCP Server and automate uploads to GitHub and Roblox.

## Overview

The Fusion 360 MCP Server allows you to control Fusion 360 remotely and automate the export workflow. This integrates with your existing Blender → Roblox pipeline.

## Installation Steps

### 1. Install Fusion 360 Add-in

1. **Locate Fusion 360 AddIns directory:**
   - Usually: `C:\Users\YourName\AppData\Roaming\Autodesk\Autodesk Fusion 360\API\AddIns`
   - Or: `C:\Users\YourName\AppData\Local\Autodesk\Autodesk Fusion 360\API\AddIns`

2. **Copy the Fusion MCP Server files:**
   - Copy the entire `Fusion-MCP-Server` folder to the AddIns directory
   - Make sure `fusion360_mcp_addin.py`, `client.py`, and `resources` folder are included

3. **Load the add-in in Fusion 360:**
   - Open Fusion 360
   - Press `Shift+S` (or go to Utilities → Scripts and Add-ins)
   - Go to "Add-ins" tab
   - Click "Load from my computer" (or "Load from Device")
   - Select the `Fusion-MCP-Server` folder
   - Click "Run" (or enable "Run on Startup")

### 2. Start the MCP Server

**Option A: Use the startup script**
```powershell
.\start_fusion_mcp_server.bat
```

**Option B: Manual start**
```powershell
cd C:\Users\Tyler\Fusion-MCP-Server
python server.py
```

The server will run on `127.0.0.1:8080`

### 3. Connect Fusion 360 to the Server

1. In Fusion 360, look for the **"MCP Controls"** panel
2. Click **"Connect to MCP Server"**
3. Enter:
   - Host: `127.0.0.1`
   - Port: `8080`
4. Click OK
5. You should see a confirmation message

### 4. Run Setup Script

```powershell
.\setup_fusion360_mcp.ps1
```

This will:
- Verify the MCP server is installed
- Create startup scripts
- Set up the control interface

## Usage

### Automated Workflow

```powershell
# Basic usage
.\fusion360_to_roblox_auto.ps1 -ModelName "my_model" -AutoCommit

# With destination
.\fusion360_to_roblox_auto.ps1 -ModelName "my_model" -Destination "Workspace" -AutoCommit
```

### What It Does

1. **Connects to Fusion 360** via MCP server
2. **Exports model** as STEP file
3. **Converts STEP to FBX** (via Blender)
4. **Commits to GitHub** automatically
5. **Converts to .rbxm** using your existing workflow
6. **Uploads to Roblox Studio**

## Workflow Diagram

```
Fusion 360 (Parametric Design)
    ↓ MCP Server Control
Export as STEP
    ↓
Blender (Import & Optimize)
    ↓
Export as FBX
    ↓
Git Commit (Auto)
    ↓
Convert to .rbxm
    ↓
Roblox Studio
```

## Troubleshooting

### MCP Server won't start
- Make sure Python 3.6+ is installed
- Check if port 8080 is already in use
- Run: `python C:\Users\Tyler\Fusion-MCP-Server\server.py`

### Fusion 360 won't connect
- Make sure the add-in is loaded (Shift+S → Add-ins)
- Check that the add-in is running
- Verify server is running on port 8080
- Try restarting Fusion 360

### Export commands not working
- The MCP server may need custom export commands
- Check `fusion360_mcp_addin.py` for available commands
- You may need to add export functionality to the add-in

### STEP to FBX conversion
- Currently requires manual Blender import/export
- Future: Can be automated with Blender MCP
- Or use command-line tools like Open3D or MeshLab

## Files

- `setup_fusion360_mcp.ps1` - Initial setup script
- `fusion360_to_roblox_auto.ps1` - Main automated workflow
- `start_fusion_mcp_server.bat` - Server startup script (created by setup)
- `fusion360_control.py` - Python control interface (created by setup)
- `FUSION360_MCP_SETUP.md` - This guide

## Next Steps

1. **Customize export commands** in `fusion360_mcp_addin.py` if needed
2. **Automate STEP → FBX** conversion using Blender MCP
3. **Add parametric model generation** via MCP commands
4. **Create model variants** automatically from parameters

## Notes

- The Fusion 360 MCP Server uses a custom TCP protocol (not standard MCP)
- Export commands may need to be customized based on your needs
- STEP files need conversion to FBX for Roblox compatibility
- All exports are automatically committed to GitHub when using `-AutoCommit`

