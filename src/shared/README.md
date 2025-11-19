# Shared Modules Directory

Code modules used by both client and server scripts.

## 📁 What Goes Here

- `.lua` files - Shared modules
- Configuration files
- Utility functions
- Data structures

## 🔄 How It Works

- Modules sync to `ReplicatedStorage.Shared` via Rojo
- Can be `require()`d by both client and server scripts
- Perfect for shared logic and configuration

## 📝 Common Use Cases

- **Configuration** (game settings, constants)
- **Utility functions** (helper functions)
- **Data structures** (player data, game state)
- **Shared enums** (game states, item types)
- **Validation functions**

## ⚡ Auto-Sync

All `.lua` files **automatically sync** to Studio when you save them!

## 📚 Examples

- `GameConfig.lua` - Game configuration and settings
- `PlayerData.lua` - Player data structure
- `init.lua` - Shared utilities

## 💡 Tips

- Keep shared modules pure (no side effects)
- Use for code that both client and server need
- Don't put client-only or server-only code here
- Use `return` to export modules

## 📖 Usage Example

```lua
-- In client or server script
local GameConfig = require(game:GetService("ReplicatedStorage").Shared.GameConfig)
local maxHealth = GameConfig.Player.MaxHealth
```

