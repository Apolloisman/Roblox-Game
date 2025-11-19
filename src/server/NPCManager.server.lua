-- NPC Manager
-- Handles NPCs, dialogue, shops, and story progression

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local NPCData = require(ReplicatedStorage.Shared.NPCData)
local NPCConfig = require(ReplicatedStorage.Shared.NPCConfig)
local PlayerManager = require(script.Parent.PlayerManager)

local NPCManager = {}
NPCManager.NPCs = {} -- NPCId -> NPCData

function NPCManager:Initialize()
	-- Load NPC configurations and create NPC data
	for areaName, npcs in pairs(NPCConfig) do
		for _, npcConfig in ipairs(npcs) do
			local npcData = NPCData.new(npcConfig.Id, npcConfig.Name, npcConfig.Type)
			npcData.DialogueTree = npcConfig.Dialogue or {}
			npcData.Inventory = npcConfig.Inventory or {}
			npcData.ShopType = npcConfig.ShopType
			NPCManager.NPCs[npcConfig.Id] = npcData
		end
	end
	
	print("NPC Manager initialized with " .. #NPCManager.NPCs .. " NPCs")
end

function NPCManager:GetDialogue(player, npcId, dialogueKey)
	local npcData = NPCManager.NPCs[npcId]
	if not npcData then
		return nil, "NPC not found"
	end
	
	local playerData = PlayerManager:GetPlayerData(player)
	if not playerData then
		return nil, "Player data not found"
	end
	
	-- Get player's story progress with this NPC
	local progress = playerData.Level + (playerData.DungeonsCompleted * 2)
	npcData:SetStoryProgress(player.UserId, progress)
	
	local dialogue = npcData:GetDialogue(player.UserId, dialogueKey)
	if not dialogue then
		return nil, "Dialogue not found"
	end
	
	-- Improve relationship
	npcData:ImproveRelationship(player.UserId, 1)
	
	return dialogue
end

function NPCManager:GetShopInventory(player, npcId)
	local npcData = NPCManager.NPCs[npcId]
	if not npcData or npcData.Type ~= "Shopkeeper" then
		return nil, "Not a shop NPC"
	end
	
	local playerData = PlayerManager:GetPlayerData(player)
	if not playerData then
		return nil, "Player data not found"
	end
	
	-- Filter inventory based on player tier
	local availableItems = {}
	for _, item in ipairs(npcData.Inventory) do
		if playerData.Tier == item.RequiredTier or self:HasTierAccess(playerData.Tier, item.RequiredTier) then
			table.insert(availableItems, item)
		end
	end
	
	return availableItems
end

function NPCManager:HasTierAccess(playerTier, requiredTier)
	-- Check if player tier is equal or higher than required
	local tierOrder = {"Citizen", "Apprentice", "Artisan", "Merchant", "Noble"}
	local playerIndex = 0
	local requiredIndex = 0
	
	for i, tier in ipairs(tierOrder) do
		if tier == playerTier then
			playerIndex = i
		end
		if tier == requiredTier then
			requiredIndex = i
		end
	end
	
	return playerIndex >= requiredIndex
end

function NPCManager:PurchaseItem(player, npcId, itemId)
	local npcData = NPCManager.NPCs[npcId]
	if not npcData or npcData.Type ~= "Shopkeeper" then
		return false, "Not a shop NPC"
	end
	
	local playerData = PlayerManager:GetPlayerData(player)
	if not playerData then
		return false, "Player data not found"
	end
	
	-- Find item
	local item = nil
	for _, shopItem in ipairs(npcData.Inventory) do
		if shopItem.ItemId == itemId then
			item = shopItem
			break
		end
	end
	
	if not item then
		return false, "Item not found"
	end
	
	-- Check tier access
	if not self:HasTierAccess(playerData.Tier, item.RequiredTier) then
		return false, "You don't have access to this item. Reach " .. item.RequiredTier .. " tier."
	end
	
	-- Check if player has enough gold
	if not playerData:SpendGold(item.Cost) then
		return false, "Not enough gold. Need " .. item.Cost .. " gold."
	end
	
	-- Add item to inventory
	table.insert(playerData.Inventory, {
		ItemId = item.ItemId,
		Name = item.Name,
		Type = npcData.ShopType,
	})
	
	-- Improve relationship with NPC
	npcData:ImproveRelationship(player.UserId, 5)
	
	return true, item
end

function NPCManager:GetNPC(npcId)
	return NPCManager.NPCs[npcId]
end

function NPCManager:GetAllNPCs()
	return NPCManager.NPCs
end

return NPCManager

