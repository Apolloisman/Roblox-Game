-- Clan Manager
-- Handles clan creation, management, and manufacturing

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local GameConfig = require(ReplicatedStorage.Shared.GameConfig)
local ClanData = require(ReplicatedStorage.Shared.ClanData)
local PlayerManager = require(script.Parent.PlayerManager)
local DataManager = require(script.Parent.DataManager)

local ClanManager = {}
ClanManager.Clans = {} -- ClanId -> ClanData
ClanManager.NextClanId = 1

function ClanManager:Initialize()
	-- Load existing clans from data store
	-- Process manufacturing every minute
	spawn(function()
		while true do
			wait(60)
			self:ProcessAllManufacturing()
		end
	end)
	
	-- Update competition scores every hour
	spawn(function()
		while true do
			wait(3600)
			self:UpdateCompetitionScores()
		end
	end)
end

function ClanManager:CreateClan(player, clanName)
	local playerData = PlayerManager:GetPlayerData(player)
	if not playerData then
		return false, "Player data not found"
	end
	
	if playerData.ClanId then
		return false, "You are already in a clan"
	end
	
	if playerData.Gold < GameConfig.Clan.FormCost then
		return false, "Not enough gold to form clan (need " .. GameConfig.Clan.FormCost .. " gold)"
	end
	
	-- Create clan
	local clanId = ClanManager.NextClanId
	ClanManager.NextClanId = ClanManager.NextClanId + 1
	
	local clanData = ClanData.new(clanId, player.UserId, clanName)
	ClanManager.Clans[clanId] = clanData
	
	-- Add player to clan
	playerData:JoinClan(clanId, "Leader")
	playerData:SpendGold(GameConfig.Clan.FormCost)
	
	-- Save clan
	DataManager:SaveClanData(clanId, clanData)
	
	return true, clanId
end

function ClanManager:JoinClan(player, clanId)
	local playerData = PlayerManager:GetPlayerData(player)
	if not playerData then
		return false, "Player data not found"
	end
	
	if playerData.ClanId then
		return false, "You are already in a clan"
	end
	
	local clanData = ClanManager.Clans[clanId]
	if not clanData then
		-- Try to load from data store
		local savedData = DataManager:LoadClanData(clanId)
		if savedData then
			clanData = ClanData.new(clanId, savedData.LeaderId, savedData.Name)
			clanData.Members = savedData.Members
			clanData.Gold = savedData.Gold
			ClanManager.Clans[clanId] = clanData
		else
			return false, "Clan not found"
		end
	end
	
	if #clanData.Members >= GameConfig.Clan.MaxMembers then
		return false, "Clan is full"
	end
	
	-- Check if player tier allows manufacturing unlock
	if playerData.Tier == GameConfig.Clan.ManufacturingUnlock then
		clanData:UnlockManufacturing()
	end
	
	clanData:AddMember(player.UserId, "Member")
	playerData:JoinClan(clanId, "Member")
	
	DataManager:SaveClanData(clanId, clanData)
	
	return true
end

function ClanManager:LeaveClan(player)
	local playerData = PlayerManager:GetPlayerData(player)
	if not playerData or not playerData.ClanId then
		return false, "You are not in a clan"
	end
	
	local clanData = ClanManager.Clans[playerData.ClanId]
	if not clanData then
		return false, "Clan data not found"
	end
	
	-- If leader leaves, transfer leadership or disband
	if clanData.LeaderId == player.UserId then
		if #clanData.Members > 1 then
			-- Transfer to first officer or member
			local newLeader = clanData.Officers[1] or clanData.Members[2]
			clanData.LeaderId = newLeader
		else
			-- Disband clan
			ClanManager.Clans[playerData.ClanId] = nil
		end
	end
	
	clanData:RemoveMember(player.UserId)
	playerData:LeaveClan()
	
	DataManager:SaveClanData(playerData.ClanId, clanData)
	
	return true
end

function ClanManager:RequestManufacturing(player, itemType)
	local playerData = PlayerManager:GetPlayerData(player)
	if not playerData or not playerData.ClanId then
		return false, "You are not in a clan"
	end
	
	local clanData = ClanManager.Clans[playerData.ClanId]
	if not clanData then
		return false, "Clan data not found"
	end
	
	if not clanData.ManufacturingUnlocked then
		return false, "Manufacturing not unlocked. Reach " .. GameConfig.Clan.ManufacturingUnlock .. " tier."
	end
	
	local success, result = clanData:AddManufacturingJob(itemType, player.UserId)
	if success then
		DataManager:SaveClanData(playerData.ClanId, clanData)
		return true, result
	else
		return false, result
	end
end

function ClanManager:ProcessAllManufacturing()
	for clanId, clanData in pairs(ClanManager.Clans) do
		clanData:ProcessManufacturing()
		DataManager:SaveClanData(clanId, clanData)
	end
end

function ClanManager:UpdateCompetitionScores()
	-- Update cross-server competition scores
	for clanId, clanData in pairs(ClanManager.Clans) do
		DataManager:UpdateCompetitionScore(clanId, clanData.CompetitionScore)
	end
	
	-- Check for champion clan
	local topClans = DataManager:GetTopClans(1)
	if #topClans > 0 then
		local championClanId = topClans[1].ClanId
		-- Grant palace access to champion
		if ClanManager.Clans[championClanId] then
			ClanManager.Clans[championClanId]:SetPalaceAccess(true)
		end
	end
end

function ClanManager:GetClan(clanId)
	return ClanManager.Clans[clanId]
end

return ClanManager

