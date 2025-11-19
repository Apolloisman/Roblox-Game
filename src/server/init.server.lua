-- Main Server Initialization
-- Initializes all server systems

local PlayerManager = require(script.PlayerManager)
local StartingArea = require(script.StartingArea)
local DungeonManager = require(script.DungeonManager)
local ClanManager = require(script.ClanManager)
local RemoteEvents = require(script.RemoteEvents)

-- Initialize all systems
print("Initializing game systems...")

PlayerManager:Initialize()
StartingArea:Initialize()
DungeonManager:Initialize()
ClanManager:Initialize()
require(script.RemoteEvents) -- This sets up RemoteEvents

print("All systems initialized!")

-- Handle server shutdown
game:BindToClose(function()
	print("Saving all player data...")
	PlayerManager:SaveAllPlayers()
	print("Server shutting down...")
end)
