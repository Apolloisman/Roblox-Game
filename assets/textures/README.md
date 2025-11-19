# Textures Directory

Texture files (materials, patterns) for 3D models and surfaces.

## 📁 What Goes Here

- `.png` files - Textures with transparency
- `.jpg` files - Textures without transparency
- `.tga` files - High-quality textures

## 🔄 How to Use

1. **Add texture files** to this directory
2. **Auto-sync** via Rojo to `ReplicatedStorage.Assets.Textures`
3. **Apply to models** in Studio or via code:
   ```lua
   local texture = game:GetService("ReplicatedStorage").Assets.Textures:FindFirstChild("wood_grain")
   ```

## 📝 Notes

- Textures sync to `ReplicatedStorage.Assets.Textures` via Rojo
- Use descriptive names: `wood_grain.png`, `metal_rust.jpg`
- Recommended resolution: 512x512, 1024x1024, or 2048x2048
- Commit textures with `.\auto_commit.ps1 -Push`

## 💡 Tips

- Use power-of-2 dimensions (256, 512, 1024, 2048)
- Keep file sizes reasonable
- Use `.png` for textures that need transparency
- Use `.jpg` for large textures without transparency

