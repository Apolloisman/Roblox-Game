# UI Assets Organization Guide

Where to put all your design files, buttons, icons, and inspiration.

## 📁 Directory Structure

```
assets/ui/
├── buttons/              # Button images and assets
│   ├── game/            # In-game buttons (inventory, action buttons)
│   └── menu/            # Menu buttons (play, settings, quit)
│
├── icons/               # Icon files
│   ├── game/           # Game icons (items, weapons, abilities)
│   └── ui/             # UI icons (close, minimize, arrows)
│
├── images/             # Background images, textures
│                       # These auto-sync to ReplicatedStorage.Assets.UI.Images
│
├── inspiration/        # Design inspiration and references
│   ├── screenshots/    # Screenshots from websites (like ORKEN, Lapa Ninja)
│   └── references/     # Reference images, color palettes, typography
│
├── designs/            # Your design files
│   ├── figma/          # Figma design files
│   │   ├── components/ # Reusable UI components
│   │   └── screens/    # Full screen designs (menu, HUD, etc.)
│   └── mockups/        # Design mockups
│       ├── wireframes/ # Early wireframes
│       └── final/      # Final design mockups
│
└── components/         # Code-ready UI components (if any)
```

## 🎯 Where to Put What

### Buttons
- **Menu buttons** (Play, Settings, Quit) → `assets/ui/buttons/menu/`
- **Game buttons** (Inventory, Attack, Interact) → `assets/ui/buttons/game/`
- **Naming:** Use descriptive names like `play_button.png`, `inventory_icon.png`

### Icons
- **Game icons** (swords, potions, items) → `assets/ui/icons/game/`
- **UI icons** (close X, arrows, checkmarks) → `assets/ui/icons/ui/`
- **Naming:** Use clear names like `sword_icon.png`, `close_icon.png`

### Inspiration
- **Website screenshots** (ORKEN, Lapa Ninja) → `assets/ui/inspiration/screenshots/`
- **Color palettes, typography refs** → `assets/ui/inspiration/references/`
- **Naming:** Include source, like `orken_homepage.png`, `dark_fantasy_palette.png`

### Design Files
- **Figma components** → `assets/ui/designs/figma/components/`
- **Figma screens** → `assets/ui/designs/figma/screens/`
- **Wireframes** → `assets/ui/designs/mockups/wireframes/`
- **Final mockups** → `assets/ui/designs/mockups/final/`

### Images (For Roblox)
- **Background images** → `assets/ui/images/`
- **These auto-sync to Roblox** via Rojo
- Use for: menu backgrounds, HUD backgrounds, textures

## 📋 Quick Reference

| What | Where | Example |
|------|-------|---------|
| Menu button image | `buttons/menu/` | `play_button.png` |
| Game icon | `icons/game/` | `sword_icon.png` |
| UI icon | `icons/ui/` | `close_icon.png` |
| Website screenshot | `inspiration/screenshots/` | `orken_design.png` |
| Color palette | `inspiration/references/` | `fantasy_colors.png` |
| Figma component | `designs/figma/components/` | `button_component.fig` |
| Menu background | `images/` | `menu_bg.png` |

## 🔄 Workflow

### 1. Collect Inspiration
```
Find design → Save screenshot → assets/ui/inspiration/screenshots/
```

### 2. Design in Figma
```
Create design → Save to → assets/ui/designs/figma/screens/
Export components → assets/ui/designs/figma/components/
```

### 3. Export Assets
```
Export buttons → assets/ui/buttons/menu/ or buttons/game/
Export icons → assets/ui/icons/game/ or icons/ui/
Export backgrounds → assets/ui/images/
```

### 4. Use in Roblox
```
Images in assets/ui/images/ → Auto-syncs to Studio
Reference in code: ReplicatedStorage.Assets.UI.Images
```

## 💡 Tips

1. **Be consistent with naming:**
   - Use lowercase with underscores: `play_button.png`
   - Include size if multiple: `icon_close_32px.png`, `icon_close_64px.png`

2. **Organize by feature:**
   - Group related assets together
   - Example: All inventory UI in one folder

3. **Version control:**
   - Commit design files to Git
   - Use `.\auto_commit.ps1` to commit changes

4. **Export settings:**
   - Export at 2x resolution for crisp display
   - Use PNG for transparency
   - Use JPG for large backgrounds

## 🚀 Quick Commands

```powershell
# Commit all UI changes
.\auto_commit.ps1 -Message "Add UI assets" -Push

# Check what's in your UI folders
Get-ChildItem -Recurse assets\ui\
```

## 📝 Example: Adding ORKEN-Inspired Assets

1. **Save screenshot:**
   ```
   assets/ui/inspiration/screenshots/orken_homepage.png
   ```

2. **Design in Figma:**
   ```
   assets/ui/designs/figma/screens/main_menu.fig
   ```

3. **Export buttons:**
   ```
   assets/ui/buttons/menu/play_button.png
   assets/ui/buttons/menu/settings_button.png
   ```

4. **Export background:**
   ```
   assets/ui/images/menu_background.png
   ```

5. **Commit:**
   ```powershell
   .\auto_commit.ps1 -Message "Add ORKEN-inspired UI assets" -Push
   ```

Everything is organized and ready to use! 🎨

