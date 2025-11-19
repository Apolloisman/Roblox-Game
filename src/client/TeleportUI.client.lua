-- Teleportation UI
-- Handles UI for teleporting to different servers and areas

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local ServerConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("ServerConfig"))
local GameConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("GameConfig"))

local TeleportUI = {}
TeleportUI.MainFrame = nil

function TeleportUI:Initialize()
	self:CreateTeleportUI()
	
	-- Listen for teleportation results
	RemoteEvents.TeleportToDungeon.OnClientEvent:Connect(function(success, message)
		if not success then
			warn("Teleport failed: " .. tostring(message))
		end
	end)
	
	RemoteEvents.TeleportToUpperTier.OnClientEvent:Connect(function(success, message)
		if not success then
			warn("Teleport failed: " .. tostring(message))
		end
	end)
	
	RemoteEvents.TeleportToWorkArea.OnClientEvent:Connect(function(success, message)
		if not success then
			warn("Teleport failed: " .. tostring(message))
		end
	end)
end

function TeleportUI:CreateTeleportUI()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "TeleportUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui
	
	-- Main Frame
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "TeleportFrame"
	mainFrame.Size = UDim2.new(0, 400, 0, 500)
	mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
	mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	mainFrame.BorderSizePixel = 2
	mainFrame.BorderColor3 = Color3.fromRGB(100, 150, 255)
	mainFrame.Visible = false
	mainFrame.Parent = screenGui
	
	-- Title
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "TitleLabel"
	titleLabel.Size = UDim2.new(1, -20, 0, 50)
	titleLabel.Position = UDim2.new(0, 10, 0, 10)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "Travel"
	titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	titleLabel.TextSize = 24
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Parent = mainFrame
	
	-- Scrolling Frame
	local scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.Name = "TeleportList"
	scrollFrame.Size = UDim2.new(1, -20, 1, -100)
	scrollFrame.Position = UDim2.new(0, 10, 0, 70)
	scrollFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	scrollFrame.BorderSizePixel = 0
	scrollFrame.ScrollBarThickness = 8
	scrollFrame.Parent = mainFrame
	
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
	
	TeleportUI.MainFrame = mainFrame
	TeleportUI.ScrollFrame = scrollFrame
end

function TeleportUI:ShowTeleportMenu()
	if not TeleportUI.MainFrame then return end
	
	local scrollFrame = TeleportUI.ScrollFrame
	scrollFrame:ClearAllChildren()
	
	local yOffset = 10
	
	-- Add dungeon teleports
	local dungeonLabel = Instance.new("TextLabel")
	dungeonLabel.Size = UDim2.new(1, -20, 0, 30)
	dungeonLabel.Position = UDim2.new(0, 10, 0, yOffset)
	dungeonLabel.BackgroundTransparency = 1
	dungeonLabel.Text = "DUNGEONS"
	dungeonLabel.TextColor3 = Color3.fromRGB(255, 150, 100)
	dungeonLabel.TextSize = 16
	dungeonLabel.Font = Enum.Font.GothamBold
	dungeonLabel.TextXAlignment = Enum.TextXAlignment.Left
	dungeonLabel.Parent = scrollFrame
	yOffset = yOffset + 35
	
	for tier, config in pairs(ServerConfig.Teleportation.DungeonServers) do
		local button = self:CreateTeleportButton(tier, config.Name, function()
			RemoteEvents.TeleportToDungeon:FireServer(tier)
		end)
		button.Position = UDim2.new(0, 10, 0, yOffset)
		button.Parent = scrollFrame
		yOffset = yOffset + 50
	end
	
	-- Add work areas
	yOffset = yOffset + 20
	local workLabel = Instance.new("TextLabel")
	workLabel.Size = UDim2.new(1, -20, 0, 30)
	workLabel.Position = UDim2.new(0, 10, 0, yOffset)
	workLabel.BackgroundTransparency = 1
	workLabel.Text = "WORK AREAS"
	workLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
	workLabel.TextSize = 16
	workLabel.Font = Enum.Font.GothamBold
	workLabel.TextXAlignment = Enum.TextXAlignment.Left
	workLabel.Parent = scrollFrame
	yOffset = yOffset + 35
	
	for name, area in pairs(ServerConfig.WorkAreas) do
		local button = self:CreateTeleportButton(name, area.Name, function()
			RemoteEvents.TeleportToWorkArea:FireServer(name)
		end)
		button.Position = UDim2.new(0, 10, 0, yOffset)
		button.Parent = scrollFrame
		yOffset = yOffset + 50
	end
	
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
	TeleportUI.MainFrame.Visible = true
end

function TeleportUI:CreateTeleportButton(name, displayName, onClick)
	local button = Instance.new("TextButton")
	button.Name = name
	button.Size = UDim2.new(1, -20, 0, 45)
	button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	button.BorderSizePixel = 1
	button.BorderColor3 = Color3.fromRGB(100, 100, 100)
	button.Text = displayName
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextSize = 14
	button.Font = Enum.Font.Gotham
	button.MouseButton1Click:Connect(onClick)
	
	return button
end

return TeleportUI

