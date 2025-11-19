# Quick Start Guide

Get your game running in 5 steps!

## Step 1: Copy Setup Scripts to Studio

1. Open your **main server** place in Roblox Studio
2. Make sure Rojo is connected and syncing
3. Copy these files from `studio_setup/` to `ServerScriptService`:
   - `SetupStartingArea.server.lua`
   - `SetupNPCs.server.lua`
   - `SetupTeleporters.server.lua`
   - `SetupWorkAreas.server.lua`

**OR** - If Rojo is syncing, they should already be in `src/server/` - just move them to `ServerScriptService` temporarily to run them.

## Step 2: Run Setup Scripts

1. In Studio, click **Play** (F5)
2. Scripts will automatically create:
   - Starting area (school/town hall)
   - All NPCs with interactions
   - Teleporters
   - Work stations
3. Stop play mode
4. All models are now in workspace!

## Step 3: Create Your Places

1. Go to [Roblox Creator Dashboard](https://create.roblox.com/dashboard)
2. Create **9 places**:
   - Main Server
   - Tier 1-5 Dungeons (5 places)
   - Artisan, Merchant, Noble Districts (3 places)

## Step 4: Get Place IDs

For each place:
1. Open in Studio
2. Go to **File** → **Publish to Roblox**
3. Copy the Place ID from the URL or dialog

## Step 5: Configure Place IDs

Edit `src/shared/ServerConfig.lua`:

```lua
MainServer = {
    PlaceId = YOUR_MAIN_PLACE_ID, -- Replace nil with your Place ID
},
DungeonServers = {
    Tier1 = {PlaceId = YOUR_TIER1_PLACE_ID},
    -- etc.
},
```

## Done! 🎉

Your game is now set up! Test it:
1. Play main server
2. Talk to NPCs
3. Click "Travel" to see teleporters
4. Click "Work" to go to work areas
5. Click "Dungeons" to volunteer
6. Click "Clan" to manage clans

## Next Steps

- Replace basic models with custom ones
- Add more details and decorations
- Create custom NPC models
- Build actual dungeon layouts
- Add visual effects

Everything else is ready to go! 🚀

