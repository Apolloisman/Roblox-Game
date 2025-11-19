-- Main Client Initialization
-- Initializes all client systems

local GameUI = require(script.GameUI)
local NPCUI = require(script.NPCUI)
local TeleportUI = require(script.TeleportUI)
local WorkAreaUI = require(script.WorkAreaUI)
local DungeonUI = require(script.DungeonUI)
local ClanUI = require(script.ClanUI)

-- Initialize UI
GameUI:Initialize()
NPCUI:Initialize()
TeleportUI:Initialize()
WorkAreaUI:Initialize()
DungeonUI:Initialize()
ClanUI:Initialize()

print("Client systems initialized!")
