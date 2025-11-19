-- Teleport Manager
-- Handles cross-server teleportation for dungeons and upper tiers

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ServerConfig = require(ReplicatedStorage.Shared.ServerConfig)
local PlayerManager = require(script.Parent.PlayerManager)

local TeleportManager = {}

function TeleportManager:Initialize()
	-- Set up teleportation points in workspace
	-- These will be created in Studio
end

function TeleportManager:TeleportToDungeon(player, dungeonTier)
	local playerData = PlayerManager:GetPlayerData(player)
	if not playerData then
		return false, "Player data not found"
	end
	
	-- Check if player has access
	if not playerData:CanAccessDungeon(dungeonTier) then
		return false, "You don't have access to this dungeon tier"
	end
	
	local dungeonConfig = ServerConfig.Teleportation.DungeonServers[dungeonTier]
	if not dungeonConfig or not dungeonConfig.PlaceId then
		return false, "Dungeon server not configured"
	end
	
	-- Teleport player
	local success, err = pcall(function()
		TeleportService:Teleport(dungeonConfig.PlaceId, {player}, {
			DungeonTier = dungeonTier,
			PlayerData = playerData:ToTable(),
		})
	end)
	
	if not success then
		return false, "Teleportation failed: " .. tostring(err)
	end
	
	return true
end

function TeleportManager:TeleportToUpperTier(player, tierName)
	local playerData = PlayerManager:GetPlayerData(player)
	if not playerData then
		return false, "Player data not found"
	end
	
	-- Check tier requirement
	local tierConfig = ServerConfig.Teleportation.UpperTierServers[tierName]
	if not tierConfig then
		return false, "Invalid tier server"
	end
	
	if playerData.Tier ~= tierConfig.RequiredTier then
		return false, "You must be " .. tierConfig.RequiredTier .. " tier to access this area"
	end
	
	if not tierConfig.PlaceId then
		return false, "Tier server not configured"
	end
	
	-- Teleport player
	local success, err = pcall(function()
		TeleportService:Teleport(tierConfig.PlaceId, {player}, {
			TierName = tierName,
			PlayerData = playerData:ToTable(),
		})
	end)
	
	if not success then
		return false, "Teleportation failed: " .. tostring(err)
	end
	
	return true
end

function TeleportManager:TeleportToMainServer(player)
	local mainConfig = ServerConfig.Teleportation.MainServer
	if not mainConfig or not mainConfig.PlaceId then
		return false, "Main server not configured"
	end
	
	-- Teleport player
	local success, err = pcall(function()
		TeleportService:Teleport(mainConfig.PlaceId, {player})
	end)
	
	if not success then
		return false, "Teleportation failed: " .. tostring(err)
	end
	
	return true
end

function TeleportManager:TeleportToWorkArea(player, workAreaName)
	-- Teleport within same server to work area
	local workArea = ServerConfig.WorkAreas[workAreaName]
	if not workArea then
		return false, "Work area not found"
	end
	
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.CFrame = CFrame.new(workArea.Position)
		return true
	end
	
	return false, "Character not found"
end

return TeleportManager

