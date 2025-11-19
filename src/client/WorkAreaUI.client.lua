-- Work Area UI
-- Handles UI for working in farms, factories, houses

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local ServerConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("ServerConfig"))

local WorkAreaUI = {}
WorkAreaUI.WorkFrame = nil
WorkAreaUI.IsWorking = false

function WorkAreaUI:Initialize()
	self:CreateWorkUI()
	
	-- Listen for work status
	RemoteEvents.StartWork.OnClientEvent:Connect(function(success, result)
		if success then
			self.IsWorking = true
			self:UpdateWorkStatus(result)
		end
	end)
	
	RemoteEvents.StopWork.OnClientEvent:Connect(function(success, result)
		if success then
			self.IsWorking = false
			self:UpdateWorkStatus(nil)
		end
	end)
end

function WorkAreaUI:CreateWorkUI()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "WorkAreaUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui
	
	-- Work Status Frame
	local workFrame = Instance.new("Frame")
	workFrame.Name = "WorkStatusFrame"
	workFrame.Size = UDim2.new(0, 300, 0, 150)
	workFrame.Position = UDim2.new(1, -320, 0, 10)
	workFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	workFrame.BorderSizePixel = 2
	workFrame.BorderColor3 = Color3.fromRGB(100, 255, 150)
	workFrame.Visible = false
	workFrame.Parent = screenGui
	
	-- Title
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "TitleLabel"
	titleLabel.Size = UDim2.new(1, -20, 0, 30)
	titleLabel.Position = UDim2.new(0, 10, 0, 10)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "Working"
	titleLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
	titleLabel.TextSize = 18
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = workFrame
	
	-- Work Area Name
	local areaLabel = Instance.new("TextLabel")
	areaLabel.Name = "AreaLabel"
	areaLabel.Size = UDim2.new(1, -20, 0, 25)
	areaLabel.Position = UDim2.new(0, 10, 0, 45)
	areaLabel.BackgroundTransparency = 1
	areaLabel.Text = ""
	areaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	areaLabel.TextSize = 14
	areaLabel.Font = Enum.Font.Gotham
	areaLabel.TextXAlignment = Enum.TextXAlignment.Left
	areaLabel.Parent = workFrame
	
	-- Gold Earned
	local goldLabel = Instance.new("TextLabel")
	goldLabel.Name = "GoldLabel"
	goldLabel.Size = UDim2.new(1, -20, 0, 25)
	goldLabel.Position = UDim2.new(0, 10, 0, 75)
	goldLabel.BackgroundTransparency = 1
	goldLabel.Text = "Gold Earned: 0"
	goldLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
	goldLabel.TextSize = 14
	goldLabel.Font = Enum.Font.Gotham
	goldLabel.TextXAlignment = Enum.TextXAlignment.Left
	goldLabel.Parent = workFrame
	
	-- Stop Button
	local stopButton = Instance.new("TextButton")
	stopButton.Name = "StopButton"
	stopButton.Size = UDim2.new(0, 100, 0, 30)
	stopButton.Position = UDim2.new(0.5, -50, 1, -40)
	stopButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
	stopButton.Text = "Stop Working"
	stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	stopButton.TextSize = 12
	stopButton.Font = Enum.Font.GothamBold
	stopButton.Parent = workFrame
	
	stopButton.MouseButton1Click:Connect(function()
		RemoteEvents.StopWork:FireServer()
	end)
	
	WorkAreaUI.WorkFrame = workFrame
	
	-- Update gold earned periodically
	spawn(function()
		while true do
			wait(1)
			if self.IsWorking and self.WorkFrame then
				-- Update will be handled by server
			end
		end
	end)
end

function WorkAreaUI:UpdateWorkStatus(workData)
	if not self.WorkFrame then return end
	
	if workData then
		self.WorkFrame.Visible = true
		local areaName = ServerConfig.WorkAreas[workData.WorkArea] and ServerConfig.WorkAreas[workData.WorkArea].Name or workData.WorkArea
		self.WorkFrame.AreaLabel.Text = "Area: " .. areaName
		self.WorkFrame.GoldLabel.Text = "Gold Earned: " .. workData.GoldEarned
	else
		self.WorkFrame.Visible = false
	end
end

function WorkAreaUI:ShowWorkMenu(workAreaName)
	-- Show menu to start work
	RemoteEvents.StartWork:FireServer(workAreaName)
end

return WorkAreaUI

