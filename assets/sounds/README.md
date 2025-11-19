# Sounds Directory

Audio files (music, sound effects) for your Roblox game.

## 📁 What Goes Here

- `.mp3` files - Music and sound effects
- `.ogg` files - Compressed audio (recommended for Roblox)
- `.wav` files - Uncompressed audio

## 🔄 How to Use

1. **Add audio files** to this directory
2. **Auto-sync** via Rojo to `ReplicatedStorage.Assets.Sounds`
3. **Reference in code:**
   ```lua
   local sound = game:GetService("ReplicatedStorage").Assets.Sounds:FindFirstChild("background_music")
   ```

## 📝 Notes

- Sounds sync to `ReplicatedStorage.Assets.Sounds` via Rojo
- Use descriptive names: `background_music.mp3`, `sword_hit.ogg`
- `.ogg` format is recommended for smaller file sizes
- Commit sounds with `.\auto_commit.ps1 -Push`

## 💡 Tips

- Keep file sizes reasonable (under 5MB per file)
- Use `.ogg` for better compression
- Name files clearly: `ui_button_click.ogg`, `ambient_forest.mp3`

