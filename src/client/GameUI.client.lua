-- Main Game UI
-- Handles all UI updates and interactions

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local GameConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("GameConfig"))

local GameUI = {}

-- UI Elements (will be created in Studio or via code)
local mainFrame = nil
local goldLabel = nil
local levelLabel = nil
local tierLabel = nil
local housingLabel = nil

function GameUI:Initialize()
	-- Create main UI frame
	self:CreateMainUI()
	
	-- Listen for player data updates
	RemoteEvents.UpdatePlayerData.OnClientEvent:Connect(function(playerData)
		self:UpdatePlayerData(playerData)
	end)
	
	-- Request initial data
	wait(1) -- Wait for server to be ready
	-- Server will send initial data when player joins
end

function GameUI:CreateMainUI()
	-- Create ScreenGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "GameUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui
	
	-- Main Frame with background image
	mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.Size = UDim2.new(0, 300, 0, 200)
	mainFrame.Position = UDim2.new(0, 10, 0, 10)
	mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = screenGui
	
	-- Add HUD background image
	local hudBg = Instance.new("ImageLabel")
	hudBg.Name = "HUDBackground"
	hudBg.Size = UDim2.new(1, 0, 1, 0)
	hudBg.BackgroundTransparency = 1
	hudBg.Image = "rbxasset://assets/ui/images/hud_background.png"
	hudBg.Parent = mainFrame
	
	-- Gold Label
	goldLabel = Instance.new("TextLabel")
	goldLabel.Name = "GoldLabel"
	goldLabel.Size = UDim2.new(1, -20, 0, 30)
	goldLabel.Position = UDim2.new(0, 10, 0, 10)
	goldLabel.BackgroundTransparency = 1
	goldLabel.Text = "Gold: 0"
	goldLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	goldLabel.TextSize = 18
	goldLabel.Font = Enum.Font.GothamBold
	goldLabel.TextXAlignment = Enum.TextXAlignment.Left
	goldLabel.Parent = mainFrame
	
	-- Level Label
	levelLabel = Instance.new("TextLabel")
	levelLabel.Name = "LevelLabel"
	levelLabel.Size = UDim2.new(1, -20, 0, 30)
	levelLabel.Position = UDim2.new(0, 10, 0, 45)
	levelLabel.BackgroundTransparency = 1
	levelLabel.Text = "Level: 1"
	levelLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	levelLabel.TextSize = 16
	levelLabel.Font = Enum.Font.Gotham
	levelLabel.TextXAlignment = Enum.TextXAlignment.Left
	levelLabel.Parent = mainFrame
	
	-- Tier Label
	tierLabel = Instance.new("TextLabel")
	tierLabel.Name = "TierLabel"
	tierLabel.Size = UDim2.new(1, -20, 0, 30)
	tierLabel.Position = UDim2.new(0, 10, 0, 80)
	tierLabel.BackgroundTransparency = 1
	tierLabel.Text = "Tier: Citizen"
	tierLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
	tierLabel.TextSize = 16
	tierLabel.Font = Enum.Font.Gotham
	tierLabel.TextXAlignment = Enum.TextXAlignment.Left
	tierLabel.Parent = mainFrame
	
	-- Housing Label
	housingLabel = Instance.new("TextLabel")
	housingLabel.Name = "HousingLabel"
	housingLabel.Size = UDim2.new(1, -20, 0, 30)
	housingLabel.Position = UDim2.new(0, 10, 0, 115)
	housingLabel.BackgroundTransparency = 1
	housingLabel.Text = "Housing: Basic"
	housingLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	housingLabel.TextSize = 14
	housingLabel.Font = Enum.Font.Gotham
	housingLabel.TextXAlignment = Enum.TextXAlignment.Left
	housingLabel.Parent = mainFrame
	
	-- Buttons Frame (2 rows)
	local buttonsFrame = Instance.new("Frame")
	buttonsFrame.Name = "ButtonsFrame"
	buttonsFrame.Size = UDim2.new(1, -20, 0, 100)
	buttonsFrame.Position = UDim2.new(0, 10, 0, 150)
	buttonsFrame.BackgroundTransparency = 1
	buttonsFrame.Parent = mainFrame
	
	-- Row 1
	-- Dungeon Button with image
	local dungeonButton = Instance.new("ImageButton")
	dungeonButton.Name = "DungeonButton"
	dungeonButton.Size = UDim2.new(0.48, 0, 0, 45)
	dungeonButton.Position = UDim2.new(0, 0, 0, 0)
	dungeonButton.Image = "rbxasset://assets/ui/buttons/menu/dungeons_button.png"
	dungeonButton.BackgroundTransparency = 1
	dungeonButton.Parent = buttonsFrame
	
	dungeonButton.MouseButton1Click:Connect(function()
		GameUI:OpenDungeonMenu()
	end)
	
	-- Travel Button with image
	local travelButton = Instance.new("ImageButton")
	travelButton.Name = "TravelButton"
	travelButton.Size = UDim2.new(0.48, 0, 0, 45)
	travelButton.Position = UDim2.new(0.52, 0, 0, 0)
	travelButton.Image = "rbxasset://assets/ui/buttons/menu/travel_button.png"
	travelButton.BackgroundTransparency = 1
	travelButton.Parent = buttonsFrame
	
	travelButton.MouseButton1Click:Connect(function()
		GameUI:OpenTravelMenu()
	end)
	
	-- Row 2
	-- Clan Button with image
	local clanButton = Instance.new("ImageButton")
	clanButton.Name = "ClanButton"
	clanButton.Size = UDim2.new(0.48, 0, 0, 45)
	clanButton.Position = UDim2.new(0, 0, 0, 55)
	clanButton.Image = "rbxasset://assets/ui/buttons/menu/clan_button.png"
	clanButton.BackgroundTransparency = 1
	clanButton.Parent = buttonsFrame
	
	clanButton.MouseButton1Click:Connect(function()
		GameUI:OpenClanMenu()
	end)
	
	-- Work Button with image
	local workButton = Instance.new("ImageButton")
	workButton.Name = "WorkButton"
	workButton.Size = UDim2.new(0.48, 0, 0, 45)
	workButton.Position = UDim2.new(0.52, 0, 0, 55)
	workButton.Image = "rbxasset://assets/ui/buttons/menu/work_button.png"
	workButton.BackgroundTransparency = 1
	workButton.Parent = buttonsFrame
	
	workButton.MouseButton1Click:Connect(function()
		GameUI:OpenWorkMenu()
	end)
end

function GameUI:UpdatePlayerData(playerData)
	if goldLabel then
		goldLabel.Text = "Gold: " .. playerData.Gold
	end
	if levelLabel then
		levelLabel.Text = "Level: " .. playerData.Level
	end
	if tierLabel then
		tierLabel.Text = "Tier: " .. playerData.Tier
	end
	if housingLabel then
		housingLabel.Text = "Housing: " .. playerData.Housing
	end
end

function GameUI:OpenDungeonMenu()
	-- Open dungeon volunteering menu
	local DungeonUI = require(script.Parent.DungeonUI)
	DungeonUI:ShowDungeonMenu()
end

function GameUI:OpenTravelMenu()
	-- Open travel/teleport menu
	local TeleportUI = require(script.Parent.TeleportUI)
	TeleportUI:ShowTeleportMenu()
end

function GameUI:OpenClanMenu()
	-- Open clan menu
	local ClanUI = require(script.Parent.ClanUI)
	ClanUI:ShowClanMenu()
end

function GameUI:OpenWorkMenu()
	-- Open work area menu
	local TeleportUI = require(script.Parent.TeleportUI)
	TeleportUI:ShowTeleportMenu() -- Work areas are in travel menu
end

return GameUI

