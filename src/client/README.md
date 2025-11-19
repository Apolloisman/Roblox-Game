# Client Scripts Directory

Client-side scripts that run on each player's device.

## 📁 What Goes Here

- `.lua` files - Client scripts
- `ui/` - UI-related client scripts

## 🔄 How It Works

- Scripts sync to `StarterPlayer.StarterPlayerScripts` via Rojo
- Run on **each player's device**
- Can access player's camera, input, and local UI

## 📝 Common Use Cases

- **Player input** (keyboard, mouse)
- **UI management** (menus, HUDs)
- **Camera controls**
- **Local effects** (particles, sounds)
- **Client-side validation**

## ⚡ Auto-Sync

All `.lua` files **automatically sync** to Studio when you save them!

## 📚 Examples

- `init.client.lua` - Main client initialization
- `ui/UIManager.client.lua` - UI management system
- `ui/MainMenu.client.lua` - Main menu component

## 💡 Tips

- Client scripts can't modify server data directly
- Use RemoteEvents/RemoteFunctions to communicate with server
- Keep client scripts lightweight for better performance

