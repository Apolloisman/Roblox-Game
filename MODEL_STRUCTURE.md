# Model Structure Guide

Complete guide for building all models and structures in Roblox Studio.

## Main Server Structure

### Starting Area (School/Town Hall)

**Location:** Center of main server (0, 5, 0)

**Models Needed:**
- **School Building**
  - Large building with multiple floors
  - Entrance area
  - Classrooms
  - NPC spawn points
  
- **Town Hall**
  - Government building
  - Meeting rooms
  - NPC offices
  
- **Spawn Points**
  - Multiple spawn locations
  - All players spawn here initially

**NPCs to Place:**
- Headmaster Thorne (near entrance)
- Elder Maria (in courtyard)
- Other social NPCs

### City Area

**Location:** Around starting area

**Models Needed:**
- **Shop Buildings**
  - Weapon Shop (Gareth the Blacksmith)
  - Armor Shop (Lydia the Armorer)
  - General Store (Marcus the Merchant)
  - Housing Office (Sophia the Realtor)
  
- **City Streets**
  - Roads connecting areas
  - Street lamps
  - Decorative elements

### Work Areas

**Farms:**
- Location: Vector3.new(100, 5, 100)
- Models: Farm fields, barns, work stations
- NPCs: Farm workers
- Work points: Interactable objects for working

**Factories:**
- Location: Vector3.new(200, 5, 100)
- Models: Factory buildings, machinery, work stations
- NPCs: Factory workers
- Work points: Manufacturing stations

**Housing District:**
- Location: Vector3.new(0, 5, 200)
- Models: Houses of different tiers
- NPCs: Housing agent
- Work points: Construction sites

### Teleportation Points

**Dungeon Teleporters:**
- 5 teleporters (one per tier)
- Location: Near starting area
- Visual: Portal/archway models
- Proximity prompts for interaction

**Upper Tier Teleporters:**
- 3 teleporters (Artisan, Merchant, Noble)
- Location: Upper tier area
- Visual: Prestigious archways
- Tier-gated access

## Dungeon Servers

### Tier 1 Dungeon Server
- Simple dungeon layout
- Basic enemies
- Entry/exit points
- Boss room

### Tier 2-5 Dungeon Servers
- Progressively more complex
- Stronger enemies
- Better rewards
- Unique themes

## Upper Tier Servers

### Artisan District
- Upscale area
- Better shops
- Manufacturing facilities
- Exclusive NPCs

### Merchant District
- Luxury area
- Premium shops
- Business district
- High-tier NPCs

### Noble Estate
- Palace-like area
- Best shops
- Exclusive content
- Champion clan access

## Model Creation Workflow

### 1. Create Base Structures
```
1. Build School/Town Hall
2. Create shop buildings
3. Set up work areas
4. Place teleporters
```

### 2. Add NPCs
```
1. Create NPC models (use R15 rigs)
2. Add ProximityPrompts
3. Set up NPC scripts
4. Position NPCs in correct locations
```

### 3. Set Up Work Points
```
1. Create work station models
2. Add ProximityPrompts
3. Connect to WorkAreaManager
4. Add visual feedback
```

### 4. Create Teleporters
```
1. Build teleporter models
2. Add ProximityPrompts
3. Connect to TeleportManager
4. Add visual effects
```

## NPC Setup

### Creating NPCs

1. **Spawn NPC Model:**
   - Use R15 character rig
   - Customize appearance
   - Name: NPC ID (e.g., "headmaster")

2. **Add ProximityPrompt:**
   ```lua
   local prompt = Instance.new("ProximityPrompt")
   prompt.ActionText = "Talk"
   prompt.ObjectText = "Headmaster Thorne"
   prompt.RequiresLineOfSight = false
   prompt.MaxActivationDistance = 10
   ```

3. **Add Script:**
   ```lua
   -- In NPC model
   local ReplicatedStorage = game:GetService("ReplicatedStorage")
   local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
   
   script.Parent.ProximityPrompt.Triggered:Connect(function(player)
       RemoteEvents.TalkToNPC:FireServer("headmaster", "Welcome")
   end)
   ```

## Work Point Setup

### Creating Work Stations

1. **Create Model:**
   - Work station model (table, machine, etc.)
   - Position in work area

2. **Add ProximityPrompt:**
   ```lua
   local prompt = Instance.new("ProximityPrompt")
   prompt.ActionText = "Start Working"
   prompt.ObjectText = "Farm Work"
   ```

3. **Add Script:**
   ```lua
   local ReplicatedStorage = game:GetService("ReplicatedStorage")
   local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
   
   script.Parent.ProximityPrompt.Triggered:Connect(function(player)
       RemoteEvents.StartWork:FireServer("Farms")
   end)
   ```

## Teleporter Setup

### Creating Teleporters

1. **Create Model:**
   - Portal/archway model
   - Visual effects (particles, glow)

2. **Add ProximityPrompt:**
   ```lua
   local prompt = Instance.new("ProximityPrompt")
   prompt.ActionText = "Enter"
   prompt.ObjectText = "Tier 1 Dungeon"
   ```

3. **Add Script:**
   ```lua
   local ReplicatedStorage = game:GetService("ReplicatedStorage")
   local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
   
   script.Parent.ProximityPrompt.Triggered:Connect(function(player)
       RemoteEvents.TeleportToDungeon:FireServer("Tier1")
   end)
   ```

## Recommended Model Sources

1. **Roblox Store:**
   - Search for building models
   - Shop interiors
   - Farm/industrial models

2. **Blender:**
   - Create custom models
   - Export as FBX
   - Use `model_to_roblox.ps1` workflow

3. **Fusion 360:**
   - Create architectural models
   - Export as FBX
   - Use `model_to_roblox.ps1` workflow

## Quick Setup Checklist

- [ ] Create School/Town Hall building
- [ ] Place all NPCs with ProximityPrompts
- [ ] Create shop buildings
- [ ] Set up work areas (farms, factories, houses)
- [ ] Create teleporter models
- [ ] Set up dungeon teleporters
- [ ] Set up upper tier teleporters
- [ ] Add work station models
- [ ] Connect all ProximityPrompts to RemoteEvents
- [ ] Test all interactions

## Model Organization

```
Workspace/
├── StartingArea/
│   ├── School/
│   ├── TownHall/
│   └── NPCs/
├── City/
│   ├── Shops/
│   └── Streets/
├── WorkAreas/
│   ├── Farms/
│   ├── Factories/
│   └── Houses/
└── Teleporters/
    ├── Dungeons/
    └── UpperTiers/
```

All models should be organized in folders for easy management!

