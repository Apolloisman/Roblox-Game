# Complete Setup Guide

## Multi-Server Architecture

Your game now uses a **multi-server system**:

### Main Server
- **School/Town Hall** - Starting area for all players
- **City** - Shops, NPCs, social areas
- **Work Areas** - Farms, factories, houses
- **Teleporters** - To dungeons and upper tiers

### Dungeon Servers (5 separate servers)
- Tier 1-5 dungeons
- Each on separate server
- Players teleport to these servers

### Upper Tier Servers (3 separate servers)
- Artisan District
- Merchant District  
- Noble Estate
- Tier-gated access

## What's Been Built

### ✅ Complete Systems

1. **Progression System**
   - 5 tiers (Citizen → Noble)
   - Level-based unlocks
   - Housing system with daily income

2. **NPC System**
   - 7 NPCs with stories
   - Progressive dialogue
   - Shop system with tier-based inventory

3. **Clan System**
   - Manufacturing
   - Cross-server competition
   - Palace access for champions

4. **Work Areas**
   - Farms (20 gold/10s)
   - Factories (50 gold/10s)
   - Houses (30 gold/10s)

5. **Teleportation System**
   - Cross-server teleportation
   - Dungeon teleporters
   - Upper tier teleporters
   - Work area teleportation

6. **Complete UI**
   - Main game UI
   - NPC dialogue UI
   - Shop UI
   - Teleportation UI
   - Work area UI

## Setup Steps

### 1. Configure Server IDs

Edit `src/shared/ServerConfig.lua`:

```lua
Teleportation = {
    MainServer = {
        PlaceId = YOUR_MAIN_SERVER_ID, -- Set this!
    },
    DungeonServers = {
        Tier1 = {PlaceId = YOUR_TIER1_ID},
        Tier2 = {PlaceId = YOUR_TIER2_ID},
        -- etc.
    },
    UpperTierServers = {
        Artisan = {PlaceId = YOUR_ARTISAN_ID},
        -- etc.
    },
}
```

### 2. Create Main Server Place

In Roblox Studio:

1. **Build Starting Area:**
   - School/Town Hall building
   - Spawn points
   - NPC locations

2. **Create City:**
   - Shop buildings
   - NPCs with ProximityPrompts
   - Streets and decorations

3. **Set Up Work Areas:**
   - Farms at (100, 5, 100)
   - Factories at (200, 5, 100)
   - Houses at (0, 5, 200)
   - Work stations with ProximityPrompts

4. **Add Teleporters:**
   - 5 dungeon teleporters
   - 3 upper tier teleporters
   - ProximityPrompts connected to RemoteEvents

### 3. Create Dungeon Servers

For each tier (1-5):

1. Create new place
2. Build dungeon layout
3. Add entry/exit points
4. Set up dungeon completion system

### 4. Create Upper Tier Servers

For each tier (Artisan, Merchant, Noble):

1. Create new place
2. Build district/estate
3. Add exclusive shops
4. Set tier requirements

### 5. Set Up NPCs

For each NPC:

1. Create NPC model (R15 rig)
2. Add ProximityPrompt:
   ```lua
   local prompt = Instance.new("ProximityPrompt")
   prompt.ActionText = "Talk"
   prompt.ObjectText = "NPC Name"
   ```

3. Add script to NPC:
   ```lua
   local ReplicatedStorage = game:GetService("ReplicatedStorage")
   local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
   
   script.Parent.ProximityPrompt.Triggered:Connect(function(player)
       RemoteEvents.TalkToNPC:FireServer("npc_id", "Welcome")
   end)
   ```

### 6. Set Up Work Stations

For each work area:

1. Create work station model
2. Add ProximityPrompt:
   ```lua
   local prompt = Instance.new("ProximityPrompt")
   prompt.ActionText = "Start Working"
   ```

3. Add script:
   ```lua
   local ReplicatedStorage = game:GetService("ReplicatedStorage")
   local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
   
   script.Parent.ProximityPrompt.Triggered:Connect(function(player)
       RemoteEvents.StartWork:FireServer("Farms") -- or "Factories", "Houses"
   end)
   ```

### 7. Set Up Teleporters

For each teleporter:

1. Create teleporter model
2. Add ProximityPrompt
3. Add script:
   ```lua
   local ReplicatedStorage = game:GetService("ReplicatedStorage")
   local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
   
   script.Parent.ProximityPrompt.Triggered:Connect(function(player)
       RemoteEvents.TeleportToDungeon:FireServer("Tier1")
       -- or TeleportToUpperTier:FireServer("Artisan")
   end)
   ```

## Testing Checklist

- [ ] Main server loads correctly
- [ ] Players spawn in starting area
- [ ] NPCs respond to interactions
- [ ] Shops work and show tier-based inventory
- [ ] Work areas function (earn gold over time)
- [ ] Teleportation works (to dungeons/upper tiers)
- [ ] Player data saves/loads
- [ ] Clan system works
- [ ] Manufacturing functions
- [ ] Cross-server competition updates

## File Structure

All code is organized and ready:

```
src/
├── server/          # All server systems
├── client/          # All client UI
└── shared/          # Shared configs and data
```

## Next Steps

1. **Build Models** - Use MODEL_STRUCTURE.md guide
2. **Configure Servers** - Set Place IDs in ServerConfig
3. **Test Systems** - Use checklist above
4. **Add Content** - More NPCs, stories, items
5. **Polish** - Visual effects, animations, sounds

Everything is ready to build! 🚀

