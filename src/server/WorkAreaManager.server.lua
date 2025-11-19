-- Work Area Manager
-- Handles farms, factories, houses, and other work areas

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local ServerConfig = require(ReplicatedStorage.Shared.ServerConfig)
local PlayerManager = require(script.Parent.PlayerManager)

local WorkAreaManager = {}
WorkAreaManager.ActiveWorkers = {} -- PlayerId -> WorkData

function WorkAreaManager:Initialize()
	-- Set up work areas in workspace
	-- Create work points that players can interact with
end

function WorkAreaManager:StartWork(player, workAreaName)
	local playerData = PlayerManager:GetPlayerData(player)
	if not playerData then
		return false, "Player data not found"
	end
	
	-- Check if already working
	if WorkAreaManager.ActiveWorkers[player.UserId] then
		return false, "You are already working"
	end
	
	local workArea = ServerConfig.WorkAreas[workAreaName]
	if not workArea then
		return false, "Work area not found"
	end
	
	-- Start work session
	local workData = {
		WorkArea = workAreaName,
		StartTime = os.time(),
		GoldEarned = 0,
	}
	
	WorkAreaManager.ActiveWorkers[player.UserId] = workData
	
	-- Work loop (earn gold over time)
	spawn(function()
		while WorkAreaManager.ActiveWorkers[player.UserId] do
			wait(10) -- Earn gold every 10 seconds
			
			if WorkAreaManager.ActiveWorkers[player.UserId] then
				local goldEarned = workArea.GoldPerWork
				playerData:AddGold(goldEarned)
				workData.GoldEarned = workData.GoldEarned + goldEarned
			end
		end
	end)
	
	return true, workData
end

function WorkAreaManager:StopWork(player)
	if not WorkAreaManager.ActiveWorkers[player.UserId] then
		return false, "You are not working"
	end
	
	local workData = WorkAreaManager.ActiveWorkers[player.UserId]
	WorkAreaManager.ActiveWorkers[player.UserId] = nil
	
	return true, workData
end

function WorkAreaManager:GetWorkStatus(player)
	return WorkAreaManager.ActiveWorkers[player.UserId]
end

return WorkAreaManager

