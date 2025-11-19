-- Main Menu UI Component
-- Example UI screen using UIManager
-- Design this in Figma, then implement here

local UIManager = require(script.Parent.UIManager)
local uiManager = UIManager.new()

-- Create main menu screen
local mainMenu = uiManager:CreateScreen("MainMenu")

-- Main frame (designed in Figma, dimensions match your design)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 800, 0, 600)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0, "Center", "Center")
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = mainMenu

-- Background image (exported from Figma)
local backgroundImage = Instance.new("ImageLabel")
backgroundImage.Name = "Background"
backgroundImage.Size = UDim2.new(1, 0, 1, 0)
backgroundImage.BackgroundTransparency = 1
-- Load from assets/ui/images/ via UIManager
backgroundImage.Image = "rbxasset://assets/ui/images/menu_background.png" -- Update path
backgroundImage.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0, 400, 0, 80)
title.Position = UDim2.new(0.5, 0, 0, 50)
title.AnchorPoint = Vector2.new(0.5, 0)
title.BackgroundTransparency = 1
title.Text = "GAME TITLE"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 48
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Play Button (design in Figma, implement here)
local playButton = Instance.new("TextButton")
playButton.Name = "PlayButton"
playButton.Size = UDim2.new(0, 200, 0, 50)
playButton.Position = UDim2.new(0.5, 0, 0.5, 0)
playButton.AnchorPoint = Vector2.new(0.5, 0.5)
playButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
playButton.Text = "PLAY"
playButton.TextColor3 = Color3.fromRGB(255, 255, 255)
playButton.TextSize = 24
playButton.Font = Enum.Font.Gotham
playButton.Parent = mainFrame

-- Button hover effect
playButton.MouseEnter:Connect(function()
	local tween = game:GetService("TweenService"):Create(
		playButton,
		TweenInfo.new(0.2),
		{BackgroundColor3 = Color3.fromRGB(0, 200, 255)}
	)
	tween:Play()
end)

playButton.MouseLeave:Connect(function()
	local tween = game:GetService("TweenService"):Create(
		playButton,
		TweenInfo.new(0.2),
		{BackgroundColor3 = Color3.fromRGB(0, 162, 255)}
	)
	tween:Play()
end)

-- Show menu on start
uiManager:ShowScreen("MainMenu", true)

-- Hide menu when play is clicked
playButton.MouseButton1Click:Connect(function()
	uiManager:HideScreen("MainMenu", true)
	-- Add your game start logic here
end)

