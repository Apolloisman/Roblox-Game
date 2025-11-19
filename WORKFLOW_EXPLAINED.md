# How Your Workflow Works

## Quick Answer

### Images & Assets
- ✅ **Auto-sync to Roblox** via Rojo (when you save a file, it appears in Studio)
- ❌ **NOT auto-committed** to Git (you need to commit manually)

### Code (`.lua` files)
- ✅ **Auto-sync to Roblox** via Rojo (instant sync when you save)
- ❌ **NOT auto-committed** to Git (you need to commit manually)

## Detailed Workflow

### 1. **Code Files** (`src/server/`, `src/client/`, `src/shared/`)

**What happens:**
1. You edit a `.lua` file in VS Code/Cursor
2. You save the file
3. **Rojo instantly syncs it to Roblox Studio** ✨
4. You see the changes immediately in Studio

**To commit to GitHub:**
```powershell
# Quick commit
.\auto_commit.ps1 -Message "Add new feature" -Push

# Or manually
git add .
git commit -m "Add new feature"
git push
```

**Example:**
```
1. Edit src/server/init.server.lua
2. Save → Instantly appears in ServerScriptService in Studio
3. Run .\auto_commit.ps1 -Push → Uploaded to GitHub
```

### 2. **UI Images** (`assets/ui/images/`, `assets/ui/icons/`)

**What happens:**
1. You export an image from Figma to `assets/ui/images/`
2. **Rojo instantly syncs it to Studio** → `ReplicatedStorage.Assets.UI.Images`
3. You can reference it in your code immediately

**To commit to GitHub:**
```powershell
.\auto_commit.ps1 -Message "Add menu background" -Push
```

**Example:**
```
1. Export menu_bg.png from Figma → assets/ui/images/
2. Save → Instantly available in Studio
3. Use in code: game:GetService("ReplicatedStorage").Assets.UI.Images:FindFirstChild("menu_bg")
4. Run .\auto_commit.ps1 -Push → Uploaded to GitHub
```

### 3. **Models** (`.fbx`, `.rbxm` files)

**What happens:**
1. Use `.\model_to_roblox.ps1` script
2. Script exports from Blender/Fusion 360
3. Script commits to Git (if `-AutoCommit` flag used)
4. You manually drag `.rbxm` into Studio (Rojo doesn't sync binary files)

**Example:**
```powershell
# Auto-commits and pushes
.\model_to_roblox.ps1 -Source blender -ModelName "tree" -AutoCommit
```

## Why Not Auto-Commit Everything?

**Safety reasons:**
- You might make temporary changes you don't want to commit
- You might want to test before committing
- Git history stays clean (only meaningful commits)

**Best practice:**
- Work and test in Studio (auto-sync)
- Commit when you're happy with changes
- Use `.\auto_commit.ps1` for quick commits

## Complete Example Workflow

### Creating a New UI Feature

1. **Design in Figma**
   - Create menu design
   - Export `menu_bg.png`

2. **Add to project**
   ```powershell
   # Copy menu_bg.png to assets/ui/images/
   ```

3. **Image auto-syncs to Studio** ✨
   - Available in `ReplicatedStorage.Assets.UI.Images`

4. **Generate code with Cursor**
   - Ask Cursor: "Create a main menu UI using menu_bg.png"
   - Code goes to `src/client/ui/MainMenu.client.lua`

5. **Code auto-syncs to Studio** ✨
   - Appears in `StarterPlayer.StarterPlayerScripts`

6. **Test in Studio**
   - Everything is already there!

7. **Commit when ready**
   ```powershell
   .\auto_commit.ps1 -Message "Add main menu UI" -Push
   ```

## Summary Table

| File Type | Auto-Sync to Roblox? | Auto-Commit to Git? | How to Commit |
|-----------|---------------------|---------------------|---------------|
| `.lua` code | ✅ Yes (Rojo) | ❌ No | `.\auto_commit.ps1 -Push` |
| Images (`.png`, `.jpg`) | ✅ Yes (Rojo) | ❌ No | `.\auto_commit.ps1 -Push` |
| Models (`.fbx`) | ❌ No | ✅ Yes (if using script) | Script handles it |
| Models (`.rbxm`) | ❌ No | ✅ Yes (if using script) | Script handles it |

## Pro Tips

1. **Keep Rojo running** - Always have `rojo serve` running in a terminal
2. **Use auto_commit.ps1** - Quick way to commit and push
3. **Test before committing** - Auto-sync lets you test, then commit when ready
4. **Use meaningful commit messages** - `.\auto_commit.ps1 -Message "Add health bar UI" -Push`

## Quick Commands

```powershell
# Commit everything and push
.\auto_commit.ps1 -Message "Your message" -Push

# Just commit (don't push)
.\auto_commit.ps1 -Message "Your message"

# Check what changed
git status

# See Rojo sync status
# (Check if files appear in Studio)
```

