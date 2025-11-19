-- Server Configuration
-- Defines server types and teleportation settings
-- IMPORTANT: Set your Place IDs here!

return {
	-- Server Types
	ServerType = {
		Main = "Main", -- School, city, work areas
		Dungeon = "Dungeon", -- Dungeon instances
		UpperTier = "UpperTier", -- Servers for higher tier players
	},
	
	-- Current Server Type (set per server)
	CurrentServerType = "Main", -- Change this per server: "Main", "Dungeon", or "UpperTier"
	
	-- Teleportation Settings
	Teleportation = {
		-- Main server has all starting areas
		MainServer = {
			PlaceId = 136933591262687, -- Main server Place ID
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
		-- ⚠️ SET THESE: Create 5 separate places and set their Place IDs
		DungeonServers = {
			Tier1 = {PlaceId = nil, Name = "Tier 1 Dungeon"}, -- ⚠️ SET THIS
			Tier2 = {PlaceId = nil, Name = "Tier 2 Dungeon"}, -- ⚠️ SET THIS
			Tier3 = {PlaceId = nil, Name = "Tier 3 Dungeon"}, -- ⚠️ SET THIS
			Tier4 = {PlaceId = nil, Name = "Tier 4 Dungeon"}, -- ⚠️ SET THIS
			Tier5 = {PlaceId = nil, Name = "Tier 5 Dungeon"}, -- ⚠️ SET THIS
		},
		
		-- Upper tier servers (for higher tier players)
		-- ⚠️ SET THESE: Create 3 separate places and set their Place IDs
		UpperTierServers = {
			Artisan = {PlaceId = nil, Name = "Artisan District", RequiredTier = "Artisan"}, -- ⚠️ SET THIS
			Merchant = {PlaceId = nil, Name = "Merchant District", RequiredTier = "Merchant"}, -- ⚠️ SET THIS
			Noble = {PlaceId = nil, Name = "Noble Estate", RequiredTier = "Noble"}, -- ⚠️ SET THIS
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
