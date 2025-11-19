-- Data Manager
-- Handles saving and loading player, family, and clan data

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local PlayerDataStore = DataStoreService:GetDataStore("PlayerData")
local FamilyDataStore = DataStoreService:GetDataStore("FamilyData")
local ClanDataStore = DataStoreService:GetDataStore("ClanData")
local CompetitionDataStore = DataStoreService:GetOrderedDataStore("ClanCompetition")

local DataManager = {}

-- Player Data
function DataManager:SavePlayerData(player, playerData)
	local success, err = pcall(function()
		PlayerDataStore:SetAsync(tostring(player.UserId), playerData:ToTable())
	end)
	
	if not success then
		warn("Failed to save player data for " .. player.Name .. ": " .. tostring(err))
		return false
	end
	return true
end

function DataManager:LoadPlayerData(player)
	local success, data = pcall(function()
		return PlayerDataStore:GetAsync(tostring(player.UserId))
	end)
	
	if success and data then
		return data
	else
		return nil -- New player
	end
end

-- Family Data
function DataManager:SaveFamilyData(familyId, familyData)
	local success, err = pcall(function()
		FamilyDataStore:SetAsync(tostring(familyId), familyData:ToTable())
	end)
	
	if not success then
		warn("Failed to save family data: " .. tostring(err))
		return false
	end
	return true
end

function DataManager:LoadFamilyData(familyId)
	local success, data = pcall(function()
		return FamilyDataStore:GetAsync(tostring(familyId))
	end)
	
	if success and data then
		return data
	end
	return nil
end

-- Clan Data
function DataManager:SaveClanData(clanId, clanData)
	local success, err = pcall(function()
		ClanDataStore:SetAsync(tostring(clanId), clanData:ToTable())
	end)
	
	if not success then
		warn("Failed to save clan data: " .. tostring(err))
		return false
	end
	return true
end

function DataManager:LoadClanData(clanId)
	local success, data = pcall(function()
		return ClanDataStore:GetAsync(tostring(clanId))
	end)
	
	if success and data then
		return data
	end
	return nil
end

-- Competition Leaderboard
function DataManager:UpdateCompetitionScore(clanId, score)
	local success, err = pcall(function()
		CompetitionDataStore:SetAsync(tostring(clanId), score)
	end)
	
	if not success then
		warn("Failed to update competition score: " .. tostring(err))
		return false
	end
	return true
end

function DataManager:GetTopClans(limit)
	limit = limit or 10
	local success, pages = pcall(function()
		return CompetitionDataStore:GetSortedAsync(false, limit)
	end)
	
	if success and pages then
		local topClans = {}
		for _, entry in ipairs(pages:GetCurrentPage()) do
			table.insert(topClans, {
				ClanId = tonumber(entry.key),
				Score = entry.value,
			})
		end
		return topClans
	end
	return {}
end

return DataManager

