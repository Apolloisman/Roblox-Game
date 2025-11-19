-- Starting Area Manager
-- Manages the school/town hall where all players start

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage.Shared.GameConfig)

local StartingArea = {}

-- Spawn location for starting area (set this in Studio)
local STARTING_SPAWN = Vector3.new(0, 5, 0)

function StartingArea:Initialize()
	-- Set spawn location for all players
	local spawnLocation = workspace:FindFirstChild("StartingArea") or workspace:FindFirstChild("TownHall")
	
	if spawnLocation then
		STARTING_SPAWN = spawnLocation.Position
	end
	
	-- Handle player spawning
	Players.PlayerAdded:Connect(function(player)
		self:OnPlayerAdded(player)
	end)
	
	-- Handle player respawning
	Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function(character)
			self:OnPlayerRespawned(player, character)
		end)
	end)
end

function StartingArea:OnPlayerAdded(player)
	-- Teleport to starting area
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.CFrame = CFrame.new(STARTING_SPAWN)
	end
end

function StartingArea:OnPlayerRespawned(player, character)
	-- Always respawn at starting area
	wait(0.1) -- Wait for character to fully load
	if character:FindFirstChild("HumanoidRootPart") then
		character.HumanoidRootPart.CFrame = CFrame.new(STARTING_SPAWN)
	end
end

function StartingArea:CanAccessDungeon(player, dungeonTier)
	-- Check if player has access to this dungeon tier
	-- This will be called by dungeon system
	local playerData = self:GetPlayerData(player)
	if not playerData then return false end
	
	return playerData:CanAccessDungeon(dungeonTier)
end

function StartingArea:GetPlayerData(player)
	-- Get player data from PlayerManager
	local PlayerManager = require(script.Parent.PlayerManager)
	return PlayerManager:GetPlayerData(player)
end

return StartingArea

