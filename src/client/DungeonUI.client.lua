-- Dungeon UI
-- Handles dungeon volunteering and selection

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local GameConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("GameConfig"))
local ServerConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("ServerConfig"))

local DungeonUI = {}
DungeonUI.MainFrame = nil

function DungeonUI:Initialize()
	self:CreateDungeonUI()
	
	-- Listen for dungeon events
	RemoteEvents.VolunteerForDungeon.OnClientEvent:Connect(function(success, result)
		if success then
			self:ShowDungeonStarted(result)
		else
			warn("Dungeon start failed: " .. tostring(result))
		end
	end)
end

function DungeonUI:CreateDungeonUI()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "DungeonUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui
	
	-- Main Frame
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "DungeonFrame"
	mainFrame.Size = UDim2.new(0, 500, 0, 600)
	mainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
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
	titleLabel.Text = "Dungeon Volunteering"
	titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	titleLabel.TextSize = 24
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Parent = mainFrame
	
	-- Description
	local descLabel = Instance.new("TextLabel")
	descLabel.Name = "DescLabel"
	descLabel.Size = UDim2.new(1, -20, 0, 40)
	descLabel.Position = UDim2.new(0, 10, 0, 60)
	descLabel.BackgroundTransparency = 1
	descLabel.Text = "Volunteer for dangerous dungeon work to earn gold and experience"
	descLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	descLabel.TextSize = 14
	descLabel.Font = Enum.Font.Gotham
	descLabel.TextWrapped = true
	descLabel.Parent = mainFrame
	
	-- Scrolling Frame
	local scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.Name = "DungeonList"
	scrollFrame.Size = UDim2.new(1, -20, 1, -150)
	scrollFrame.Position = UDim2.new(0, 10, 0, 110)
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
	
	DungeonUI.MainFrame = mainFrame
	DungeonUI.ScrollFrame = scrollFrame
end

function DungeonUI:ShowDungeonMenu()
	if not DungeonUI.MainFrame then return end
	
	local scrollFrame = DungeonUI.ScrollFrame
	scrollFrame:ClearAllChildren()
	
	local yOffset = 10
	
	-- Get player data to check access
	local playerData = nil
	RemoteEvents.UpdatePlayerData.OnClientEvent:Wait()
	
	-- Create dungeon buttons
	local tiers = {"Tier1", "Tier2", "Tier3", "Tier4", "Tier5"}
	
	for _, tier in ipairs(tiers) do
		local dungeonConfig = GameConfig.Dungeon[tier]
		if dungeonConfig then
			local button = self:CreateDungeonButton(tier, dungeonConfig, playerData)
			button.Position = UDim2.new(0, 10, 0, yOffset)
			button.Parent = scrollFrame
			yOffset = yOffset + 120
		end
	end
	
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
	DungeonUI.MainFrame.Visible = true
end

function DungeonUI:CreateDungeonButton(tier, config, playerData)
	local buttonFrame = Instance.new("Frame")
	buttonFrame.Name = tier
	buttonFrame.Size = UDim2.new(1, -20, 0, 110)
	buttonFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	buttonFrame.BorderSizePixel = 1
	buttonFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
	
	-- Tier Name
	local tierLabel = Instance.new("TextLabel")
	tierLabel.Size = UDim2.new(0.7, -10, 0, 30)
	tierLabel.Position = UDim2.new(0, 5, 0, 5)
	tierLabel.BackgroundTransparency = 1
	tierLabel.Text = tier .. " - " .. config.RequiredTier .. " Required"
	tierLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	tierLabel.TextSize = 16
	tierLabel.Font = Enum.Font.GothamBold
	tierLabel.TextXAlignment = Enum.TextXAlignment.Left
	tierLabel.Parent = buttonFrame
	
	-- Rewards
	local rewardLabel = Instance.new("TextLabel")
	rewardLabel.Size = UDim2.new(1, -10, 0, 25)
	rewardLabel.Position = UDim2.new(0, 5, 0, 35)
	rewardLabel.BackgroundTransparency = 1
	rewardLabel.Text = "Rewards: " .. config.GoldReward .. " gold, " .. config.ExperienceReward .. " XP"
	rewardLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	rewardLabel.TextSize = 12
	rewardLabel.Font = Enum.Font.Gotham
	rewardLabel.TextXAlignment = Enum.TextXAlignment.Left
	rewardLabel.Parent = buttonFrame
	
	-- Difficulty
	local diffLabel = Instance.new("TextLabel")
	diffLabel.Size = UDim2.new(1, -10, 0, 25)
	diffLabel.Position = UDim2.new(0, 5, 0, 60)
	diffLabel.BackgroundTransparency = 1
	diffLabel.Text = "Difficulty: " .. string.rep("★", config.Difficulty)
	diffLabel.TextColor3 = Color3.fromRGB(255, 150, 100)
	diffLabel.TextSize = 12
	diffLabel.Font = Enum.Font.Gotham
	diffLabel.TextXAlignment = Enum.TextXAlignment.Left
	diffLabel.Parent = buttonFrame
	
	-- Volunteer Button
	local volunteerButton = Instance.new("TextButton")
	volunteerButton.Size = UDim2.new(0, 120, 0, 35)
	volunteerButton.Position = UDim2.new(1, -125, 0.5, -17.5)
	volunteerButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
	volunteerButton.Text = "Volunteer"
	volunteerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	volunteerButton.TextSize = 14
	volunteerButton.Font = Enum.Font.GothamBold
	volunteerButton.Parent = buttonFrame
	
	-- Check if player has access
	local hasAccess = true
	if playerData then
		-- Check tier requirement
		local requiredTier = config.RequiredTier
		local tierOrder = {"Citizen", "Apprentice", "Artisan", "Merchant", "Noble"}
		local playerTierIndex = 0
		local requiredTierIndex = 0
		
		for i, tier in ipairs(tierOrder) do
			if tier == playerData.Tier then
				playerTierIndex = i
			end
			if tier == requiredTier then
				requiredTierIndex = i
			end
		end
		
		hasAccess = playerTierIndex >= requiredTierIndex
	end
	
	if not hasAccess then
		volunteerButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
		volunteerButton.Text = "Locked"
		volunteerButton.TextColor3 = Color3.fromRGB(150, 150, 150)
	else
		volunteerButton.MouseButton1Click:Connect(function()
			RemoteEvents.VolunteerForDungeon:FireServer(tier)
			DungeonUI.MainFrame.Visible = false
		end)
	end
	
	return buttonFrame
end

function DungeonUI:ShowDungeonStarted(dungeonData)
	-- Show notification that dungeon started
	warn("Dungeon started! Tier: " .. dungeonData.Tier)
	-- Could show a UI notification here
end

return DungeonUI

