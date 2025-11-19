-- EXAMPLE: How ServerConfig.lua should look after setting Place IDs
-- Copy this format and replace with YOUR actual Place IDs

return {
	ServerType = {
		Main = "Main",
		Dungeon = "Dungeon",
		UpperTier = "UpperTier",
	},
	
	-- ⚠️ IMPORTANT: Set this correctly for each place!
	-- Main Server: "Main"
	-- Dungeon Servers: "Dungeon"
	-- Upper Tier Servers: "UpperTier"
	CurrentServerType = "Main",
	
	Teleportation = {
		MainServer = {
			-- ⚠️ Replace 1234567890 with YOUR main server Place ID
			PlaceId = 1234567890,
			Areas = {
				"School",
				"TownHall",
				"City",
				"Farms",
				"Houses",
				"Factories",
				"Shops",
			},
		},
		
		DungeonServers = {
			-- ⚠️ Replace these with YOUR dungeon Place IDs
			Tier1 = {PlaceId = 1111111111, Name = "Tier 1 Dungeon"},
			Tier2 = {PlaceId = 2222222222, Name = "Tier 2 Dungeon"},
			Tier3 = {PlaceId = 3333333333, Name = "Tier 3 Dungeon"},
			Tier4 = {PlaceId = 4444444444, Name = "Tier 4 Dungeon"},
			Tier5 = {PlaceId = 5555555555, Name = "Tier 5 Dungeon"},
		},
		
		UpperTierServers = {
			-- ⚠️ Replace these with YOUR upper tier Place IDs
			Artisan = {PlaceId = 6666666666, Name = "Artisan District", RequiredTier = "Artisan"},
			Merchant = {PlaceId = 7777777777, Name = "Merchant District", RequiredTier = "Merchant"},
			Noble = {PlaceId = 8888888888, Name = "Noble Estate", RequiredTier = "Noble"},
		},
	},
	
	WorkAreas = {
		Farms = {
			Name = "Farms",
			Position = Vector3.new(100, 5, 100),
			Description = "Agricultural work area",
			GoldPerWork = 20,
		},
		Factories = {
			Name = "Factories",
			Position = Vector3.new(200, 5, 100),
			Description = "Manufacturing work area",
			GoldPerWork = 50,
		},
		Houses = {
			Name = "Housing District",
			Position = Vector3.new(0, 5, 200),
			Description = "Residential area",
			GoldPerWork = 30,
		},
	},
}

-- ⚠️ STEPS:
-- 1. Get your Place IDs from Roblox (see HOW_TO_SET_PLACE_IDS.md)
-- 2. Replace all the example numbers (1234567890, etc.) with YOUR Place IDs
-- 3. Set CurrentServerType correctly for each place
-- 4. Save the file
-- 5. Done!

