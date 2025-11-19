# Model Clipping Analysis Report

## Summary

Checked all models for clipping/overlapping geometry. Found **106 overlaps**, but most are **intentional architectural design**.

## ✅ Intentional Overlaps (Normal - No Action Needed)

These overlaps are **expected** and part of the design:

### Buildings
- **Roofs on buildings** - Roofs sit on top of bases (SCHOOL, TOWNHALL)
- **Columns in buildings** - Columns intersect with base and roof (TOWNHALL)
- **Signs on roofs** - Shop signs attach to roofs

### Work Stations
- **Table legs** - Legs intersect with table tops (all 36 work stations)
  - This is normal - legs connect to tables
  - Small overlap (0.2-0.3 units) is intentional

### Teleporters
- **Platform + Pillars** - Pillars connect to platforms
- **Pillars + Arch** - Arch connects to pillars
- **All parts connect** - This is how teleporters are built

## ⚠️ Real Clipping Issues (Need Attention)

### SHOP Model - All 4 Shops Overlapping

**Problem:** The `shops.fbx` file contains 4 separate shops that are **overlapping each other**:
- SHOP_Weapon
- SHOP_Armor  
- SHOP_General
- SHOP_Housing

**Overlap Details:**
- Bases overlap by 13-16 units in X/Y
- Roofs overlap by 14-17 units
- Doors overlap by 0.5-3 units

**Impact:**
- If imported as one model, shops will be on top of each other
- Players will see all 4 shops in the same location
- This is likely not intended

## 🔧 Solutions

### Option 1: Export Shops Separately (Recommended)
Export each shop as its own FBX file:
- `shop_weapon.fbx` - Only SHOP_Weapon_* objects
- `shop_armor.fbx` - Only SHOP_Armor_* objects
- `shop_general.fbx` - Only SHOP_General_* objects
- `shop_housing.fbx` - Only SHOP_Housing_* objects

**Pros:**
- Can place shops in different locations in-game
- More flexible
- No overlapping issues

**Cons:**
- 4 separate files instead of 1

### Option 2: Space Shops Apart in Blender
Move shops apart before exporting:
- Weapon shop: Keep at current position
- Armor shop: Move +20 units in X
- General shop: Move +40 units in X
- Housing shop: Move +60 units in X

**Pros:**
- Single file
- Shops already positioned

**Cons:**
- Fixed positions (can't move in-game easily)

### Option 3: Keep As-Is
If shops are meant to be placed separately in Roblox Studio:
- Import the shops.fbx model
- Manually separate the 4 shops in Studio
- Position them where needed

**Pros:**
- No changes needed

**Cons:**
- Manual work in Studio
- Shops start overlapping

## 📊 Clipping Statistics

| Model | Total Overlaps | Intentional | Real Issues |
|-------|---------------|-------------|-------------|
| SCHOOL | 1 | 1 (roof) | 0 |
| TOWNHALL | 7 | 7 (roof + columns) | 0 |
| SHOP | 36 | 8 (signs) | **28 (shops overlapping)** |
| TELEPORTER | 32 | 32 (parts connecting) | 0 |
| WORK | 36 | 36 (legs on tables) | 0 |
| NPC | 0 | 0 | 0 |
| **TOTAL** | **112** | **84** | **28** |

## ✅ Models That Are Clean

- **NPC Stands** - No clipping issues
- **Environment** - No clipping issues
- **Work Stations** - Only intentional leg overlaps
- **Teleporters** - Only intentional connection overlaps

## 🎯 Recommendation

**Fix the SHOP model** by exporting shops separately. All other "clipping" is intentional design and should be kept as-is.

## Next Steps

1. ✅ Re-exported all models (done)
2. ⚠️ Fix shop overlapping (choose option above)
3. ✅ All other models are fine

