# Quick Fix: Model Falling Over

## The Problem

Your model fell because **parts aren't anchored**. In Roblox, unanchored parts fall due to gravity.

## The Solution (30 seconds)

### Option 1: Quick Fix in Studio

1. **Select your model** in Explorer (click the model name)
2. **Press Ctrl+A** (selects all parts in the model)
3. **In Properties window**, find **"Anchored"**
4. **Check the box** ✅
5. **Done!** Model won't fall anymore

### Option 2: Use Auto-Anchor Script

1. **Copy** `studio_setup/AnchorAllModels.server.lua` to **ServerScriptService**
2. **Press Play** in Studio
3. **Check Output** - it will show "✓ Anchored X parts!"
4. **Delete the script** (models stay anchored)

## Why This Happens

- **Blender** doesn't have "Anchored" property
- **FBX export** doesn't include Roblox properties
- **Roblox** needs parts explicitly anchored
- **Solution:** Anchor after import

## Which Models Need Anchoring?

**✅ Anchor these:**
- School building
- Town hall
- Shops
- Teleporters
- Work stations
- NPC stands
- Environment (ground, platforms)

**❌ Don't anchor:**
- Player characters
- Moving objects (if they need to move)

## Pro Tip

After importing all your models, run the auto-anchor script once. It will anchor everything automatically, then you can delete it!

**Time to fix:** 30 seconds per model (or 10 seconds with the script)

