# Studio Setup Scripts

Helper scripts for setting up your game in Roblox Studio.

## Auto-Anchor Script

### AnchorAllModels.server.lua

**What it does:**
- Automatically anchors all parts in all models (prevents falling)
- Sets CanCollide = true on all parts
- Sets appropriate materials based on part names
- Auto-anchors new models when they're added to Workspace

**How to use:**
1. Copy `AnchorAllModels.server.lua` to **ServerScriptService**
2. The script runs automatically when you play
3. All models (existing and new) will be anchored automatically

**What gets anchored:**
- ✅ All parts in all models
- ✅ New models added to Workspace
- ✅ Individual parts added to Workspace

**Properties set:**
- `Anchored = true` (prevents falling)
- `CanCollide = true` (models collide with players)
- Materials set based on part names (Ground/Platform → Grass, Roof → Metal, etc.)

## Why This Script?

When you import models from Blender:
- Parts are **not anchored** by default
- They fall due to gravity
- You'd have to manually anchor each part

**This script fixes that automatically!** 🎉

## Usage

1. **Place script in ServerScriptService** (via Rojo sync)
2. **Import your models** from Blender
3. **Models are automatically anchored** - no manual work needed!
4. **Keep the script** - it will anchor future models too

## Note

Models created in Blender will be automatically anchored when imported. The exported .rbxm files will have Anchored=true on all parts, so they won't fall even if you remove this script later.

