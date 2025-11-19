# Fix: Models Falling Over in Roblox

## Why Models Fall Over

In Roblox, **parts fall down due to gravity** unless they're **Anchored**. When you import models from Blender, the parts are **not anchored by default**, so they fall.

## Quick Fix: Anchor Models in Studio

### Method 1: Anchor All Parts (Easiest)

1. **Import your model** into Roblox Studio
2. **Select the model** in Workspace (click the model name in Explorer)
3. **Press Ctrl+A** (or Cmd+A on Mac) to select all parts
4. **In Properties window**, find **Anchored**
5. **Check the box** to set Anchored = true
6. **Done!** Model won't fall anymore

### Method 2: Anchor Individual Parts

1. **Expand the model** in Explorer
2. **Select each part** one by one
3. **In Properties**, check **Anchored**
4. Repeat for all parts

### Method 3: Use a Script (Auto-Anchor)

Create a script in **ServerScriptService**:

```lua
-- Auto-Anchor All Models
local function anchorModel(model)
    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = true
        end
    end
end

-- Anchor all models in Workspace
for _, model in ipairs(workspace:GetChildren()) do
    if model:IsA("Model") then
        anchorModel(model)
    end
end

print("All models anchored!")
```

**Run this once** when you import models, then delete the script.

## Which Parts Should Be Anchored?

### ✅ Anchor These:
- **Buildings** (school, townhall, shops) - All parts
- **Teleporters** - All parts
- **Work stations** - All parts
- **NPC stands** - All parts
- **Environment** (ground, platforms) - All parts

### ❌ Don't Anchor These:
- **Player characters** - Never anchor!
- **Moving objects** (doors, elevators) - Only if they need to move
- **Items players can pick up** - Only if they should fall

## For Your Specific Models

### School Building
- Anchor: ✅ All parts (base, roof, windows, door)

### Town Hall
- Anchor: ✅ All parts (base, roof, columns)

### Shops
- Anchor: ✅ All parts (all 4 shops)

### Teleporters
- Anchor: ✅ All parts (platforms, pillars, arches)

### Work Stations
- Anchor: ✅ All parts (tables, legs)

### NPC Stands
- Anchor: ✅ All parts (platforms)

### Environment
- Anchor: ✅ Ground and spawn platform

## Pro Tip: Create a Helper Script

Save this as `AnchorAllModels.server.lua` in ServerScriptService:

```lua
-- Auto-Anchor All Imported Models
-- Run this once after importing models, then delete it

local function anchorEverything(parent)
    for _, child in ipairs(parent:GetChildren()) do
        if child:IsA("BasePart") then
            child.Anchored = true
            print("Anchored: " .. child.Name)
        elseif child:IsA("Model") then
            anchorEverything(child)
        end
    end
end

-- Anchor everything in Workspace
anchorEverything(workspace)

print("✓ All models anchored!")
```

**Usage:**
1. Import your models
2. Run this script once
3. Delete the script
4. Models stay anchored!

## Why This Happens

- **Blender** doesn't have an "Anchored" concept
- **Roblox** needs parts to be explicitly anchored
- **FBX export** doesn't include Roblox-specific properties
- **Solution:** Anchor in Studio after import

## Alternative: Fix in Blender (Advanced)

You can't directly set "Anchored" in Blender, but you can:

1. **Name parts clearly** (e.g., "SCHOOL_Base_ANCHORED")
2. **Create a script** that finds parts with "ANCHORED" in name
3. **Auto-anchor them** in Studio

But it's easier to just anchor in Studio! 😊

## Summary

**Problem:** Models fall because parts aren't anchored  
**Solution:** Select model → Properties → Check "Anchored"  
**Time:** 30 seconds per model  
**Result:** Models stay in place! ✅

