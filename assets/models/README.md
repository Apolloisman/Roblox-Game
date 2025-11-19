# Models Directory (ReplicatedStorage)

3D models for items, weapons, and other game objects stored in ReplicatedStorage.

## 📁 What Goes Here

- `.fbx` files - Source model files from Blender/Fusion 360
- `.rbxm` files - Roblox model files (converted from FBX)

## 🔄 How to Use

### Using the Workflow Script

```powershell
# Export from Blender and convert
.\model_to_roblox.ps1 -Source blender -ModelName "sword" -Destination ReplicatedStorage -AutoCommit
```

### Manual Process

1. **Export** model as `.fbx` from Blender/Fusion 360
2. **Save** to this directory
3. **Import** into Studio → `ReplicatedStorage.Assets.Models`
4. **Export** as `.rbxm` and save back here
5. **Commit** with `.\auto_commit.ps1 -Push`

## 📝 Notes

- Models sync to `ReplicatedStorage.Assets.Models` via Rojo
- `.rbxm` files need manual drag into Studio (Rojo doesn't auto-sync binary files)
- Use descriptive names: `iron_sword.fbx`, `health_potion.fbx`

## 🔗 Related

- `assets/workspace_models/` - For environment/building models
- `model_to_roblox.ps1` - Automated workflow script

