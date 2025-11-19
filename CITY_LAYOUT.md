# City Layout

## Overview

All buildings have been arranged in a proper city layout with streets and districts.

## City Structure

### City Center
- **School**: (0, 0) - Main building, city center
- **Town Hall**: (-25, 0) - Government building, left of school

### Main Street (Shopping District)
All shops are spaced **25 units apart** along the main street (Y = -20):
- **Weapon Shop**: (30, -20)
- **Armor Shop**: (55, -20) 
- **General Shop**: (80, -20)
- **Housing Shop**: (105, -20)

### Teleporter Row
8 teleporters arranged in a row (Y = -20):
- **Tier 1 Dungeon**: (130, -20)
- **Tier 2 Dungeon**: (145, -20)
- **Tier 3 Dungeon**: (160, -20)
- **Tier 4 Dungeon**: (175, -20)
- **Tier 5 Dungeon**: (190, -20)
- **Artisan District**: (205, -20)
- **Merchant District**: (220, -20)
- **Noble Estate**: (235, -20)

### Industrial District
Work areas organized by type:

**Farms** (Y = -50):
- Farm 1: (30, -50)
- Farm 2: (40, -50)
- Farm 3: (50, -50)

**Factories** (Y = -70):
- Factory 1: (30, -70)
- Factory 2: (40, -70)
- Factory 3: (50, -70)

**Houses** (Y = -90):
- House 1: (30, -90)
- House 2: (40, -90)
- House 3: (50, -90)

### NPC Locations
NPCs positioned near their buildings:
- **Headmaster Thorne**: (0, -10) - Near school
- **Elder Maria**: (-5, -10) - Near school
- **Gareth the Blacksmith**: (30, -15) - Near weapon shop
- **Lydia the Armorer**: (55, -15) - Near armor shop
- **Marcus the Merchant**: (80, -15) - Near general shop
- **Sophia the Realtor**: (105, -15) - Near housing shop
- **Commander Valen**: (-25, -10) - Near town hall

## Layout Map

```
                    [Town Hall]  [School]
                         (-25,0)   (0,0)
                              |      |
                              |      |
    [Weapon] [Armor] [General] [Housing]  [Teleporters...]
    (30,-20) (55,-20) (80,-20) (105,-20)  (130-235,-20)
    
    [Farms]                    [Teleporter Row]
    (30-50,-50)
    
    [Factories]
    (30-50,-70)
    
    [Houses]
    (30-50,-90)
```

## Coordinates Reference

| Building | X | Y | Z |
|----------|---|---|---|
| School | 0 | 0 | 0 |
| Town Hall | -25 | 0 | 0 |
| Weapon Shop | 30 | -20 | 0 |
| Armor Shop | 55 | -20 | 0 |
| General Shop | 80 | -20 | 0 |
| Housing Shop | 105 | -20 | 0 |
| Tier 1 Teleporter | 130 | -20 | 0 |
| Tier 2 Teleporter | 145 | -20 | 0 |
| Tier 3 Teleporter | 160 | -20 | 0 |
| Tier 4 Teleporter | 175 | -20 | 0 |
| Tier 5 Teleporter | 190 | -20 | 0 |
| Artisan Teleporter | 205 | -20 | 0 |
| Merchant Teleporter | 220 | -20 | 0 |
| Noble Teleporter | 235 | -20 | 0 |

## Notes

- All shops are now **properly spaced** - no more overlapping!
- Buildings are organized into logical districts
- NPCs are positioned near their related buildings
- Work areas are grouped by type in the industrial district
- Teleporters are in a convenient row for easy access

## Importing to Roblox

When you import these models:
1. They'll appear at their correct positions
2. Shops will be separate buildings (not overlapping)
3. Everything is ready for a city layout
4. Just anchor the models and you're done!

