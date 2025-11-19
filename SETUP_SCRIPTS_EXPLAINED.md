# Setup Scripts Explained

## What Are Setup Scripts?

The setup scripts are **helper scripts** that automatically create game objects in Roblox Studio. They save you from manually creating NPCs, teleporters, and work stations.

## Two Approaches

### Option 1: Use Your Blender Models (Recommended)

Since you already have models from Blender, you **don't need most of these scripts**. Instead:

1. **Import your Blender models** (school, townhall, shops, teleporters, work_stations, npc_stands)
2. **Add ProximityPrompts manually** to:
   - NPC models (for talking/shopping)
   - Teleporter models (for teleporting)
   - Work station models (for working)

**This is better** because you get your custom models instead of basic parts.

### Option 2: Use Setup Scripts (Quick Start)

The setup scripts create **basic placeholder models** so you can test the game quickly, then replace them with your Blender models later.

## What Each Script Does

### SetupNPCs.server.lua
**What it does:**
- Creates 7 NPCs (Headmaster, Elder, Blacksmith, etc.)
- Adds ProximityPrompts so players can interact
- Connects to your RemoteEvents
- Adds name labels above NPCs

**If you use your Blender models:**
- You DON'T need this script
- Just add ProximityPrompts to your NPC models manually

### SetupTeleporters.server.lua
**What it does:**
- Creates 5 dungeon teleporters (Tier 1-5)
- Creates 3 upper tier teleporters (Artisan, Merchant, Noble)
- Adds ProximityPrompts
- Connects to TeleportManager

**If you use your Blender models:**
- You DON'T need this script
- Just add ProximityPrompts to your teleporter models manually

### SetupWorkAreas.server.lua
**What it does:**
- Creates work stations for farms, factories, houses
- Adds ProximityPrompts
- Connects to WorkAreaManager

**If you use your Blender models:**
- You DON'T need this script
- Just add ProximityPrompts to your work station models manually

### SetupStartingArea.server.lua
**What it does:**
- Creates a basic spawn location
- Creates simple school and town hall buildings
- Creates ground plane

**If you use your Blender models:**
- You DON'T need this script
- Your Blender models already have the school, town hall, and environment

## How to Use Setup Scripts (If You Want To)

### Step 1: Copy Scripts to Studio

1. Open Roblox Studio
2. In Explorer, find **ServerScriptService**
3. Copy these files into ServerScriptService:
   - `studio_setup/SetupNPCs.server.lua`
   - `studio_setup/SetupTeleporters.server.lua`
   - `studio_setup/SetupWorkAreas.server.lua`
   - `studio_setup/SetupStartingArea.server.lua` (optional)

### Step 2: Run the Game

1. Press **Play** in Studio
2. Scripts run automatically
3. Check **Workspace** - you'll see NPCs, teleporters, etc. created

### Step 3: Test

- Walk up to NPCs and press E
- Walk up to teleporters and press E
- Walk up to work stations and press E

## Recommended Approach: Use Your Blender Models

Since you have custom models, here's what to do:

### 1. Import Your Models
- Import all .rbxm files from `assets/models/` into Studio
- They'll appear in Workspace

### 2. Add ProximityPrompts Manually

**For NPCs:**
1. Find your NPC model in Workspace
2. Select the main part (usually the stand/platform)
3. Insert → ProximityPrompt
4. Set:
   - ActionText = "Talk"
   - ObjectText = NPC name (e.g., "Headmaster Thorne")
   - MaxActivationDistance = 10
5. Add a Script to the part:
   ```lua
   local ReplicatedStorage = game:GetService("ReplicatedStorage")
   local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
   
   script.Parent.ProximityPrompt.Triggered:Connect(function(player)
       local npcId = "HeadmasterThorne" -- Change to match NPCConfig
       RemoteEvents.TalkToNPC:FireServer(npcId, "Welcome")
   end)
   ```

**For Teleporters:**
1. Find your teleporter model
2. Select the main part
3. Insert → ProximityPrompt
4. Set:
   - ActionText = "Enter"
   - ObjectText = "Tier 1 Dungeon" (or appropriate name)
   - MaxActivationDistance = 15
5. Add a Script:
   ```lua
   local ReplicatedStorage = game:GetService("ReplicatedStorage")
   local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
   
   script.Parent.ProximityPrompt.Triggered:Connect(function(player)
       RemoteEvents.TeleportToDungeon:FireServer("Tier1")
   end)
   ```

**For Work Stations:**
1. Find your work station model
2. Select the table part
3. Insert → ProximityPrompt
4. Set:
   - ActionText = "Start Working"
   - ObjectText = "Farm" (or Factory/House)
   - MaxActivationDistance = 10
5. Add a Script:
   ```lua
   local ReplicatedStorage = game:GetService("ReplicatedStorage")
   local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
   
   script.Parent.ProximityPrompt.Triggered:Connect(function(player)
       RemoteEvents.StartWork:FireServer("Farm1")
   end)
   ```

## Summary

**Setup scripts = Quick way to create basic models for testing**

**Your Blender models = Better, custom models that look good**

**Recommendation:**
- Skip the setup scripts
- Use your Blender models
- Add ProximityPrompts manually (takes ~10 minutes)
- Your game will look much better!

## Quick Reference

| What | Setup Script | Your Blender Models |
|------|-------------|-------------------|
| NPCs | Creates basic parts | Use `npc_stands.fbx` + add prompts |
| Teleporters | Creates basic parts | Use `teleporters.fbx` + add prompts |
| Work Stations | Creates basic parts | Use `work_stations.fbx` + add prompts |
| Buildings | Creates basic parts | Use `school.fbx`, `townhall.fbx`, `shops.fbx` |
| Environment | Creates basic parts | Use `environment.fbx` |

**Bottom line:** Setup scripts are optional helpers. Your Blender models are better! 🎨

