-- Player Manager
-- Manages all player data and progression

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerData = require(ReplicatedStorage.Shared.PlayerData)
local DataManager = require(script.Parent.DataManager)

local PlayerManager = {}
PlayerManager.Players = {}

function PlayerManager:Initialize()
	Players.PlayerAdded:Connect(function(player)
		self:OnPlayerAdded(player)
	end)
	
	Players.PlayerRemoving:Connect(function(player)
		self:OnPlayerRemoving(player)
	end)
end

function PlayerManager:OnPlayerAdded(player)
	-- Load or create player data
	local savedData = DataManager:LoadPlayerData(player)
	local playerData
	
	if savedData then
		-- Load existing data
		playerData = PlayerData.new(player)
		playerData.Level = savedData.Level or 1
		playerData.Experience = savedData.Experience or 0
		playerData.ExperienceToNext = savedData.ExperienceToNext or 100
		playerData.Gold = savedData.Gold or 0
		playerData.Tier = savedData.Tier or "Citizen"
		playerData.Housing = savedData.Housing or "Basic"
		playerData.FamilyId = savedData.FamilyId
		playerData.ClanId = savedData.ClanId
		playerData.ClanRole = savedData.ClanRole
		playerData.DungeonsCompleted = savedData.DungeonsCompleted or 0
		playerData.TotalGoldEarned = savedData.TotalGoldEarned or 0
	else
		-- New player
		playerData = PlayerData.new(player)
	end
	
	PlayerManager.Players[player.UserId] = playerData
	
	-- Auto-save every 5 minutes
	spawn(function()
		while Players:GetPlayerByUserId(player.UserId) do
			wait(300) -- 5 minutes
			DataManager:SavePlayerData(player, playerData)
		end
	end)
end

function PlayerManager:OnPlayerRemoving(player)
	-- Save data before player leaves
	local playerData = PlayerManager.Players[player.UserId]
	if playerData then
		DataManager:SavePlayerData(player, playerData)
		PlayerManager.Players[player.UserId] = nil
	end
end

function PlayerManager:GetPlayerData(player)
	return PlayerManager.Players[player.UserId]
end

function PlayerManager:SaveAllPlayers()
	-- Save all players (called on server shutdown)
	for userId, playerData in pairs(PlayerManager.Players) do
		local player = Players:GetPlayerByUserId(userId)
		if player then
			DataManager:SavePlayerData(player, playerData)
		end
	end
end

return PlayerManager

