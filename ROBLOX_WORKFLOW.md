# Roblox + GitHub workflow

1. Install Roblox Studio and the Rojo plugin from the Studio marketplace.
2. Install Aftman (https://github.com/LPGhatguy/aftman). Inside this repo run ftman trust rojo-rbx/rojo && aftman add rojo-rbx/rojo, then keep tools current with ftman install.
3. Start the sync server with ftman run rojo serve (or ojo serve if the binary is on your PATH) to expose the file tree defined in default.project.json.
4. In Studio, open your place, run the Rojo plugin, and connect to the displayed port (34872 by default).
5. Any changes you make inside src/ or ssets/ mirror into Studio automatically while the connection is active.
6. When you edit instances in Studio, use the Rojo plugin's Pull button (or run ftman run rojo pull) to write the changes back into the repo before committing to Git.
7. Commit and push the repo to GitHub as usual; your scripts, UI, and assets now travel with your project history.

Folder mapping recap:
- src/server → ServerScriptService
- src/client → StarterPlayer.StarterPlayerScripts
- src/shared → ReplicatedStorage.Shared
- ssets/ui → StarterGui
- ssets/* → ReplicatedStorage.Assets (subfolders for models, sounds, textures, animations)

Adjust default.project.json as your game grows (e.g., add ServerStorage, Workspace collections, or new asset buckets).
