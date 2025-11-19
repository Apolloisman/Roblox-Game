# Workspace Models Directory

3D models for environment, buildings, and world objects that go directly into Workspace.

## 📁 What Goes Here

- `.fbx` files - Source model files from Blender/Fusion 360
- `.rbxm` files - Roblox model files (converted from FBX)

## 🔄 How to Use

### Using the Workflow Script

```powershell
# Export from Blender and convert
.\model_to_roblox.ps1 -Source blender -ModelName "tree" -Destination Workspace -AutoCommit
```

### Manual Process

1. **Export** model as `.fbx` from Blender/Fusion 360
2. **Save** to this directory
3. **Import** into Studio → `Workspace.Models`
4. **Export** as `.rbxm` and save back here
5. **Commit** with `.\auto_commit.ps1 -Push`

## 📝 Notes

- Models sync to `Workspace.Models` via Rojo
- `.rbxm` files need manual drag into Studio (Rojo doesn't auto-sync binary files)
- Use descriptive names: `tree_oak.fbx`, `building_house.fbx`

## 🔗 Related

- `assets/models/` - For items/weapons (ReplicatedStorage)
- `model_to_roblox.ps1` - Automated workflow script

