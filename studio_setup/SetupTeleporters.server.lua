-- Auto-Setup Teleporters in Studio
-- Place this script in ServerScriptService
-- It will create teleporters for dungeons and upper tiers

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("ServerConfig"))

-- Function to create teleporter
local function createTeleporter(name, position, teleportType, teleportValue)
	local teleporter = Instance.new("Part")
	teleporter.Name = name
	teleporter.Size = Vector3.new(4, 8, 4)
	teleporter.Position = position
	teleporter.Anchored = true
	teleporter.CanCollide = false
	teleporter.BrickColor = BrickColor.new("Bright violet")
	teleporter.Material = Enum.Material.Neon
	teleporter.Parent = workspace
	
	-- Add glow effect
	local pointLight = Instance.new("PointLight")
	pointLight.Color = Color3.fromRGB(150, 100, 255)
	pointLight.Brightness = 2
	pointLight.Range = 20
	pointLight.Parent = teleporter
	
	-- Add ProximityPrompt
	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Enter"
	prompt.ObjectText = name
	prompt.RequiresLineOfSight = false
	prompt.MaxActivationDistance = 15
	prompt.HoldDuration = 0
	prompt.Parent = teleporter
	
	-- Add interaction script
	local script = Instance.new("Script")
	script.Name = "TeleporterScript"
	script.Parent = teleporter
	
	if teleportType == "Dungeon" then
		script.Source = [[
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
			
			script.Parent.ProximityPrompt.Triggered:Connect(function(player)
				local tier = "]] .. teleportValue .. [["
				RemoteEvents.TeleportToDungeon:FireServer(tier)
			end)
		]]
	elseif teleportType == "UpperTier" then
		script.Source = [[
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
			
			script.Parent.ProximityPrompt.Triggered:Connect(function(player)
				local tierName = "]] .. teleportValue .. [["
				RemoteEvents.TeleportToUpperTier:FireServer(tierName)
			end)
		]]
	end
	
	-- Add label
	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 200, 0, 50)
	billboard.StudsOffset = Vector3.new(0, 5, 0)
	billboard.AlwaysOnTop = true
	billboard.Parent = teleporter
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextSize = 16
	label.Font = Enum.Font.GothamBold
	label.Parent = billboard
	
	print("Created teleporter: " .. name)
end

-- Create dungeon teleporters (near starting area)
local dungeonPositions = {
	["Tier 1 Dungeon"] = Vector3.new(20, 5, 0),
	["Tier 2 Dungeon"] = Vector3.new(30, 5, 0),
	["Tier 3 Dungeon"] = Vector3.new(40, 5, 0),
	["Tier 4 Dungeon"] = Vector3.new(50, 5, 0),
	["Tier 5 Dungeon"] = Vector3.new(60, 5, 0),
}

for tier, config in pairs(ServerConfig.Teleportation.DungeonServers) do
	createTeleporter(config.Name, dungeonPositions[config.Name] or Vector3.new(20, 5, 0), "Dungeon", tier)
end

-- Create upper tier teleporters (in upper tier area)
local upperTierPositions = {
	["Artisan District"] = Vector3.new(100, 5, 0),
	["Merchant District"] = Vector3.new(110, 5, 0),
	["Noble Estate"] = Vector3.new(120, 5, 0),
}

for tierName, config in pairs(ServerConfig.Teleportation.UpperTierServers) do
	createTeleporter(config.Name, upperTierPositions[config.Name] or Vector3.new(100, 5, 0), "UpperTier", tierName)
end

print("All teleporters created!")

