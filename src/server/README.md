# Server Scripts Directory

Server-side scripts that run on Roblox servers (authoritative).

## 📁 What Goes Here

- `.lua` files - Server scripts

## 🔄 How It Works

- Scripts sync to `ServerScriptService` via Rojo
- Run on **Roblox servers** (authoritative)
- Handles game logic, data storage, and security

## 📝 Common Use Cases

- **Game logic** (combat, scoring, rules)
- **Data management** (player data, inventory)
- **Security** (prevent cheating, validate actions)
- **Spawn management** (enemies, items)
- **Server-side calculations**

## ⚡ Auto-Sync

All `.lua` files **automatically sync** to Studio when you save them!

## 📚 Examples

- `init.server.lua` - Main server initialization
- Combat systems
- Data stores
- Game state management

## 💡 Tips

- Server scripts are authoritative (can't be modified by players)
- Use for all important game logic
- Validate all player actions on the server
- Use DataStoreService for saving player data

