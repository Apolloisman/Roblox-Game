# Game Design Document

## Overview

An economy-based dungeon crawler with social mobility, clan systems, and cross-server competition. Players start equal in a shared starting area and progress through dungeons to improve their status, form clans, and compete for ultimate power.

## Core Concept

**"Work Dungeons, Build Power, Rule the City"**

Players start as equal citizens in a school/town hall. They volunteer for dangerous dungeon work to earn gold, improve their tier, and unlock better opportunities. Through progression, they can form families, join clans, unlock manufacturing, and compete across servers for the ultimate prize: Palace access.

## Key Systems

### 1. Starting Area (School/Town Hall)
- **All players spawn here** - Equal starting point
- Central hub for all activities
- Access point for dungeons
- Social gathering area

### 2. Progression Tiers (Social Mobility)

Players progress through 5 tiers:

1. **Citizen** (Level 1)
   - Basic housing
   - Access to Tier 1 dungeons
   - Starting tier

2. **Apprentice** (Level 5)
   - Standard housing
   - Access to Tier 1-2 dungeons
   - Can form families

3. **Artisan** (Level 10)
   - Comfortable housing
   - Access to Tier 1-3 dungeons
   - Unlocks clan manufacturing

4. **Merchant** (Level 15)
   - Luxury housing
   - Access to Tier 1-4 dungeons
   - Advanced manufacturing

5. **Noble** (Level 20)
   - Estate housing
   - Access to all dungeons
   - Maximum status

### 3. Housing System

Housing provides:
- **Status indicator** - Shows your social standing
- **Daily gold income** - Passive income based on housing tier
- **Comfort buffs** - Bonuses to dungeon rewards

Tiers:
- Basic (Free) - No income, no buffs
- Standard (100 gold) - 10 gold/day, 5% bonus
- Comfortable (500 gold) - 50 gold/day, 10% bonus
- Luxury (2,000 gold) - 200 gold/day, 15% bonus
- Estate (10,000 gold) - 1,000 gold/day, 25% bonus

### 4. Dungeon System

**Volunteering System:**
- Players volunteer for dungeons (like work)
- Must meet tier requirement to access
- Risk vs reward - harder dungeons = more gold

**Dungeon Tiers:**
- Tier 1: 50 gold, 10 XP (Citizen)
- Tier 2: 150 gold, 30 XP (Apprentice)
- Tier 3: 400 gold, 80 XP (Artisan)
- Tier 4: 1,000 gold, 200 XP (Merchant)
- Tier 5: 2,500 gold, 500 XP (Noble)

**Progression:**
- Complete dungeons → Earn gold & XP
- Level up → Unlock new tier
- New tier → Access better dungeons
- Better dungeons → More gold → Better housing

### 5. Family System

**Small Groups (2-4 players):**
- Form families with friends
- Shared gold pool
- Shared storage
- Step before clans

**Benefits:**
- Work together in dungeons
- Share resources
- Build relationships

### 6. Clan System

**Large Groups (5-50 players):**
- Form clans to compete
- Manufacturing system
- Cross-server competition
- Political power

**Clan Features:**
- **Leadership** - Leader, Officers, Members
- **Manufacturing** - Craft gear for members
- **Competition** - Compete across servers
- **Palace Access** - Champion clan gets exclusive access

### 7. Manufacturing System

**Unlocked at Artisan tier:**
- Clans can manufacture items
- Members request items
- Uses clan gold
- Takes time to complete

**Item Types:**
- Weapons (500 gold, 1 hour)
- Armor (300 gold, 40 min)
- Consumables (100 gold, 10 min)
- Special Items (2,000 gold, 2 hours)

**Workflow:**
1. Player requests item
2. Clan pays gold
3. Item enters manufacturing queue
4. Item completes after time
5. Player picks up item

### 8. Cross-Server Competition

**How it Works:**
- Clans compete across all servers
- Competition score based on:
  - Dungeons completed
  - Gold earned
  - Clan wins
- Leaderboard updates hourly
- **Champion clan** gets Palace access

**Palace Access:**
- Exclusive area for champion clan
- Special rewards
- Prestige and recognition
- Resets each season (7 days)

## Game Loop

```
1. Start in School/Town Hall (equal with everyone)
   ↓
2. Volunteer for Dungeons (work to earn gold)
   ↓
3. Complete Dungeons → Earn Gold & XP
   ↓
4. Level Up → Unlock New Tier
   ↓
5. Better Tier → Better Housing → Better Dungeons
   ↓
6. Form Family (2-4 players)
   ↓
7. Join/Form Clan (5-50 players)
   ↓
8. Unlock Manufacturing (Artisan tier)
   ↓
9. Compete Across Servers
   ↓
10. Win Championship → Palace Access
```

## Social Systems

### Family
- Small groups (2-4)
- Shared resources
- Early game cooperation

### Clan
- Large groups (5-50)
- Manufacturing
- Competition
- Political power

### Competition
- Cross-server leaderboards
- Seasonal championships
- Palace access for winners

## Economy

### Gold Sources
- Dungeon completion rewards
- Daily housing income
- Clan contributions

### Gold Sinks
- Housing upgrades
- Clan formation (1,000 gold)
- Manufacturing costs
- Equipment purchases

### Progression
- Gold → Better Housing → More Income
- Gold → Clan Manufacturing → Better Gear
- Gold → Status → Access to Better Content

## Technical Implementation

### Data Persistence
- Player data saved to DataStore
- Clan data saved to DataStore
- Competition scores in OrderedDataStore
- Auto-save every 5 minutes

### Server Systems
- PlayerManager - Handles player data
- StartingArea - Manages spawn system
- DungeonManager - Dungeon volunteering
- ClanManager - Clan operations
- DataManager - Data persistence
- RemoteEvents - Client-server communication

### Client Systems
- GameUI - Main UI
- DungeonUI - Dungeon volunteering (to be built)
- ClanUI - Clan management (to be built)

## NPC System

### NPCs with Stories

**Starting Area NPCs:**
- **Headmaster Thorne** - Story NPC with city history
- **Elder Maria** - Social NPC with advice and wisdom

**Shop NPCs:**
- **Gareth the Blacksmith** - Weapons shop with progression-based inventory
- **Lydia the Armorer** - Armor shop with personal story
- **Marcus the Merchant** - General store with supplies
- **Sophia the Realtor** - Housing upgrades

**Social NPCs:**
- **Commander Valen** - Clan recruiter with competition stories

### Story Progression

- **Dialogue changes** based on player tier/level
- **Personal stories** that unfold as you progress
- **Relationship system** - NPCs remember you
- **Progressive inventory** - Shops unlock better items as you tier up

### Shop System

- **Tier-based access** - Better items unlock with higher tiers
- **NPC personalities** - Each shopkeeper has unique dialogue
- **Story integration** - Shopkeepers share stories as you progress
- **Visual emphasis** - NPCs are the focus of social areas

## Future Enhancements

- [ ] Full dungeon gameplay (combat, enemies, bosses)
- [ ] Housing visualization
- [ ] Clan wars/battles
- [ ] Palace content
- [ ] More manufacturing recipes
- [ ] Family activities
- [ ] City districts
- [ ] Political system (elections, laws)
- [ ] Events and seasons
- [ ] More NPCs with branching stories
- [ ] NPC quests and missions

## Design Philosophy

1. **Equal Start** - Everyone begins the same
2. **Social Mobility** - Progression through tiers
3. **Cooperation** - Families and clans
4. **Competition** - Cross-server championships
5. **Economy** - Gold drives progression
6. **Work = Progress** - Dungeons as work metaphor

This creates a unique blend of:
- Dungeon crawling (action)
- Social progression (RPG)
- Economic simulation (strategy)
- Competitive multiplayer (PvP)

