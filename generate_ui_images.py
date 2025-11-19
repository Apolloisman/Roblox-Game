"""
Generate UI Images for Roblox Game
Creates all UI images needed: backgrounds, buttons, icons, etc.
"""

from PIL import Image, ImageDraw, ImageFont
import os

# Create output directory
output_dir = "assets/ui/images"
os.makedirs(output_dir, exist_ok=True)

# Color scheme (dark fantasy theme)
COLORS = {
    "bg_dark": (20, 20, 30),
    "bg_medium": (30, 30, 40),
    "bg_light": (40, 40, 50),
    "accent_gold": (255, 215, 0),
    "accent_orange": (255, 150, 100),
    "accent_blue": (100, 150, 255),
    "accent_green": (100, 255, 150),
    "accent_purple": (150, 100, 255),
    "text_white": (255, 255, 255),
    "text_gray": (200, 200, 200),
    "border": (100, 100, 100),
}

def create_gradient_background(width, height, color1, color2, direction="vertical"):
    """Create a gradient background"""
    img = Image.new("RGB", (width, height))
    draw = ImageDraw.Draw(img)
    
    if direction == "vertical":
        for y in range(height):
            ratio = y / height
            r = int(color1[0] * (1 - ratio) + color2[0] * ratio)
            g = int(color1[1] * (1 - ratio) + color2[1] * ratio)
            b = int(color1[2] * (1 - ratio) + color2[2] * ratio)
            draw.line([(0, y), (width, y)], fill=(r, g, b))
    else:
        for x in range(width):
            ratio = x / width
            r = int(color1[0] * (1 - ratio) + color2[0] * ratio)
            g = int(color1[1] * (1 - ratio) + color2[1] * ratio)
            b = int(color1[2] * (1 - ratio) + color2[2] * ratio)
            draw.line([(x, 0), (x, height)], fill=(r, g, b))
    
    return img

def create_button_image(text, width, height, bg_color, text_color, border_color=None):
    """Create a button image"""
    img = Image.new("RGB", (width, height), bg_color)
    draw = ImageDraw.Draw(img)
    
    # Border
    if border_color:
        draw.rectangle([(0, 0), (width-1, height-1)], outline=border_color, width=2)
    
    # Text (centered)
    try:
        font = ImageFont.truetype("arial.ttf", 24)
    except:
        font = ImageFont.load_default()
    
    # Get text size
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    
    # Center text
    x = (width - text_width) // 2
    y = (height - text_height) // 2
    
    draw.text((x, y), text, fill=text_color, font=font)
    
    return img

def create_icon_image(size, shape, color):
    """Create a simple icon"""
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    center = size // 2
    radius = size // 2 - 5
    
    if shape == "circle":
        draw.ellipse([(5, 5), (size-5, size-5)], fill=color)
    elif shape == "square":
        draw.rectangle([(5, 5), (size-5, size-5)], fill=color)
    elif shape == "diamond":
        points = [
            (center, 5),
            (size-5, center),
            (center, size-5),
            (5, center)
        ]
        draw.polygon(points, fill=color)
    
    return img

print("Generating UI images...")

# 1. Main Menu Background
print("Creating menu background...")
menu_bg = create_gradient_background(
    1920, 1080,
    COLORS["bg_dark"],
    COLORS["bg_medium"],
    "vertical"
)
menu_bg.save(os.path.join(output_dir, "menu_background.png"))
print("[OK] menu_background.png")

# 2. UI Panel Background
print("Creating UI panel background...")
panel_bg = Image.new("RGB", (400, 300), COLORS["bg_medium"])
draw = ImageDraw.Draw(panel_bg)
draw.rectangle([(0, 0), (399, 299)], outline=COLORS["border"], width=2)
panel_bg.save(os.path.join(output_dir, "ui_panel_bg.png"))
print("[OK] ui_panel_bg.png")

# 3. Button Images
print("Creating button images...")
buttons_dir = "assets/ui/buttons/menu"
os.makedirs(buttons_dir, exist_ok=True)

buttons = [
    ("play_button", "PLAY", COLORS["accent_blue"]),
    ("dungeons_button", "DUNGEONS", COLORS["accent_blue"]),
    ("travel_button", "TRAVEL", COLORS["accent_purple"]),
    ("clan_button", "CLAN", COLORS["accent_orange"]),
    ("work_button", "WORK", COLORS["accent_green"]),
    ("settings_button", "SETTINGS", COLORS["text_gray"]),
    ("close_button", "CLOSE", COLORS["bg_light"]),
]

for name, text, color in buttons:
    btn = create_button_image(text, 200, 50, color, COLORS["text_white"], COLORS["border"])
    btn.save(os.path.join(buttons_dir, f"{name}.png"))
    print(f"[OK] {name}.png")

# 4. Icons
print("Creating icons...")
icons_dir = "assets/ui/icons/ui"
os.makedirs(icons_dir, exist_ok=True)

icons = [
    ("close_icon", "circle", COLORS["accent_orange"]),
    ("check_icon", "circle", COLORS["accent_green"]),
    ("arrow_right", "diamond", COLORS["accent_blue"]),
    ("arrow_left", "diamond", COLORS["accent_blue"]),
]

for name, shape, color in icons:
    icon = create_icon_image(64, shape, color)
    icon.save(os.path.join(icons_dir, f"{name}.png"))
    print(f"[OK] {name}.png")

# 5. Game Icons
print("Creating game icons...")
game_icons_dir = "assets/ui/icons/game"
os.makedirs(game_icons_dir, exist_ok=True)

game_icons = [
    ("gold_icon", "circle", COLORS["accent_gold"]),
    ("level_icon", "square", COLORS["accent_blue"]),
    ("tier_icon", "diamond", COLORS["accent_purple"]),
]

for name, shape, color in game_icons:
    icon = create_icon_image(32, shape, color)
    icon.save(os.path.join(game_icons_dir, f"{name}.png"))
    print(f"[OK] {name}.png")

# 6. HUD Background
print("Creating HUD background...")
hud_bg = Image.new("RGBA", (300, 200), (*COLORS["bg_medium"], 200))
hud_bg.save(os.path.join(output_dir, "hud_background.png"))
print("[OK] hud_background.png")

# 7. Shop Background
print("Creating shop background...")
shop_bg = create_gradient_background(
    500, 600,
    COLORS["bg_medium"],
    COLORS["bg_light"],
    "vertical"
)
draw = ImageDraw.Draw(shop_bg)
draw.rectangle([(0, 0), (499, 599)], outline=COLORS["accent_orange"], width=3)
shop_bg.save(os.path.join(output_dir, "shop_background.png"))
print("[OK] shop_background.png")

# 8. Dialogue Background
print("Creating dialogue background...")
dialogue_bg = Image.new("RGB", (600, 200), COLORS["bg_dark"])
draw = ImageDraw.Draw(dialogue_bg)
draw.rectangle([(0, 0), (599, 199)], outline=COLORS["accent_blue"], width=2)
dialogue_bg.save(os.path.join(output_dir, "dialogue_background.png"))
print("[OK] dialogue_background.png")

print("\n[SUCCESS] All UI images generated!")
print(f"Images saved to: {output_dir}")
print("\nNext steps:")
print("1. Images are ready to use in Roblox")
print("2. They auto-sync via Rojo to ReplicatedStorage.Assets.UI.Images")
print("3. Reference them in your UI code")

