# Assets Directory

All game assets (models, UI, sounds, textures, animations) for your Roblox game.

## 📁 Structure

```
assets/
├── animations/        # Animation files (.rbxa, .fbx)
├── models/           # Models for ReplicatedStorage (weapons, items, etc.)
├── sounds/           # Audio files (.mp3, .ogg, .wav)
├── textures/         # Texture files (.png, .jpg)
├── ui/               # UI assets (buttons, icons, images, designs)
└── workspace_models/ # Models for Workspace (environment, buildings)
```

## 🔄 How Assets Sync to Roblox

- **Models** → `ReplicatedStorage.Assets.Models` or `Workspace.Models`
- **UI Images** → `ReplicatedStorage.Assets.UI.Images`
- **UI Icons** → `ReplicatedStorage.Assets.UI.Icons`
- **Textures** → `ReplicatedStorage.Assets.Textures`
- **Sounds** → `ReplicatedStorage.Assets.Sounds`
- **Animations** → `ReplicatedStorage.Assets.Animations`

## 📝 Workflow

1. **Add assets** to appropriate folders
2. **Auto-sync** via Rojo (images, textures sync automatically)
3. **Models** (.rbxm) need manual drag into Studio
4. **Commit** changes with `.\auto_commit.ps1 -Push`

## 📚 Related Documentation

- `assets/ui/README.md` - UI assets guide
- `assets/ui/ORGANIZATION.md` - UI organization guide
- `README.md` - Main project documentation

