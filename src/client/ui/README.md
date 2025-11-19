# UI Client Scripts Directory

Client-side scripts specifically for UI management and components.

## 📁 What Goes Here

- `.lua` files - UI-related client scripts
- UI component scripts
- UI management systems

## 🔄 How It Works

- Scripts sync to `StarterPlayer.StarterPlayerScripts` via Rojo
- Run on **each player's device**
- Manage UI elements, menus, and HUDs

## 📝 Common Use Cases

- **UI management** (showing/hiding screens)
- **Menu systems** (main menu, settings, inventory)
- **HUD components** (health bar, minimap, score)
- **UI animations** (transitions, effects)
- **Input handling** (button clicks, keyboard shortcuts)

## ⚡ Auto-Sync

All `.lua` files **automatically sync** to Studio when you save them!

## 📚 Examples

- `UIManager.client.lua` - UI management system
- `MainMenu.client.lua` - Main menu component
- `InventoryUI.client.lua` - Inventory screen
- `HUD.client.lua` - Heads-up display

## 💡 Tips

- Keep UI logic separate from game logic
- Use ScreenGuis for full-screen UI
- Use BillboardGuis for 3D world UI
- Reference images from `ReplicatedStorage.Assets.UI.Images`

## 🔗 Related

- `assets/ui/` - UI assets (images, icons, buttons)
- `assets/ui/ORGANIZATION.md` - UI organization guide

