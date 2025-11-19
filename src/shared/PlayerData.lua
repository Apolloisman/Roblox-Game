-- Player Data Module
-- Manages player stats, progression, and social status

local GameConfig = require(script.Parent.GameConfig)

local PlayerData = {}
PlayerData.__index = PlayerData

function PlayerData.new(player)
	local self = setmetatable({}, PlayerData)
	
	self.Player = player
	self.Health = GameConfig.Player.MaxHealth
	self.MaxHealth = GameConfig.Player.MaxHealth
	self.Level = 1
	self.Experience = 0
	self.ExperienceToNext = 100
	self.Gold = GameConfig.Player.StartingGold
	self.Tier = "Citizen" -- Starting tier
	self.Housing = "Basic" -- Starting housing
	self.Inventory = {}
	self.Equipment = {
		Weapon = nil,
		Armor = nil,
		Accessory = nil,
	}
	
	-- Social
	self.FamilyId = nil
	self.ClanId = nil
	self.ClanRole = nil -- "Leader", "Officer", "Member"
	
	-- Progression
	self.DungeonsCompleted = 0
	self.TotalGoldEarned = 0
	
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
	self.ExperienceToNext = math.floor(self.ExperienceToNext * 1.5)
	self.MaxHealth = self.MaxHealth + 20
	self.Health = self.MaxHealth
	
	-- Check for tier upgrade
	self:CheckTierUpgrade()
end

function PlayerData:CheckTierUpgrade()
	for i = #GameConfig.Tiers, 1, -1 do
		local tier = GameConfig.Tiers[i]
		if self.Level >= tier.MinLevel then
			if self.Tier ~= tier.Name then
				self.Tier = tier.Name
				-- Notify player of tier upgrade
				return true
			end
			break
		end
	end
	return false
end

function PlayerData:AddGold(amount)
	self.Gold = self.Gold + amount
	self.TotalGoldEarned = self.TotalGoldEarned + amount
end

function PlayerData:SpendGold(amount)
	if self.Gold >= amount then
		self.Gold = self.Gold - amount
		return true
	end
	return false
end

function PlayerData:SetHousing(housingType)
	if GameConfig.Housing[housingType] then
		self.Housing = housingType
		return true
	end
	return false
end

function PlayerData:CanAccessDungeon(dungeonTier)
	local tierData = nil
	for _, tier in ipairs(GameConfig.Tiers) do
		if tier.Name == self.Tier then
			tierData = tier
			break
		end
	end
	
	if not tierData then return false end
	
	for _, access in ipairs(tierData.DungeonAccess) do
		if access == dungeonTier then
			return true
		end
	end
	return false
end

function PlayerData:JoinFamily(familyId)
	self.FamilyId = familyId
end

function PlayerData:LeaveFamily()
	self.FamilyId = nil
end

function PlayerData:JoinClan(clanId, role)
	self.ClanId = clanId
	self.ClanRole = role or "Member"
end

function PlayerData:LeaveClan()
	self.ClanId = nil
	self.ClanRole = nil
end

function PlayerData:ToTable()
	return {
		Health = self.Health,
		MaxHealth = self.MaxHealth,
		Level = self.Level,
		Experience = self.Experience,
		ExperienceToNext = self.ExperienceToNext,
		Gold = self.Gold,
		Tier = self.Tier,
		Housing = self.Housing,
		FamilyId = self.FamilyId,
		ClanId = self.ClanId,
		ClanRole = self.ClanRole,
		DungeonsCompleted = self.DungeonsCompleted,
		TotalGoldEarned = self.TotalGoldEarned,
	}
end

return PlayerData
