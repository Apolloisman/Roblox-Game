# Animations Directory

Animation files for your Roblox game.

## 📁 What Goes Here

- `.rbxa` files - Roblox animation files
- `.fbx` files - Animation exports from Blender/Fusion 360

## 🔄 How to Use

1. **Export animations** from Blender or other tools
2. **Save** to this directory
3. **Import** into Roblox Studio:
   - Drag `.rbxa` files into `ReplicatedStorage.Assets.Animations`
   - Or import via Studio's Animation Editor

## 📝 Notes

- Animations sync to `ReplicatedStorage.Assets.Animations` via Rojo
- Use descriptive names: `player_walk.rbxm`, `sword_swing.rbxm`
- Commit animations with `.\auto_commit.ps1 -Push`

