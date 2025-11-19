-- Game Configuration
-- Economy-based dungeon crawler with social mobility

return {
	-- Player Settings
	Player = {
		MaxHealth = 100,
		StartingHealth = 100,
		WalkSpeed = 16,
		JumpPower = 50,
		StartingGold = 0,
	},
	
	-- Progression Tiers (Social Mobility)
	Tiers = {
		{Name = "Citizen", MinLevel = 1, HousingUnlock = "Basic", DungeonAccess = {"Tier1"}},
		{Name = "Apprentice", MinLevel = 5, HousingUnlock = "Standard", DungeonAccess = {"Tier1", "Tier2"}},
		{Name = "Artisan", MinLevel = 10, HousingUnlock = "Comfortable", DungeonAccess = {"Tier1", "Tier2", "Tier3"}},
		{Name = "Merchant", MinLevel = 15, HousingUnlock = "Luxury", DungeonAccess = {"Tier1", "Tier2", "Tier3", "Tier4"}},
		{Name = "Noble", MinLevel = 20, HousingUnlock = "Estate", DungeonAccess = {"Tier1", "Tier2", "Tier3", "Tier4", "Tier5"}},
	},
	
	-- Housing System
	Housing = {
		Basic = {Cost = 0, GoldPerDay = 0, Buff = 0},
		Standard = {Cost = 100, GoldPerDay = 10, Buff = 0.05}, -- 5% bonus
		Comfortable = {Cost = 500, GoldPerDay = 50, Buff = 0.10},
		Luxury = {Cost = 2000, GoldPerDay = 200, Buff = 0.15},
		Estate = {Cost = 10000, GoldPerDay = 1000, Buff = 0.25},
	},
	
	-- Dungeon Settings
	Dungeon = {
		Tier1 = {GoldReward = 50, ExperienceReward = 10, Difficulty = 1, RequiredTier = "Citizen"},
		Tier2 = {GoldReward = 150, ExperienceReward = 30, Difficulty = 2, RequiredTier = "Apprentice"},
		Tier3 = {GoldReward = 400, ExperienceReward = 80, Difficulty = 3, RequiredTier = "Artisan"},
		Tier4 = {GoldReward = 1000, ExperienceReward = 200, Difficulty = 4, RequiredTier = "Merchant"},
		Tier5 = {GoldReward = 2500, ExperienceReward = 500, Difficulty = 5, RequiredTier = "Noble"},
	},
	
	-- Family System
	Family = {
		MaxMembers = 4,
		FormCost = 100,
		SharedStorage = true,
	},
	
	-- Clan System
	Clan = {
		MinMembers = 5,
		MaxMembers = 50,
		FormCost = 1000,
		ManufacturingUnlock = "Artisan", -- Tier required to unlock manufacturing
		ManufacturingSpeed = 1.0, -- Items per hour
	},
	
	-- Manufacturing
	Manufacturing = {
		Weapon = {BaseCost = 500, Time = 3600, RequiredTier = "Artisan"},
		Armor = {BaseCost = 300, Time = 2400, RequiredTier = "Artisan"},
		Consumable = {BaseCost = 100, Time = 600, RequiredTier = "Apprentice"},
		Special = {BaseCost = 2000, Time = 7200, RequiredTier = "Merchant"},
	},
	
	-- Combat Settings
	Combat = {
		AttackCooldown = 0.5,
		AttackRange = 5,
		AttackDamage = 10,
	},
	
	-- Enemy Settings
	Enemy = {
		SpawnRate = 5,
		MaxEnemies = 10,
		EnemyHealth = 50,
		EnemyDamage = 5,
		EnemySpeed = 8,
	},
	
	-- Loot Settings
	Loot = {
		DropChance = 0.3,
		HealthPackHeal = 25,
	},
	
	-- Cross-Server Competition
	Competition = {
		SeasonLength = 604800, -- 7 days in seconds
		UpdateInterval = 3600, -- Update leaderboard every hour
		PalaceAccess = true, -- Champion clan gets palace access
	},
}
