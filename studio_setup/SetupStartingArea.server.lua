-- Auto-Setup Starting Area in Studio
-- Place this script in ServerScriptService
-- It will create the school/town hall area

local function createStartingArea()
	-- Create spawn location
	local spawnPart = Instance.new("SpawnLocation")
	spawnPart.Name = "StartingArea"
	spawnPart.Size = Vector3.new(20, 1, 20)
	spawnPart.Position = Vector3.new(0, 0.5, 0)
	spawnPart.BrickColor = BrickColor.new("Bright green")
	spawnPart.Material = Enum.Material.Grass
	spawnPart.Anchored = true
	spawnPart.CanTouch = false
	spawnPart.Parent = workspace
	
	-- Create school building (simple structure)
	local school = Instance.new("Model")
	school.Name = "School"
	school.Parent = workspace
	
	-- Main building
	local building = Instance.new("Part")
	building.Name = "MainBuilding"
	building.Size = Vector3.new(40, 20, 30)
	building.Position = Vector3.new(0, 10, -20)
	building.Anchored = true
	building.BrickColor = BrickColor.new("Light stone grey")
	building.Material = Enum.Material.Concrete
	building.Parent = school
	
	-- Roof
	local roof = Instance.new("Part")
	roof.Name = "Roof"
	roof.Size = Vector3.new(42, 2, 32)
	roof.Position = Vector3.new(0, 21, -20)
	roof.Anchored = true
	roof.BrickColor = BrickColor.new("Dark red")
	roof.Material = Enum.Material.Metal
	roof.Parent = school
	
	-- Door
	local door = Instance.new("Part")
	door.Name = "Door"
	door.Size = Vector3.new(4, 8, 1)
	door.Position = Vector3.new(0, 4, -5.5)
	door.Anchored = true
	door.BrickColor = BrickColor.new("Brown")
	door.Material = Enum.Material.Wood
	door.Parent = school
	
	-- Create town hall (simple structure)
	local townHall = Instance.new("Model")
	townHall.Name = "TownHall"
	townHall.Parent = workspace
	
	local hallBuilding = Instance.new("Part")
	hallBuilding.Name = "HallBuilding"
	hallBuilding.Size = Vector3.new(30, 18, 25)
	hallBuilding.Position = Vector3.new(-30, 9, -20)
	hallBuilding.Anchored = true
	hallBuilding.BrickColor = BrickColor.new("Bright blue")
	hallBuilding.Material = Enum.Material.Concrete
	hallBuilding.Parent = townHall
	
	local hallRoof = Instance.new("Part")
	hallRoof.Name = "Roof"
	hallRoof.Size = Vector3.new(32, 2, 27)
	hallRoof.Position = Vector3.new(-30, 19, -20)
	hallRoof.Anchored = true
	hallRoof.BrickColor = BrickColor.new("Dark red")
	hallRoof.Material = Enum.Material.Metal
	hallRoof.Parent = townHall
	
	-- Create ground
	local ground = Instance.new("Part")
	ground.Name = "Ground"
	ground.Size = Vector3.new(200, 1, 200)
	ground.Position = Vector3.new(0, 0, 0)
	ground.Anchored = true
	ground.BrickColor = BrickColor.new("Bright green")
	ground.Material = Enum.Material.Grass
	ground.Parent = workspace
	
	print("Starting area created!")
end

createStartingArea()

