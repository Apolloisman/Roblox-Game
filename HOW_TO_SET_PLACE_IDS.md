# How to Set Place IDs - Step by Step

## Step 1: Create Your Places in Roblox

You need **9 places** total:

### 1. Go to Roblox Creator Dashboard
- Visit: https://create.roblox.com/dashboard
- Log in with your Roblox account

### 2. Create Each Place
Click **"Create"** → **"New Place"** for each:

**Main Server (1 place):**
- Name: "Main Server" or "City Hub"
- This is your main game with school, shops, work areas

**Dungeon Servers (5 places):**
- Name: "Tier 1 Dungeon"
- Name: "Tier 2 Dungeon"
- Name: "Tier 3 Dungeon"
- Name: "Tier 4 Dungeon"
- Name: "Tier 5 Dungeon"

**Upper Tier Servers (3 places):**
- Name: "Artisan District"
- Name: "Merchant District"
- Name: "Noble Estate"

## Step 2: Get Place IDs

For each place you created:

### Method 1: From Creator Dashboard
1. Go to **Places** in the dashboard
2. Click on a place
3. Look at the URL: `https://www.roblox.com/games/1234567890/Your-Place-Name`
4. The **Place ID** is the number (e.g., `1234567890`)

### Method 2: From Studio
1. Open the place in Roblox Studio
2. Go to **File** → **Game Settings** (or press F9)
3. Click **Basic Info** tab
4. The **Place ID** is shown at the top

### Method 3: From Publish Dialog
1. In Studio, go to **File** → **Publish to Roblox**
2. The Place ID is shown in the dialog

## Step 3: Edit ServerConfig.lua

1. Open `src/shared/ServerConfig.lua` in your code editor
2. Find the section that says `PlaceId = nil`
3. Replace `nil` with your actual Place ID numbers

### Example:

**Before:**
```lua
MainServer = {
    PlaceId = nil,  -- ⚠️ SET THIS
},
```

**After:**
```lua
MainServer = {
    PlaceId = 1234567890,  -- Your actual Place ID
},
```

## Step 4: Set All Place IDs

Edit `src/shared/ServerConfig.lua` and replace ALL the `nil` values:

```lua
Teleportation = {
    MainServer = {
        PlaceId = YOUR_MAIN_PLACE_ID,  -- Replace with your number
    },
    DungeonServers = {
        Tier1 = {PlaceId = YOUR_TIER1_PLACE_ID},  -- Replace
        Tier2 = {PlaceId = YOUR_TIER2_PLACE_ID},  -- Replace
        Tier3 = {PlaceId = YOUR_TIER3_PLACE_ID},  -- Replace
        Tier4 = {PlaceId = YOUR_TIER4_PLACE_ID},  -- Replace
        Tier5 = {PlaceId = YOUR_TIER5_PLACE_ID},  -- Replace
    },
    UpperTierServers = {
        Artisan = {PlaceId = YOUR_ARTISAN_PLACE_ID},  -- Replace
        Merchant = {PlaceId = YOUR_MERCHANT_PLACE_ID},  -- Replace
        Noble = {PlaceId = YOUR_NOBLE_PLACE_ID},  -- Replace
    },
}
```

## Step 5: Set Server Type Per Place

For **each place**, you need to set the `CurrentServerType`:

### Main Server:
```lua
CurrentServerType = "Main",
```

### Dungeon Servers (each one):
```lua
CurrentServerType = "Dungeon",
```

### Upper Tier Servers (each one):
```lua
CurrentServerType = "UpperTier",
```

**Important:** Each place needs its own copy of `ServerConfig.lua` with the correct `CurrentServerType` set!

## Quick Checklist

- [ ] Created 9 places in Roblox
- [ ] Got all 9 Place IDs
- [ ] Edited `ServerConfig.lua` with Place IDs
- [ ] Set `CurrentServerType` for each place
- [ ] Saved the file
- [ ] Committed to Git (optional)

## Example: Complete Configuration

Here's what a complete `ServerConfig.lua` looks like for the **Main Server**:

```lua
return {
    ServerType = {
        Main = "Main",
        Dungeon = "Dungeon",
        UpperTier = "UpperTier",
    },
    
    CurrentServerType = "Main",  -- ← Set to "Main" for main server
    
    Teleportation = {
        MainServer = {
            PlaceId = 1234567890,  -- ← Your main server Place ID
        },
        DungeonServers = {
            Tier1 = {PlaceId = 1111111111},  -- ← Tier 1 Place ID
            Tier2 = {PlaceId = 2222222222},  -- ← Tier 2 Place ID
            Tier3 = {PlaceId = 3333333333},  -- ← Tier 3 Place ID
            Tier4 = {PlaceId = 4444444444},  -- ← Tier 4 Place ID
            Tier5 = {PlaceId = 5555555555},  -- ← Tier 5 Place ID
        },
        UpperTierServers = {
            Artisan = {PlaceId = 6666666666},  -- ← Artisan Place ID
            Merchant = {PlaceId = 7777777777},  -- ← Merchant Place ID
            Noble = {PlaceId = 8888888888},  -- ← Noble Place ID
        },
    },
    -- ... rest of config
}
```

## Testing

After setting Place IDs:

1. Open main server in Studio
2. Play test
3. Click "Travel" button
4. Try teleporting to a dungeon
5. Should teleport to the correct server!

## Troubleshooting

**"Place ID not set" error:**
- Make sure you replaced `nil` with actual numbers
- Check for typos
- Verify numbers are correct (no commas, just digits)

**"Teleportation failed":**
- Verify Place IDs are correct
- Make sure places are published
- Check that `CurrentServerType` is set correctly

**"Wrong server teleports":**
- Double-check Place IDs match the correct places
- Verify `CurrentServerType` is correct per place

## Need Help?

- Place IDs are just numbers (e.g., `1234567890`)
- No quotes needed around numbers
- Each place needs its own `ServerConfig.lua` with correct `CurrentServerType`
- Save the file after editing
- Commit to Git to save your changes

That's it! Once Place IDs are set, teleportation will work! 🚀

