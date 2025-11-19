# Setting Up Place IDs - Quick Guide

## Step 1: Create Your Places

You need **9 places** total:

### Main Server (1 place)
- School/Town Hall
- City
- Shops
- Work Areas

### Dungeon Servers (5 places)
- Tier 1 Dungeon
- Tier 2 Dungeon
- Tier 3 Dungeon
- Tier 4 Dungeon
- Tier 5 Dungeon

### Upper Tier Servers (3 places)
- Artisan District
- Merchant District
- Noble Estate

## Step 2: Get Place IDs

### Method 1: From Roblox Website
1. Go to [Roblox Creator Dashboard](https://create.roblox.com/dashboard)
2. Click **Places** → **Create New Place**
3. Name it (e.g., "Main Server", "Tier 1 Dungeon")
4. Click **Create**
5. The Place ID is in the URL: `https://www.roblox.com/games/1234567890/Your-Place-Name`
6. Copy the number (e.g., `1234567890`)

### Method 2: From Studio
1. Open place in Studio
2. Go to **File** → **Publish to Roblox**
3. The Place ID is shown in the publish dialog
4. Or check **Game Settings** → **Basic Info** → **Place ID**

## Step 3: Configure Place IDs

Edit `src/shared/ServerConfig.lua`:

```lua
Teleportation = {
    MainServer = {
        PlaceId = 1234567890, -- ⚠️ Your main server Place ID
    },
    DungeonServers = {
        Tier1 = {PlaceId = 1111111111}, -- ⚠️ Tier 1 Place ID
        Tier2 = {PlaceId = 2222222222}, -- ⚠️ Tier 2 Place ID
        Tier3 = {PlaceId = 3333333333}, -- ⚠️ Tier 3 Place ID
        Tier4 = {PlaceId = 4444444444}, -- ⚠️ Tier 4 Place ID
        Tier5 = {PlaceId = 5555555555}, -- ⚠️ Tier 5 Place ID
    },
    UpperTierServers = {
        Artisan = {PlaceId = 6666666666}, -- ⚠️ Artisan Place ID
        Merchant = {PlaceId = 7777777777}, -- ⚠️ Merchant Place ID
        Noble = {PlaceId = 8888888888}, -- ⚠️ Noble Place ID
    },
}
```

## Step 4: Set Server Type Per Place

For each place, edit `ServerConfig.lua` and set:

**Main Server:**
```lua
CurrentServerType = "Main"
```

**Dungeon Servers:**
```lua
CurrentServerType = "Dungeon"
```

**Upper Tier Servers:**
```lua
CurrentServerType = "UpperTier"
```

## Quick Checklist

- [ ] Created 9 places in Roblox
- [ ] Got all 9 Place IDs
- [ ] Set Place IDs in `ServerConfig.lua`
- [ ] Set `CurrentServerType` for each place
- [ ] Tested teleportation

## Testing

1. Open main server in Studio
2. Play test
3. Click "Travel" button
4. Try teleporting to a dungeon
5. Should teleport to the correct server!

## Troubleshooting

**"Teleportation failed"**
- Check Place IDs are correct (numbers only, no commas)
- Verify places are published
- Check TeleportService permissions

**"Place ID not set"**
- Make sure you replaced `nil` with actual numbers
- Check for typos in Place IDs

**"Wrong server"**
- Verify `CurrentServerType` is set correctly per place
- Check Place IDs match the correct places

