-- Player Data Module
-- Manages player stats and state

local PlayerData = {}
PlayerData.__index = PlayerData

function PlayerData.new(player)
	local self = setmetatable({}, PlayerData)
	
	self.Player = player
	self.Health = 100
	self.MaxHealth = 100
	self.Level = 1
	self.Experience = 0
	self.ExperienceToNext = 100
	self.Coins = 0
	self.Inventory = {}
	
	return self
end

function PlayerData:TakeDamage(amount)
	self.Health = math.max(0, self.Health - amount)
	return self.Health <= 0
end

function PlayerData:Heal(amount)
	self.Health = math.min(self.MaxHealth, self.Health + amount)
end

function PlayerData:AddExperience(amount)
	self.Experience = self.Experience + amount
	if self.Experience >= self.ExperienceToNext then
		self:LevelUp()
	end
end

function PlayerData:LevelUp()
	self.Level = self.Level + 1
	self.Experience = self.Experience - self.ExperienceToNext
	self.ExperienceToNext = self.ExperienceToNext * 1.5
	self.MaxHealth = self.MaxHealth + 20
	self.Health = self.MaxHealth
end

function PlayerData:AddCoins(amount)
	self.Coins = self.Coins + amount
end

function PlayerData:ToTable()
	return {
		Health = self.Health,
		MaxHealth = self.MaxHealth,
		Level = self.Level,
		Experience = self.Experience,
		ExperienceToNext = self.ExperienceToNext,
		Coins = self.Coins,
	}
end

return PlayerData

