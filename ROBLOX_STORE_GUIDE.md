# Roblox Creator Store Integration Guide

How to find and import models from the Roblox Creator Store into your project.

## Quick Search

Use the helper script to search for models:

```powershell
# Search for landscape models
.\search_roblox_store.ps1 -SearchTerm "trees" -Category landscape -OpenInBrowser

# Search for buildings
.\search_roblox_store.ps1 -SearchTerm "house" -Category buildings -OpenInBrowser

# Search all categories
.\search_roblox_store.ps1 -SearchTerm "furniture" -Category all -OpenInBrowser
```

## Available Categories

- `landscape` - Trees, rocks, terrain
- `buildings` - Structures, houses, architecture
- `vehicles` - Cars, planes, boats
- `characters` - NPCs, avatars
- `props` - Objects, items
- `decorations` - Decorative items
- `all` - Search all categories

## How to Import Models

### Method 1: Direct Import (Recommended for Testing)

1. **Find the model:**
   - Use `.\search_roblox_store.ps1` to open the store
   - Search for what you need
   - Click on a model

2. **Get the model:**
   - Click "Get" (free) or "Buy" (paid)
   - Model is added to your inventory

3. **Import into Studio:**
   - Open Roblox Studio
   - Go to **View → Toolbox**
   - Click **Inventory** tab
   - Find your model
   - Drag it into Workspace or wherever you need it

### Method 2: Track in Git (Recommended for Production)

If you want to version control the model:

1. **Import model** (steps 1-3 from Method 1)

2. **Export to file:**
   - In Studio, find the model in Explorer
   - Right-click → **Save to File**
   - Save as `.rbxm` to:
     - `assets/workspace_models/` (for Workspace models)
     - `assets/models/` (for ReplicatedStorage models)

3. **Commit to Git:**
   ```powershell
   .\auto_commit.ps1 -Message "Add [model name] from store" -Push
   ```

4. **Future imports:**
   - Just drag the `.rbxm` file into Studio
   - No need to re-download from store

## Store Categories Reference

### Landscape Models
- Trees, bushes, plants
- Rocks, boulders
- Terrain pieces
- Nature props

**URL:** https://create.roblox.com/store/models/categories/landscape

### Building Models
- Houses, buildings
- Structures, architecture
- Walls, floors, roofs

**URL:** https://create.roblox.com/store/models/categories/buildings

### Vehicle Models
- Cars, trucks
- Planes, helicopters
- Boats, ships

**URL:** https://create.roblox.com/store/models/categories/vehicles

## Workflow Integration

### Finding Models for Your Game

1. **Plan what you need:**
   - List required assets (e.g., "trees", "furniture", "vehicles")

2. **Search the store:**
   ```powershell
   .\search_roblox_store.ps1 -SearchTerm "trees" -Category landscape -OpenInBrowser
   ```

3. **Import and test:**
   - Import into Studio
   - Test in your game
   - Adjust as needed

4. **Save to Git (optional):**
   - Export as `.rbxm`
   - Commit to repository

### Example: Adding Trees to Your Game

```powershell
# 1. Search for trees
.\search_roblox_store.ps1 -SearchTerm "oak tree" -Category landscape -OpenInBrowser

# 2. Import into Studio (manual steps above)

# 3. Export to file
# Right-click model → Save to File → assets/workspace_models/tree_oak.rbxm

# 4. Commit
.\auto_commit.ps1 -Message "Add oak tree from store" -Push
```

## Limitations

**What I CAN do:**
- ✅ Search the web for model information
- ✅ Help you find models by category/name
- ✅ Guide you through import process
- ✅ Help organize models in your project

**What I CANNOT do:**
- ❌ Directly browse the store in real-time
- ❌ Automatically download models (requires authentication)
- ❌ Purchase models for you
- ❌ Access your Roblox inventory directly

## Tips

1. **Free vs Paid:**
   - Many models are free
   - Paid models support creators
   - Check license terms

2. **Model Quality:**
   - Check ratings and reviews
   - Preview models before importing
   - Test performance in your game

3. **Organization:**
   - Save imported models as `.rbxm` files
   - Organize by category in `assets/`
   - Commit to Git for version control

4. **Customization:**
   - Models can be modified in Studio
   - Save modified versions separately
   - Document changes in commit messages

## Related Tools

- `model_to_roblox.ps1` - Import models from Blender/Fusion 360
- `auto_commit.ps1` - Quick Git commits
- `WORKFLOW_EXPLAINED.md` - Complete workflow guide

## Store Links

- **Main Store:** https://create.roblox.com/store
- **Landscape:** https://create.roblox.com/store/models/categories/landscape
- **Buildings:** https://create.roblox.com/store/models/categories/buildings
- **Vehicles:** https://create.roblox.com/store/models/categories/vehicles
- **All Categories:** https://create.roblox.com/store/models

