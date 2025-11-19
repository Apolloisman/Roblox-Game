-- UI Manager Module
-- Handles UI creation, management, and interactions
-- Generated with AI assistance (Cursor)

local UIManager = {}
UIManager.__index = UIManager

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- UI Assets (synced via Rojo from assets/ui/)
local UIAssets = ReplicatedStorage:WaitForChild("Assets", 10)
local UIImages = UIAssets and UIAssets:FindFirstChild("UI") or nil

function UIManager.new()
	local self = setmetatable({}, UIManager)
	self.screens = {}
	self.currentScreen = nil
	return self
end

function UIManager:CreateScreen(screenName, template)
	-- Create a new UI screen
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = screenName
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Parent = playerGui
	
	-- Apply template if provided
	if template then
		-- Load template from assets or create from template data
	end
	
	self.screens[screenName] = screenGui
	return screenGui
end

function UIManager:ShowScreen(screenName, fadeIn)
	-- Show a UI screen with optional fade-in animation
	local screen = self.screens[screenName]
	if not screen then
		warn("Screen not found: " .. screenName)
		return
	end
	
	screen.Enabled = true
	
	if fadeIn then
		-- Fade in animation
		for _, element in ipairs(screen:GetDescendants()) do
			if element:IsA("GuiObject") and element.BackgroundTransparency then
				element.BackgroundTransparency = 1
				local tween = TweenService:Create(
					element,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = element:GetAttribute("OriginalTransparency") or 0}
				)
				tween:Play()
			end
		end
	end
	
	self.currentScreen = screenName
end

function UIManager:HideScreen(screenName, fadeOut)
	-- Hide a UI screen with optional fade-out animation
	local screen = self.screens[screenName]
	if not screen then return end
	
	if fadeOut then
		-- Fade out animation
		local connections = {}
		local elementsToFade = {}
		
		for _, element in ipairs(screen:GetDescendants()) do
			if element:IsA("GuiObject") then
				table.insert(elementsToFade, element)
			end
		end
		
		local completed = 0
		for _, element in ipairs(elementsToFade) do
			local tween = TweenService:Create(
				element,
				TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
				{BackgroundTransparency = 1}
			)
			tween.Completed:Connect(function()
				completed += 1
				if completed == #elementsToFade then
					screen.Enabled = false
				end
			end)
			tween:Play()
		end
	else
		screen.Enabled = false
	end
	
	if self.currentScreen == screenName then
		self.currentScreen = nil
	end
end

function UIManager:LoadImage(imageName)
	-- Load an image from assets/ui/images/
	if UIImages then
		local image = UIImages:FindFirstChild(imageName)
		if image then
			return image
		end
	end
	warn("Image not found: " .. imageName)
	return nil
end

return UIManager

