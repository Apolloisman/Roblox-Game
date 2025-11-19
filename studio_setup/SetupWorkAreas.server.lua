-- Auto-Setup Work Areas in Studio
-- Place this script in ServerScriptService
-- It will create work stations for farms, factories, and houses

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("ServerConfig"))

-- Function to create work station
local function createWorkStation(workAreaName, workAreaConfig, stationNumber)
	local station = Instance.new("Part")
	station.Name = workAreaName .. "Station" .. stationNumber
	station.Size = Vector3.new(4, 2, 4)
	station.Position = workAreaConfig.Position + Vector3.new(stationNumber * 5, 0, 0)
	station.Anchored = true
	station.CanCollide = true
	station.BrickColor = BrickColor.new("Brown")
	station.Material = Enum.Material.Wood
	station.Parent = workspace
	
	-- Add ProximityPrompt
	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Start Working"
	prompt.ObjectText = workAreaConfig.Name
	prompt.RequiresLineOfSight = false
	prompt.MaxActivationDistance = 10
	prompt.HoldDuration = 0
	prompt.Parent = station
	
	-- Add interaction script
	local script = Instance.new("Script")
	script.Name = "WorkStationScript"
	script.Parent = station
	
	script.Source = [[
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
		
		script.Parent.ProximityPrompt.Triggered:Connect(function(player)
			local workAreaName = "]] .. workAreaName .. [["
			RemoteEvents.StartWork:FireServer(workAreaName)
		end)
	]]
	
	-- Add label
	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 200, 0, 50)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.Parent = station
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = workAreaConfig.Name .. "\n" .. workAreaConfig.GoldPerWork .. " gold/10s"
	label.TextColor3 = Color3.fromRGB(255, 215, 0)
	label.TextSize = 14
	label.Font = Enum.Font.GothamBold
	label.Parent = billboard
	
	print("Created work station: " .. workAreaConfig.Name)
end

-- Create work areas
for workAreaName, workAreaConfig in pairs(ServerConfig.WorkAreas) do
	-- Create 3 work stations per area
	for i = 1, 3 do
		createWorkStation(workAreaName, workAreaConfig, i)
	end
end

print("All work areas created!")

