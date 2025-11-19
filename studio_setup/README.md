# Studio Setup Scripts

These scripts automatically set up models and interactions in Roblox Studio.

## Quick Setup

### 1. Copy Scripts to Studio

1. Open your **main server** place in Roblox Studio
2. In Studio, go to **ServerScriptService**
3. Copy these scripts into ServerScriptService:
   - `SetupStartingArea.server.lua` - Creates school/town hall
   - `SetupNPCs.server.lua` - Creates all NPCs with interactions
   - `SetupTeleporters.server.lua` - Creates teleporters
   - `SetupWorkAreas.server.lua` - Creates work stations

### 2. Run Scripts

1. Make sure Rojo is connected and syncing
2. The scripts will run automatically when you play
3. All models will be created in workspace

### 3. Configure Place IDs

1. Edit `src/shared/ServerConfig.lua`
2. Set your Place IDs:
   ```lua
   MainServer = {
       PlaceId = YOUR_MAIN_PLACE_ID, -- Get from Roblox website
   },
   DungeonServers = {
       Tier1 = {PlaceId = YOUR_TIER1_PLACE_ID},
       -- etc.
   },
   ```

## Getting Place IDs

1. **Create Places:**
   - Go to Roblox Creator Dashboard
   - Create new places (1 main + 5 dungeons + 3 upper tiers = 9 places total)

2. **Get Place IDs:**
   - Open each place in Studio
   - Go to File → Publish to Roblox
   - The Place ID is in the URL: `https://www.roblox.com/games/PLACE_ID/...`
   - Or check in Creator Dashboard → Places

3. **Set in Config:**
   - Edit `ServerConfig.lua`
   - Replace `nil` with your Place IDs

## What Each Script Does

### SetupStartingArea.server.lua
- Creates spawn location
- Builds simple school building
- Builds simple town hall
- Creates ground plane

### SetupNPCs.server.lua
- Creates all 7 NPCs from NPCConfig
- Adds ProximityPrompts
- Connects to RemoteEvents
- Adds name labels

### SetupTeleporters.server.lua
- Creates 5 dungeon teleporters
- Creates 3 upper tier teleporters
- Adds ProximityPrompts
- Connects to TeleportManager

### SetupWorkAreas.server.lua
- Creates work stations for farms
- Creates work stations for factories
- Creates work stations for houses
- Adds ProximityPrompts

## Customization

After scripts run, you can:
- Replace auto-generated models with custom ones
- Adjust positions
- Change colors/materials
- Add more details

The scripts create **functional** but **basic** models. Replace them with your custom models later!

## Troubleshooting

**Scripts not running?**
- Make sure Rojo is syncing
- Check Output window for errors
- Verify all shared modules are loaded

**Models not appearing?**
- Check workspace
- Look for errors in Output
- Verify positions are correct

**Teleportation not working?**
- Set Place IDs in ServerConfig.lua
- Verify Place IDs are correct
- Check TeleportService permissions

## Next Steps

1. Run all setup scripts
2. Set Place IDs
3. Test teleportation
4. Replace basic models with custom ones
5. Add more details and decorations

