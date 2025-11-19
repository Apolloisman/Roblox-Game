-- Clan UI
-- Handles clan creation, joining, management, and manufacturing

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local GameConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("GameConfig"))

local ClanUI = {}
ClanUI.MainFrame = nil
ClanUI.CurrentClanData = nil

function ClanUI:Initialize()
	self:CreateClanUI()
	
	-- Listen for clan events
	RemoteEvents.CreateClan.OnClientEvent:Connect(function(success, result)
		if success then
			self:ShowMessage("Clan created! ID: " .. tostring(result))
			self:RefreshClanData()
		else
			self:ShowMessage("Failed to create clan: " .. tostring(result), Color3.fromRGB(255, 100, 100))
		end
	end)
	
	RemoteEvents.JoinClan.OnClientEvent:Connect(function(success, message)
		if success then
			self:ShowMessage("Joined clan!")
			self:RefreshClanData()
		else
			self:ShowMessage("Failed to join: " .. tostring(message), Color3.fromRGB(255, 100, 100))
		end
	end)
	
	RemoteEvents.LeaveClan.OnClientEvent:Connect(function(success, message)
		if success then
			self:ShowMessage("Left clan")
			self.CurrentClanData = nil
			self:RefreshUI()
		end
	end)
	
	RemoteEvents.UpdateClanData.OnClientEvent:Connect(function(clanData)
		self.CurrentClanData = clanData
		self:RefreshUI()
	end)
	
	RemoteEvents.RequestManufacturing.OnClientEvent:Connect(function(success, result)
		if success then
			self:ShowMessage("Manufacturing job queued! Job ID: " .. tostring(result))
			self:RefreshClanData()
		else
			self:ShowMessage("Failed: " .. tostring(result), Color3.fromRGB(255, 100, 100))
		end
	end)
end

function ClanUI:CreateClanUI()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ClanUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui
	
	-- Main Frame
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "ClanFrame"
	mainFrame.Size = UDim2.new(0, 600, 0, 700)
	mainFrame.Position = UDim2.new(0.5, -300, 0.5, -350)
	mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	mainFrame.BorderSizePixel = 2
	mainFrame.BorderColor3 = Color3.fromRGB(255, 150, 100)
	mainFrame.Visible = false
	mainFrame.Parent = screenGui
	
	-- Title
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "TitleLabel"
	titleLabel.Size = UDim2.new(1, -20, 0, 50)
	titleLabel.Position = UDim2.new(0, 10, 0, 10)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "Clan Management"
	titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	titleLabel.TextSize = 24
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Parent = mainFrame
	
	-- Content Frame
	local contentFrame = Instance.new("Frame")
	contentFrame.Name = "ContentFrame"
	contentFrame.Size = UDim2.new(1, -20, 1, -100)
	contentFrame.Position = UDim2.new(0, 10, 0, 70)
	contentFrame.BackgroundTransparency = 1
	contentFrame.Parent = mainFrame
	
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
	closeButton.Parent = mainFrame
	
	closeButton.MouseButton1Click:Connect(function()
		mainFrame.Visible = false
	end)
	
	ClanUI.MainFrame = mainFrame
	ClanUI.ContentFrame = contentFrame
end

function ClanUI:ShowClanMenu()
	if not ClanUI.MainFrame then return end
	
	self:RefreshUI()
	ClanUI.MainFrame.Visible = true
end

function ClanUI:RefreshUI()
	if not ClanUI.ContentFrame then return end
	ClanUI.ContentFrame:ClearAllChildren()
	
	if ClanUI.CurrentClanData then
		self:ShowClanInfo()
	else
		self:ShowCreateOrJoin()
	end
end

function ClanUI:ShowCreateOrJoin()
	local contentFrame = ClanUI.ContentFrame
	
	-- Create Clan Section
	local createLabel = Instance.new("TextLabel")
	createLabel.Size = UDim2.new(1, -20, 0, 30)
	createLabel.Position = UDim2.new(0, 10, 0, 10)
	createLabel.BackgroundTransparency = 1
	createLabel.Text = "Create Clan"
	createLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	createLabel.TextSize = 18
	createLabel.Font = Enum.Font.GothamBold
	createLabel.TextXAlignment = Enum.TextXAlignment.Left
	createLabel.Parent = contentFrame
	
	local costLabel = Instance.new("TextLabel")
	costLabel.Size = UDim2.new(1, -20, 0, 25)
	costLabel.Position = UDim2.new(0, 10, 0, 45)
	costLabel.BackgroundTransparency = 1
	costLabel.Text = "Cost: " .. GameConfig.Clan.FormCost .. " gold"
	costLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	costLabel.TextSize = 14
	costLabel.Font = Enum.Font.Gotham
	costLabel.TextXAlignment = Enum.TextXAlignment.Left
	costLabel.Parent = contentFrame
	
	local nameInput = Instance.new("TextBox")
	nameInput.Size = UDim2.new(1, -20, 0, 35)
	nameInput.Position = UDim2.new(0, 10, 0, 75)
	nameInput.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	nameInput.BorderSizePixel = 1
	nameInput.BorderColor3 = Color3.fromRGB(100, 100, 100)
	nameInput.Text = "Enter clan name..."
	nameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameInput.TextSize = 14
	nameInput.Font = Enum.Font.Gotham
	nameInput.PlaceholderText = "Enter clan name..."
	nameInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
	nameInput.Parent = contentFrame
	
	local createButton = Instance.new("TextButton")
	createButton.Size = UDim2.new(0, 150, 0, 40)
	createButton.Position = UDim2.new(0, 10, 0, 120)
	createButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
	createButton.Text = "Create Clan"
	createButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	createButton.TextSize = 14
	createButton.Font = Enum.Font.GothamBold
	createButton.Parent = contentFrame
	
	createButton.MouseButton1Click:Connect(function()
		if nameInput.Text and nameInput.Text ~= "" and nameInput.Text ~= "Enter clan name..." then
			RemoteEvents.CreateClan:FireServer(nameInput.Text)
		end
	end)
	
	-- Join Clan Section
	local joinLabel = Instance.new("TextLabel")
	joinLabel.Size = UDim2.new(1, -20, 0, 30)
	joinLabel.Position = UDim2.new(0, 10, 0, 180)
	joinLabel.BackgroundTransparency = 1
	joinLabel.Text = "Join Clan"
	joinLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	joinLabel.TextSize = 18
	joinLabel.Font = Enum.Font.GothamBold
	joinLabel.TextXAlignment = Enum.TextXAlignment.Left
	joinLabel.Parent = contentFrame
	
	local clanIdInput = Instance.new("TextBox")
	clanIdInput.Size = UDim2.new(1, -20, 0, 35)
	clanIdInput.Position = UDim2.new(0, 10, 0, 215)
	clanIdInput.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	clanIdInput.BorderSizePixel = 1
	clanIdInput.BorderColor3 = Color3.fromRGB(100, 100, 100)
	clanIdInput.Text = "Enter clan ID..."
	clanIdInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	clanIdInput.TextSize = 14
	clanIdInput.Font = Enum.Font.Gotham
	clanIdInput.PlaceholderText = "Enter clan ID..."
	clanIdInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
	clanIdInput.Parent = contentFrame
	
	local joinButton = Instance.new("TextButton")
	joinButton.Size = UDim2.new(0, 150, 0, 40)
	joinButton.Position = UDim2.new(0, 10, 0, 260)
	joinButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
	joinButton.Text = "Join Clan"
	joinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	joinButton.TextSize = 14
	joinButton.Font = Enum.Font.GothamBold
	joinButton.Parent = contentFrame
	
	joinButton.MouseButton1Click:Connect(function()
		local clanId = tonumber(clanIdInput.Text)
		if clanId then
			RemoteEvents.JoinClan:FireServer(clanId)
		end
	end)
end

function ClanUI:ShowClanInfo()
	local contentFrame = ClanUI.ContentFrame
	local clanData = ClanUI.CurrentClanData
	
	-- Clan Name
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, -20, 0, 30)
	nameLabel.Position = UDim2.new(0, 10, 0, 10)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = "Clan: " .. (clanData.Name or "Unknown")
	nameLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	nameLabel.TextSize = 20
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.Parent = contentFrame
	
	-- Members
	local membersLabel = Instance.new("TextLabel")
	membersLabel.Size = UDim2.new(1, -20, 0, 25)
	membersLabel.Position = UDim2.new(0, 10, 0, 45)
	membersLabel.BackgroundTransparency = 1
	membersLabel.Text = "Members: " .. (#clanData.Members or 0) .. "/" .. GameConfig.Clan.MaxMembers
	membersLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	membersLabel.TextSize = 14
	membersLabel.Font = Enum.Font.Gotham
	membersLabel.TextXAlignment = Enum.TextXAlignment.Left
	membersLabel.Parent = contentFrame
	
	-- Gold
	local goldLabel = Instance.new("TextLabel")
	goldLabel.Size = UDim2.new(1, -20, 0, 25)
	goldLabel.Position = UDim2.new(0, 10, 0, 75)
	goldLabel.BackgroundTransparency = 1
	goldLabel.Text = "Clan Gold: " .. (clanData.Gold or 0)
	goldLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	goldLabel.TextSize = 14
	goldLabel.Font = Enum.Font.Gotham
	goldLabel.TextXAlignment = Enum.TextXAlignment.Left
	goldLabel.Parent = contentFrame
	
	-- Manufacturing Section
	if clanData.ManufacturingUnlocked then
		local mfgLabel = Instance.new("TextLabel")
		mfgLabel.Size = UDim2.new(1, -20, 0, 30)
		mfgLabel.Position = UDim2.new(0, 10, 0, 110)
		mfgLabel.BackgroundTransparency = 1
		mfgLabel.Text = "Manufacturing"
		mfgLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
		mfgLabel.TextSize = 18
		mfgLabel.Font = Enum.Font.GothamBold
		mfgLabel.TextXAlignment = Enum.TextXAlignment.Left
		mfgLabel.Parent = contentFrame
		
		local yOffset = 145
		for itemType, config in pairs(GameConfig.Manufacturing) do
			local itemButton = Instance.new("TextButton")
			itemButton.Size = UDim2.new(1, -20, 0, 40)
			itemButton.Position = UDim2.new(0, 10, 0, yOffset)
			itemButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
			itemButton.BorderSizePixel = 1
			itemButton.BorderColor3 = Color3.fromRGB(100, 100, 100)
			itemButton.Text = itemType .. " - " .. config.BaseCost .. " gold"
			itemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			itemButton.TextSize = 14
			itemButton.Font = Enum.Font.Gotham
			itemButton.Parent = contentFrame
			
			itemButton.MouseButton1Click:Connect(function()
				RemoteEvents.RequestManufacturing:FireServer(itemType)
			end)
			
			yOffset = yOffset + 50
		end
	end
	
	-- Leave Button
	local leaveButton = Instance.new("TextButton")
	leaveButton.Size = UDim2.new(0, 150, 0, 40)
	leaveButton.Position = UDim2.new(0, 10, 1, -50)
	leaveButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
	leaveButton.Text = "Leave Clan"
	leaveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	leaveButton.TextSize = 14
	leaveButton.Font = Enum.Font.GothamBold
	leaveButton.Parent = contentFrame
	
	leaveButton.MouseButton1Click:Connect(function()
		RemoteEvents.LeaveClan:FireServer()
	end)
end

function ClanUI:RefreshClanData()
	-- Request updated clan data from server
	-- Server will send via UpdateClanData event
end

function ClanUI:ShowMessage(message, color)
	color = color or Color3.fromRGB(100, 255, 100)
	print(message)
	-- Could show a notification UI here
end

return ClanUI

