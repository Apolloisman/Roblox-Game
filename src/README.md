# Source Code Directory

All game scripts and code for your Roblox game.

## 📁 Structure

```
src/
├── client/    # Client-side scripts (runs on player's device)
├── server/    # Server-side scripts (runs on Roblox servers)
└── shared/    # Shared modules (used by both client and server)
```

## 🔄 How Code Syncs to Roblox

- **Client scripts** → `StarterPlayer.StarterPlayerScripts`
- **Server scripts** → `ServerScriptService`
- **Shared modules** → `ReplicatedStorage.Shared`

## ⚡ Auto-Sync

All `.lua` files **automatically sync** to Roblox Studio via Rojo when you save them!

## 📝 Workflow

1. **Edit** `.lua` files in VS Code/Cursor
2. **Save** → Instantly appears in Studio
3. **Test** in Studio
4. **Commit** with `.\auto_commit.ps1 -Push`

## 📚 Related Documentation

- `src/client/README.md` - Client scripts guide
- `src/server/README.md` - Server scripts guide
- `src/shared/README.md` - Shared modules guide
- `WORKFLOW_EXPLAINED.md` - Complete workflow guide

