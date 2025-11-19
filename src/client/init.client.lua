-- Main Client Initialization
-- Initializes all client systems

local GameUI = require(script.GameUI)
local NPCUI = require(script.NPCUI)

-- Initialize UI
GameUI:Initialize()
NPCUI:Initialize()

print("Client systems initialized!")
