-- Server Configuration
-- Defines server types and teleportation settings

return {
	-- Server Types
	ServerType = {
		Main = "Main", -- School, city, work areas
		Dungeon = "Dungeon", -- Dungeon instances
		UpperTier = "UpperTier", -- Servers for higher tier players
	},
	
	-- Current Server Type (set per server)
	CurrentServerType = "Main", -- Change this per server
	
	-- Teleportation Settings
	Teleportation = {
		-- Main server has all starting areas
		MainServer = {
			PlaceId = nil, -- Set your main server place ID
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
		
		-- Dungeon servers (separate instances)
		DungeonServers = {
			Tier1 = {PlaceId = nil, Name = "Tier 1 Dungeons"},
			Tier2 = {PlaceId = nil, Name = "Tier 2 Dungeons"},
			Tier3 = {PlaceId = nil, Name = "Tier 3 Dungeons"},
			Tier4 = {PlaceId = nil, Name = "Tier 4 Dungeons"},
			Tier5 = {PlaceId = nil, Name = "Tier 5 Dungeons"},
		},
		
		-- Upper tier servers (for higher tier players)
		UpperTierServers = {
			Artisan = {PlaceId = nil, Name = "Artisan District", RequiredTier = "Artisan"},
			Merchant = {PlaceId = nil, Name = "Merchant District", RequiredTier = "Merchant"},
			Noble = {PlaceId = nil, Name = "Noble Estate", RequiredTier = "Noble"},
		},
	},
	
	-- Work Areas (on main server)
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

