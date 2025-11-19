-- Dungeon Manager
-- Handles dungeon volunteering, entry, and completion

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local GameConfig = require(ReplicatedStorage.Shared.GameConfig)
local PlayerManager = require(script.Parent.PlayerManager)

local DungeonManager = {}
DungeonManager.ActiveDungeons = {} -- PlayerId -> DungeonData

function DungeonManager:Initialize()
	-- Set up dungeon entry points in workspace
	-- This will be configured in Studio
end

function DungeonManager:CanVolunteer(player, dungeonTier)
	local playerData = PlayerManager:GetPlayerData(player)
	if not playerData then return false, "Player data not found" end
	
	-- Check if player has access to this tier
	if not playerData:CanAccessDungeon(dungeonTier) then
		return false, "You don't have access to this dungeon tier. Reach " .. GameConfig.Dungeon[dungeonTier].RequiredTier .. " tier."
	end
	
	-- Check if already in a dungeon
	if DungeonManager.ActiveDungeons[player.UserId] then
		return false, "You are already in a dungeon"
	end
	
	return true
end

function DungeonManager:StartDungeon(player, dungeonTier)
	local canVolunteer, message = self:CanVolunteer(player, dungeonTier)
	if not canVolunteer then
		return false, message
	end
	
	local dungeonConfig = GameConfig.Dungeon[dungeonTier]
	if not dungeonConfig then
		return false, "Invalid dungeon tier"
	end
	
	-- Create dungeon instance for player
	local dungeonData = {
		Tier = dungeonTier,
		PlayerId = player.UserId,
		StartTime = os.time(),
		EnemiesDefeated = 0,
		GoldEarned = 0,
		Status = "Active",
	}
	
	DungeonManager.ActiveDungeons[player.UserId] = dungeonData
	
	-- Teleport player to dungeon (you'll set this up in Studio)
	-- For now, just mark as started
	warn("Dungeon started for " .. player.Name .. " - Tier: " .. dungeonTier)
	
	return true, dungeonData
end

function DungeonManager:CompleteDungeon(player, success)
	local dungeonData = DungeonManager.ActiveDungeons[player.UserId]
	if not dungeonData then
		return false, "No active dungeon"
	end
	
	local playerData = PlayerManager:GetPlayerData(player)
	if not playerData then
		return false, "Player data not found"
	end
	
	if success then
		local dungeonConfig = GameConfig.Dungeon[dungeonData.Tier]
		
		-- Reward player
		playerData:AddGold(dungeonConfig.GoldReward)
		playerData:AddExperience(dungeonConfig.ExperienceReward)
		playerData.DungeonsCompleted = playerData.DungeonsCompleted + 1
		dungeonData.GoldEarned = dungeonConfig.GoldReward
		
		-- Teleport back to starting area
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			-- Teleport to starting area
		end
	else
		-- Failed dungeon - no rewards
		warn(player.Name .. " failed dungeon")
	end
	
	-- Remove from active dungeons
	DungeonManager.ActiveDungeons[player.UserId] = nil
	
	return true
end

function DungeonManager:GetActiveDungeon(player)
	return DungeonManager.ActiveDungeons[player.UserId]
end

return DungeonManager

