-- Game Configuration
-- Shared settings for dungeon crawler game

return {
	-- Player Settings
	Player = {
		MaxHealth = 100,
		StartingHealth = 100,
		WalkSpeed = 16,
		JumpPower = 50,
	},
	
	-- Combat Settings
	Combat = {
		AttackCooldown = 0.5, -- seconds
		AttackRange = 5, -- studs
		AttackDamage = 10,
	},
	
	-- Enemy Settings
	Enemy = {
		SpawnRate = 5, -- seconds between spawns
		MaxEnemies = 10,
		EnemyHealth = 50,
		EnemyDamage = 5,
		EnemySpeed = 8,
	},
	
	-- Dungeon Settings
	Dungeon = {
		RoomSize = 50, -- studs
		RoomCount = 5, -- number of rooms
		CorridorLength = 20, -- studs
	},
	
	-- Loot Settings
	Loot = {
		DropChance = 0.3, -- 30% chance
		HealthPackHeal = 25,
	},
}

