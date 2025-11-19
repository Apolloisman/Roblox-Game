-- NPC UI System
-- Handles NPC interactions, dialogue, and shops

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local NPCConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("NPCConfig"))

local NPCUI = {}
NPCUI.CurrentNPC = nil
NPCUI.DialogueFrame = nil
NPCUI.ShopFrame = nil

function NPCUI:Initialize()
	-- Create dialogue UI
	self:CreateDialogueUI()
	
	-- Create shop UI
	self:CreateShopUI()
	
	-- Listen for NPC interactions
	RemoteEvents.TalkToNPC.OnClientEvent:Connect(function(success, dialogue, npcId)
		if success then
			self:ShowDialogue(dialogue, npcId)
		else
			warn("Dialogue error: " .. tostring(dialogue))
		end
	end)
	
	RemoteEvents.GetShopInventory.OnClientEvent:Connect(function(success, inventory)
		if success then
			self:ShowShop(inventory)
		else
			warn("Shop error: " .. tostring(inventory))
		end
	end)
	
	RemoteEvents.PurchaseItem.OnClientEvent:Connect(function(success, result)
		if success then
			self:ShowMessage("Purchased: " .. result.Name)
		else
			self:ShowMessage("Purchase failed: " .. tostring(result), Color3.fromRGB(255, 100, 100))
		end
	end)
end

function NPCUI:CreateDialogueUI()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "NPCUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui
	
	-- Dialogue Frame
	DialogueFrame = Instance.new("Frame")
	DialogueFrame.Name = "DialogueFrame"
	DialogueFrame.Size = UDim2.new(0, 600, 0, 200)
	DialogueFrame.Position = UDim2.new(0.5, -300, 1, -250)
	DialogueFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	DialogueFrame.BorderSizePixel = 2
	DialogueFrame.BorderColor3 = Color3.fromRGB(100, 150, 255)
	DialogueFrame.Visible = false
	DialogueFrame.Parent = screenGui
	
	-- NPC Name Label
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "NameLabel"
	nameLabel.Size = UDim2.new(1, -20, 0, 40)
	nameLabel.Position = UDim2.new(0, 10, 0, 10)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = "NPC Name"
	nameLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	nameLabel.TextSize = 20
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.Parent = DialogueFrame
	
	-- Dialogue Text
	local dialogueText = Instance.new("TextLabel")
	dialogueText.Name = "DialogueText"
	dialogueText.Size = UDim2.new(1, -20, 1, -100)
	dialogueText.Position = UDim2.new(0, 10, 0, 55)
	dialogueText.BackgroundTransparency = 1
	dialogueText.Text = ""
	dialogueText.TextColor3 = Color3.fromRGB(255, 255, 255)
	dialogueText.TextSize = 16
	dialogueText.Font = Enum.Font.Gotham
	dialogueText.TextWrapped = true
	dialogueText.TextXAlignment = Enum.TextXAlignment.Left
	dialogueText.TextYAlignment = Enum.TextYAlignment.Top
	dialogueText.Parent = DialogueFrame
	
	-- Close Button
	local closeButton = Instance.new("TextButton")
	closeButton.Name = "CloseButton"
	closeButton.Size = UDim2.new(0, 100, 0, 35)
	closeButton.Position = UDim2.new(1, -110, 1, -45)
	closeButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
	closeButton.Text = "Close"
	closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeButton.TextSize = 14
	closeButton.Font = Enum.Font.GothamBold
	closeButton.Parent = DialogueFrame
	
	closeButton.MouseButton1Click:Connect(function()
		DialogueFrame.Visible = false
	end)
	
	-- Shop Button (if NPC is shopkeeper)
	local shopButton = Instance.new("TextButton")
	shopButton.Name = "ShopButton"
	shopButton.Size = UDim2.new(0, 100, 0, 35)
	shopButton.Position = UDim2.new(1, -220, 1, -45)
	shopButton.BackgroundColor3 = Color3.fromRGB(255, 150, 100)
	shopButton.Text = "Shop"
	shopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	shopButton.TextSize = 14
	shopButton.Font = Enum.Font.GothamBold
	shopButton.Visible = false
	shopButton.Parent = DialogueFrame
	
	shopButton.MouseButton1Click:Connect(function()
		if NPCUI.CurrentNPC then
			RemoteEvents.GetShopInventory:FireServer(NPCUI.CurrentNPC)
		end
	end)
	
	NPCUI.DialogueFrame = DialogueFrame
end

function NPCUI:CreateShopUI()
	local screenGui = playerGui:FindFirstChild("NPCUI")
	if not screenGui then return end
	
	-- Shop Frame
	ShopFrame = Instance.new("Frame")
	ShopFrame.Name = "ShopFrame"
	ShopFrame.Size = UDim2.new(0, 500, 0, 600)
	ShopFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
	ShopFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	ShopFrame.BorderSizePixel = 2
	ShopFrame.BorderColor3 = Color3.fromRGB(255, 150, 100)
	ShopFrame.Visible = false
	ShopFrame.Parent = screenGui
	
	-- Title
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "TitleLabel"
	titleLabel.Size = UDim2.new(1, -20, 0, 50)
	titleLabel.Position = UDim2.new(0, 10, 0, 10)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "Shop"
	titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	titleLabel.TextSize = 24
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Parent = ShopFrame
	
	-- Scrolling Frame for items
	local scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.Name = "ItemList"
	scrollFrame.Size = UDim2.new(1, -20, 1, -100)
	scrollFrame.Position = UDim2.new(0, 10, 0, 70)
	scrollFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	scrollFrame.BorderSizePixel = 0
	scrollFrame.ScrollBarThickness = 8
	scrollFrame.Parent = ShopFrame
	
	-- Close Button
	local closeButton = Instance.new("TextButton")
	closeButton.Name = "CloseButton"
	closeButton.Size = UDim2.new(0, 100, 0, 35)
	closeButton.Position = UDim2.new(0.5, -50, 1, -45)
	closeButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
	closeButton.Text = "Close"
	closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeButton.TextSize = 14
	closeButton.Font = Enum.Font.GothamBold
	closeButton.Parent = ShopFrame
	
	closeButton.MouseButton1Click:Connect(function()
		ShopFrame.Visible = false
	end)
	
	NPCUI.ShopFrame = ShopFrame
	NPCUI.ShopScrollFrame = scrollFrame
end

function NPCUI:ShowDialogue(dialogue, npcId)
	if not NPCUI.DialogueFrame then return end
	
	-- Find NPC config for name
	local npcName = "NPC"
	for areaName, npcs in pairs(NPCConfig) do
		for _, npcConfig in ipairs(npcs) do
			if npcConfig.Id == npcId then
				npcName = npcConfig.Name
				break
			end
		end
	end
	
	NPCUI.DialogueFrame.NameLabel.Text = npcName
	NPCUI.DialogueFrame.DialogueText.Text = dialogue
	NPCUI.DialogueFrame.Visible = true
	
	-- Show shop button if NPC is a shopkeeper
	local isShopkeeper = false
	for areaName, npcs in pairs(NPCConfig) do
		for _, npcConfig in ipairs(npcs) do
			if npcConfig.Id == npcId and npcConfig.Type == "Shopkeeper" then
				isShopkeeper = true
				break
			end
		end
	end
	
	NPCUI.DialogueFrame.ShopButton.Visible = isShopkeeper
	NPCUI.CurrentNPC = npcId
end

function NPCUI:ShowShop(inventory)
	if not NPCUI.ShopFrame then return end
	
	local scrollFrame = NPCUI.ShopScrollFrame
	scrollFrame:ClearAllChildren()
	
	local yOffset = 10
	local itemHeight = 80
	
	for i, item in ipairs(inventory) do
		local itemFrame = Instance.new("Frame")
		itemFrame.Name = item.ItemId
		itemFrame.Size = UDim2.new(1, -20, 0, itemHeight)
		itemFrame.Position = UDim2.new(0, 10, 0, yOffset)
		itemFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
		itemFrame.BorderSizePixel = 1
		itemFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
		itemFrame.Parent = scrollFrame
		
		-- Item Name
		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(0.6, -10, 1, -10)
		nameLabel.Position = UDim2.new(0, 5, 0, 5)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = item.Name
		nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		nameLabel.TextSize = 16
		nameLabel.Font = Enum.Font.GothamBold
		nameLabel.TextXAlignment = Enum.TextXAlignment.Left
		nameLabel.Parent = itemFrame
		
		-- Price
		local priceLabel = Instance.new("TextLabel")
		priceLabel.Size = UDim2.new(0.3, -10, 1, -10)
		priceLabel.Position = UDim2.new(0.65, 0, 0, 5)
		priceLabel.BackgroundTransparency = 1
		priceLabel.Text = item.Cost .. " gold"
		priceLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
		priceLabel.TextSize = 14
		priceLabel.Font = Enum.Font.Gotham
		priceLabel.TextXAlignment = Enum.TextXAlignment.Right
		priceLabel.Parent = itemFrame
		
		-- Buy Button
		local buyButton = Instance.new("TextButton")
		buyButton.Size = UDim2.new(0, 60, 0, 30)
		buyButton.Position = UDim2.new(1, -65, 0.5, -15)
		buyButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
		buyButton.Text = "Buy"
		buyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		buyButton.TextSize = 12
		buyButton.Font = Enum.Font.GothamBold
		buyButton.Parent = itemFrame
		
		buyButton.MouseButton1Click:Connect(function()
			RemoteEvents.PurchaseItem:FireServer(NPCUI.CurrentNPC, item.ItemId)
		end)
		
		yOffset = yOffset + itemHeight + 10
	end
	
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
	NPCUI.ShopFrame.Visible = true
end

function NPCUI:ShowMessage(message, color)
	color = color or Color3.fromRGB(100, 255, 100)
	-- Simple message display (can be enhanced)
	print(message)
end

function NPCUI:InteractWithNPC(npcId, dialogueKey)
	dialogueKey = dialogueKey or "Welcome"
	RemoteEvents.TalkToNPC:FireServer(npcId, dialogueKey)
end

return NPCUI

