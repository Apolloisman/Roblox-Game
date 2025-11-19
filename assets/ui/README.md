# UI Assets Directory

This directory contains all UI-related assets for your Roblox game.

## 📖 **Start Here: Organization Guide**

See `ORGANIZATION.md` for complete details on where to put everything!

## Structure

```
assets/ui/
├── buttons/         # Button images (menu/, game/)
├── icons/           # Icon files (game/, ui/)
├── images/          # Background images, textures (auto-syncs to Roblox)
├── inspiration/     # Design inspiration (screenshots/, references/)
├── designs/         # Figma files, mockups
└── components/      # Reusable UI component definitions
```

## Workflow

### 1. Design in Figma
- Create UI mockups
- Design menus, HUDs, inventory screens
- Export assets as PNG/JPG

### 2. Export Assets
- Images → `images/`
- Icons → `icons/`
- Design files → `designs/`

### 3. Generate Code with Cursor
- Use Cursor AI to generate Luau UI code
- Create components in `src/client/ui/`
- Reference images from `assets/ui/images/`

### 4. Sync via Rojo
- Images sync to StarterGui
- Scripts sync to StarterPlayerScripts
- Everything commits to GitHub

## Design Resources

- **Figma**: https://www.figma.com - Design UI mockups
- **Dribbble**: https://dribbble.com - UI/UX inspiration
- **Lapa Ninja**: https://www.lapa.ninja - Landing page designs
- **Solar Icons**: https://icon-sets.iconify.design/solar/ - Icon library

## Tips

1. **Design System**: Create a consistent color palette and typography in Figma
2. **Component Library**: Build reusable UI components
3. **Responsive Design**: Design for different screen sizes
4. **Export Settings**: Use 2x resolution for crisp images in Roblox
5. **Naming Convention**: Use clear, descriptive names (e.g., `menu_background.png`)

## Example UI Components

See `src/client/ui/` for example UI components:
- `UIManager.client.lua` - UI management system
- `MainMenu.client.lua` - Example main menu

