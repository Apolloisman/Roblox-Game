# Model Import Guide

All models have been created in Blender and exported as FBX files!

## Models Created

✅ **School Building** - `school.fbx`
- Main building with roof, door, windows
- Ready to import

✅ **Town Hall** - `townhall.fbx`
- Government building with columns
- Ready to import

✅ **Shops** - `shops.fbx`
- 4 shop buildings (Weapon, Armor, General, Housing)
- All in one file

✅ **Teleporters** - `teleporters.fbx`
- 8 teleporters (5 dungeons + 3 upper tiers)
- Archway design with platforms

✅ **Work Stations** - `work_stations.fbx`
- 9 work stations (3 farms, 3 factories, 3 houses)
- Tables with legs

✅ **NPC Stands** - `npc_stands.fbx`
- 7 platforms for NPCs to stand on
- Positioned at NPC locations

✅ **Environment** - `environment.fbx`
- Ground plane
- Spawn platform

## How to Import

### Method 1: Using the Import Script

```powershell
# Import all models
.\import_models_to_roblox.ps1 -AutoCommit
```

This will:
1. Convert FBX to .rbxm
2. Guide you through Studio import
3. Commit to Git (if -AutoCommit)

### Method 2: Manual Import

1. **Open Roblox Studio**
2. **Open your main server place**
3. **For each FBX file:**
   - Go to **View** → **Toolbox**
   - Click **Import** tab
   - Drag `assets/models/[model].fbx` into Studio
   - Models will appear in Workspace

4. **Position Models:**
   - Models are already positioned correctly
   - They should appear at the right locations

## Model Locations

Models are positioned at:
- **School**: (0, 0, 0)
- **Town Hall**: (-15, 0, 0)
- **Shops**: (7.5, 0, 0) and nearby
- **Teleporters**: (10, 0, 0) and spaced out
- **Work Stations**: At work area locations
- **NPC Stands**: At NPC positions

## After Import

1. **Models will be in Workspace**
2. **Add scripts to models:**
   - Use the setup scripts from `studio_setup/`
   - Or add ProximityPrompts manually

3. **Test:**
   - Play test
   - Walk around
   - Models should be visible

## Customization

After importing, you can:
- Change materials/colors
- Add details
- Resize if needed
- Add decorations

The models are functional but basic - customize them to match your vision!

## Troubleshooting

**Models not appearing?**
- Check FBX files exist in `assets/models/`
- Verify import worked in Studio
- Check Workspace for models

**Wrong positions?**
- Models are positioned in Blender coordinates
- Adjust in Studio if needed
- Use Move tool to reposition

**Missing parts?**
- All parts should be in the FBX
- Check if parts are grouped correctly
- Verify object names start with prefixes

## Next Steps

1. Import all models ✅
2. Add ProximityPrompts (use setup scripts)
3. Test interactions
4. Customize appearance
5. Add more details

All models are ready to use! 🎨

