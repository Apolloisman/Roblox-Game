-- Remote Events Setup
-- Creates and handles all RemoteEvents for client-server communication

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create RemoteEvents folder
local RemoteEvents = Instance.new("Folder")
RemoteEvents.Name = "RemoteEvents"
RemoteEvents.Parent = ReplicatedStorage

-- Dungeon Events
local VolunteerForDungeon = Instance.new("RemoteEvent")
VolunteerForDungeon.Name = "VolunteerForDungeon"
VolunteerForDungeon.Parent = RemoteEvents

local CompleteDungeon = Instance.new("RemoteEvent")
CompleteDungeon.Name = "CompleteDungeon"
CompleteDungeon.Parent = RemoteEvents

-- Clan Events
local CreateClan = Instance.new("RemoteEvent")
CreateClan.Name = "CreateClan"
CreateClan.Parent = RemoteEvents

local JoinClan = Instance.new("RemoteEvent")
JoinClan.Name = "JoinClan"
JoinClan.Parent = RemoteEvents

local LeaveClan = Instance.new("RemoteEvent")
LeaveClan.Name = "LeaveClan"
LeaveClan.Parent = RemoteEvents

local RequestManufacturing = Instance.new("RemoteEvent")
RequestManufacturing.Name = "RequestManufacturing"
RequestManufacturing.Parent = RemoteEvents

-- Family Events
local CreateFamily = Instance.new("RemoteEvent")
CreateFamily.Name = "CreateFamily"
CreateFamily.Parent = RemoteEvents

local JoinFamily = Instance.new("RemoteEvent")
JoinFamily.Name = "JoinFamily"
JoinFamily.Parent = RemoteEvents

-- NPC Events
local TalkToNPC = Instance.new("RemoteEvent")
TalkToNPC.Name = "TalkToNPC"
TalkToNPC.Parent = RemoteEvents

local GetShopInventory = Instance.new("RemoteEvent")
GetShopInventory.Name = "GetShopInventory"
GetShopInventory.Parent = RemoteEvents

local PurchaseItem = Instance.new("RemoteEvent")
PurchaseItem.Name = "PurchaseItem"
PurchaseItem.Parent = RemoteEvents

-- UI Update Events (Server -> Client)
local UpdatePlayerData = Instance.new("RemoteEvent")
UpdatePlayerData.Name = "UpdatePlayerData"
UpdatePlayerData.Parent = RemoteEvents

local UpdateClanData = Instance.new("RemoteEvent")
UpdateClanData.Name = "UpdateClanData"
UpdateClanData.Parent = RemoteEvents

-- Handle events
local DungeonManager = require(script.Parent.DungeonManager)
local ClanManager = require(script.Parent.ClanManager)
local PlayerManager = require(script.Parent.PlayerManager)
local NPCManager = require(script.Parent.NPCManager)

-- Dungeon volunteering
VolunteerForDungeon.OnServerEvent:Connect(function(player, dungeonTier)
	local success, result = DungeonManager:StartDungeon(player, dungeonTier)
	if success then
		VolunteerForDungeon:FireClient(player, true, result)
	else
		VolunteerForDungeon:FireClient(player, false, result)
	end
end)

-- Complete dungeon
CompleteDungeon.OnServerEvent:Connect(function(player, success)
	local success, message = DungeonManager:CompleteDungeon(player, success)
	if success then
		local playerData = PlayerManager:GetPlayerData(player)
		if playerData then
			UpdatePlayerData:FireClient(player, playerData:ToTable())
		end
	end
end)

-- Create clan
CreateClan.OnServerEvent:Connect(function(player, clanName)
	local success, result = ClanManager:CreateClan(player, clanName)
	CreateClan:FireClient(player, success, result)
	if success then
		local playerData = PlayerManager:GetPlayerData(player)
		if playerData then
			UpdatePlayerData:FireClient(player, playerData:ToTable())
		end
	end
end)

-- Join clan
JoinClan.OnServerEvent:Connect(function(player, clanId)
	local success, message = ClanManager:JoinClan(player, clanId)
	JoinClan:FireClient(player, success, message)
	if success then
		local playerData = PlayerManager:GetPlayerData(player)
		if playerData then
			UpdatePlayerData:FireClient(player, playerData:ToTable())
		end
	end
end)

-- Leave clan
LeaveClan.OnServerEvent:Connect(function(player)
	local success, message = ClanManager:LeaveClan(player)
	LeaveClan:FireClient(player, success, message)
	if success then
		local playerData = PlayerManager:GetPlayerData(player)
		if playerData then
			UpdatePlayerData:FireClient(player, playerData:ToTable())
		end
	end
end)

-- Request manufacturing
RequestManufacturing.OnServerEvent:Connect(function(player, itemType)
	local success, result = ClanManager:RequestManufacturing(player, itemType)
	RequestManufacturing:FireClient(player, success, result)
end)

-- Talk to NPC
TalkToNPC.OnServerEvent:Connect(function(player, npcId, dialogueKey)
	local dialogue, message = NPCManager:GetDialogue(player, npcId, dialogueKey)
	if dialogue then
		TalkToNPC:FireClient(player, true, dialogue, npcId)
	else
		TalkToNPC:FireClient(player, false, message or "Dialogue not found")
	end
end)

-- Get shop inventory
GetShopInventory.OnServerEvent:Connect(function(player, npcId)
	local inventory, message = NPCManager:GetShopInventory(player, npcId)
	if inventory then
		GetShopInventory:FireClient(player, true, inventory)
	else
		GetShopInventory:FireClient(player, false, message or "Shop not found")
	end
end)

-- Purchase item
PurchaseItem.OnServerEvent:Connect(function(player, npcId, itemId)
	local success, result = NPCManager:PurchaseItem(player, npcId, itemId)
	if success then
		local playerData = PlayerManager:GetPlayerData(player)
		if playerData then
			UpdatePlayerData:FireClient(player, playerData:ToTable())
		end
		PurchaseItem:FireClient(player, true, result)
	else
		PurchaseItem:FireClient(player, false, result)
	end
end)

print("RemoteEvents initialized")

