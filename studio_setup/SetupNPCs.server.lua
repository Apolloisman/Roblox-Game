-- Auto-Setup NPCs in Studio
-- Place this script in ServerScriptService
-- It will automatically create NPCs with ProximityPrompts based on NPCConfig

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- Wait for shared modules
local NPCConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("NPCConfig"))

-- Function to create NPC
local function createNPC(npcConfig, areaName)
	-- Create NPC model (you'll need to replace this with actual NPC model)
	local npcModel = Instance.new("Model")
	npcModel.Name = npcConfig.Id
	
	-- Create Humanoid (basic NPC structure)
	local humanoidRootPart = Instance.new("Part")
	humanoidRootPart.Name = "HumanoidRootPart"
	humanoidRootPart.Size = Vector3.new(2, 2, 1)
	humanoidRootPart.Position = npcConfig.Position
	humanoidRootPart.Anchored = true
	humanoidRootPart.CanCollide = false
	humanoidRootPart.BrickColor = BrickColor.new("Bright blue")
	humanoidRootPart.Parent = npcModel
	
	local humanoid = Instance.new("Humanoid")
	humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	humanoid.Parent = npcModel
	
	-- Add ProximityPrompt
	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Talk"
	prompt.ObjectText = npcConfig.Name
	prompt.RequiresLineOfSight = false
	prompt.MaxActivationDistance = 10
	prompt.HoldDuration = 0
	prompt.Parent = humanoidRootPart
	
	-- Add interaction script
	local interactionScript = Instance.new("Script")
	interactionScript.Name = "NPCInteraction"
	interactionScript.Parent = humanoidRootPart
	
	interactionScript.Source = [[
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
		
		script.Parent.ProximityPrompt.Triggered:Connect(function(player)
			local npcId = script.Parent.Parent.Name
			RemoteEvents.TalkToNPC:FireServer(npcId, "Welcome")
		end)
	]]
	
	-- Add shop script if shopkeeper
	if npcConfig.Type == "Shopkeeper" then
		local shopScript = Instance.new("Script")
		shopScript.Name = "ShopAccess"
		shopScript.Parent = humanoidRootPart
		
		shopScript.Source = [[
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
			
			-- Add second prompt for shop
			local shopPrompt = Instance.new("ProximityPrompt")
			shopPrompt.ActionText = "Shop"
			shopPrompt.ObjectText = "]] .. npcConfig.Name .. [["
			shopPrompt.RequiresLineOfSight = false
			shopPrompt.MaxActivationDistance = 10
			shopPrompt.HoldDuration = 0
			shopPrompt.Parent = script.Parent
			
			shopPrompt.Triggered:Connect(function(player)
				local npcId = script.Parent.Parent.Name
				RemoteEvents.GetShopInventory:FireServer(npcId)
			end)
		]]
	end
	
	npcModel.Parent = workspace
	
	-- Add billboard with name
	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 200, 0, 50)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.Parent = humanoidRootPart
	
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, 0, 1, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = npcConfig.Name
	nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameLabel.TextSize = 18
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.Parent = billboard
	
	print("Created NPC: " .. npcConfig.Name .. " at " .. tostring(npcConfig.Position))
end

-- Create all NPCs
for areaName, npcs in pairs(NPCConfig) do
	for _, npcConfig in ipairs(npcs) do
		createNPC(npcConfig, areaName)
	end
end

print("All NPCs created!")

