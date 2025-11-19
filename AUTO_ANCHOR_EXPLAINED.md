# Auto-Anchor Models Explained

## What Happens When You Create .rbxm Files

When you convert FBX to .rbxm in Roblox Studio, the exported .rbxm file will have:
- ✅ **Anchored = true** on all parts (if AnchorAllModels.server.lua is running)
- ✅ **CanCollide = true** on all parts
- ✅ Appropriate materials set

## How It Works

### Step 1: Import FBX
1. Drag FBX into Studio
2. Model appears in Workspace
3. **AnchorAllModels.server.lua** detects the new model
4. Automatically anchors all parts

### Step 2: Export as .rbxm
1. Right-click model → Export Selection
2. Save as .rbxm
3. **The .rbxm file includes all properties** (Anchored, CanCollide, etc.)
4. Future imports of this .rbxm will have these properties!

## Properties Set Automatically

| Property | Value | Why |
|----------|-------|-----|
| `Anchored` | `true` | Prevents models from falling |
| `CanCollide` | `true` | Models collide with players |
| `Material` | Based on name | Ground → Grass, Roof → Metal, etc. |

## What This Means

**Before:**
- Import FBX → Model falls
- Manually anchor each part
- Export .rbxm → Still need to anchor

**After:**
- Import FBX → Auto-anchored ✅
- Export .rbxm → Properties saved ✅
- Import .rbxm later → Still anchored ✅

## The Script

`studio_setup/AnchorAllModels.server.lua` does this automatically:
- Anchors existing models on startup
- Anchors new models when added
- Sets other useful properties

**Keep it in ServerScriptService** - it makes your workflow seamless!

## Summary

✅ Models are automatically anchored when imported  
✅ Exported .rbxm files include all properties  
✅ No manual work needed  
✅ Works for all future models too  

**Just place the script in ServerScriptService and forget about it!** 🚀

