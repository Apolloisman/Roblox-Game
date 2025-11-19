-- NPC Configuration
-- Defines all NPCs, their stories, and dialogue

return {
	-- Starting Area NPCs (School/Town Hall)
	StartingArea = {
		{
			Id = "headmaster",
			Name = "Headmaster Thorne",
			Type = "Story",
			Position = Vector3.new(0, 5, -10),
			Dialogue = {
				Welcome = {
					{RequiredProgress = 0, Text = "Welcome, new citizen. You stand equal with all others here. Your journey begins today."},
					{RequiredProgress = 5, Text = "I see you've been volunteering for dungeons. Good initiative. Keep working hard."},
					{RequiredProgress = 10, Text = "You've reached Apprentice tier! You're making real progress. The city needs people like you."},
					{RequiredProgress = 20, Text = "An Artisan! You've unlocked manufacturing. Your clan will be grateful for your contributions."},
					{RequiredProgress = 30, Text = "A Merchant! You've come far. The city's economy benefits from your success."},
					{RequiredProgress = 40, Text = "A Noble! You've achieved the highest status. The palace awaits those who lead champion clans."},
				},
				Story = {
					{RequiredProgress = 0, Text = "Long ago, this city was ruled by a tyrant. We overthrew them, but power corrupts. That's why we start everyone equal."},
					{RequiredProgress = 10, Text = "The dungeons weren't always here. They appeared after the revolution. Some say they're a test. Others say they're a curse."},
					{RequiredProgress = 20, Text = "The clans that control the city now... they weren't always in power. They earned it through hard work, just like you're doing."},
					{RequiredProgress = 30, Text = "The palace at the center... it's been empty since the revolution. Only the champion clan across all servers can enter. Will it be yours?"},
				},
			},
		},
		{
			Id = "elder_citizen",
			Name = "Elder Maria",
			Type = "Social",
			Position = Vector3.new(-5, 5, -8),
			Dialogue = {
				Welcome = {
					{RequiredProgress = 0, Text = "Hello, young one. I've seen many start their journey here. What will yours be?"},
					{RequiredProgress = 5, Text = "You remind me of my grandson. He started just like you. Now he's a Merchant."},
					{RequiredProgress = 15, Text = "I remember when I was your age. The city was different then. Harder, but also simpler."},
					{RequiredProgress = 25, Text = "You've grown so much! The city needs leaders like you. Don't forget where you came from."},
				},
				Advice = {
					{RequiredProgress = 0, Text = "Start with Tier 1 dungeons. They're safer, and the gold adds up."},
					{RequiredProgress = 5, Text = "Form a family early. Working together makes everything easier."},
					{RequiredProgress = 10, Text = "Save your gold for housing. Better housing means more income every day."},
					{RequiredProgress = 20, Text = "Join a clan when you can. Manufacturing changes everything."},
				},
			},
		},
	},
	
	-- Shop NPCs
	Shops = {
		{
			Id = "weapon_smith",
			Name = "Gareth the Blacksmith",
			Type = "Shopkeeper",
			ShopType = "Weapons",
			Position = Vector3.new(15, 5, 0),
			Dialogue = {
				Greeting = {
					{RequiredProgress = 0, Text = "Welcome to my forge! I craft the finest weapons in the city. What can I do for you?"},
					{RequiredProgress = 10, Text = "Ah, an Apprentice! You're ready for better weapons. Let me show you what I have."},
					{RequiredProgress = 20, Text = "An Artisan! You understand quality. My best weapons are now available to you."},
					{RequiredProgress = 30, Text = "A Merchant! You appreciate fine craftsmanship. I have legendary weapons for you."},
					{RequiredProgress = 40, Text = "A Noble! The finest weapons in my collection are yours. You've earned them."},
				},
				Story = {
					{RequiredProgress = 0, Text = "I've been smithing for 30 years. Started as an Apprentice, just like you might become."},
					{RequiredProgress = 10, Text = "My father taught me this trade. He said 'Good weapons save lives in the dungeons.'"},
					{RequiredProgress = 20, Text = "I've seen many come and go. The ones who survive are the ones who invest in quality gear."},
					{RequiredProgress = 30, Text = "The weapon I'm working on now... it's for a champion clan. Maybe yours will be next?"},
				},
			},
			Inventory = {
				{ItemId = "iron_sword", Name = "Iron Sword", Cost = 100, RequiredTier = "Citizen"},
				{ItemId = "steel_sword", Name = "Steel Sword", Cost = 300, RequiredTier = "Apprentice"},
				{ItemId = "mithril_sword", Name = "Mithril Sword", Cost = 800, RequiredTier = "Artisan"},
				{ItemId = "dragon_sword", Name = "Dragon Sword", Cost = 2000, RequiredTier = "Merchant"},
				{ItemId = "legendary_blade", Name = "Legendary Blade", Cost = 5000, RequiredTier = "Noble"},
			},
		},
		{
			Id = "armor_merchant",
			Name = "Lydia the Armorer",
			Type = "Shopkeeper",
			ShopType = "Armor",
			Position = Vector3.new(15, 5, 5),
			Dialogue = {
				Greeting = {
					{RequiredProgress = 0, Text = "Protection is everything in the dungeons. Welcome to my shop!"},
					{RequiredProgress = 10, Text = "An Apprentice! You're learning that good armor is worth its weight in gold."},
					{RequiredProgress = 20, Text = "An Artisan! You understand that quality armor can mean the difference between life and death."},
					{RequiredProgress = 30, Text = "A Merchant! My finest armor is available to you. You've earned it."},
					{RequiredProgress = 40, Text = "A Noble! The legendary armor sets are yours. You've proven yourself worthy."},
				},
				Story = {
					{RequiredProgress = 0, Text = "I lost my brother in the dungeons. He didn't have proper armor. That's why I do this."},
					{RequiredProgress = 10, Text = "Every piece I sell, I think of him. I make sure it's the best protection I can offer."},
					{RequiredProgress = 20, Text = "You've survived this long. That means you're smart. Keep investing in good gear."},
					{RequiredProgress = 30, Text = "The champion clans... they all started here, buying my basic armor. Look where they are now."},
				},
			},
			Inventory = {
				{ItemId = "leather_armor", Name = "Leather Armor", Cost = 80, RequiredTier = "Citizen"},
				{ItemId = "chain_armor", Name = "Chain Armor", Cost = 250, RequiredTier = "Apprentice"},
				{ItemId = "plate_armor", Name = "Plate Armor", Cost = 700, RequiredTier = "Artisan"},
				{ItemId = "dragon_armor", Name = "Dragon Armor", Cost = 1800, RequiredTier = "Merchant"},
				{ItemId = "legendary_armor", Name = "Legendary Armor", Cost = 4500, RequiredTier = "Noble"},
			},
		},
		{
			Id = "general_store",
			Name = "Marcus the Merchant",
			Type = "Shopkeeper",
			ShopType = "General",
			Position = Vector3.new(15, 5, -5),
			Dialogue = {
				Greeting = {
					{RequiredProgress = 0, Text = "Welcome! I have everything you need for your dungeon adventures. Potions, supplies, you name it!"},
					{RequiredProgress = 10, Text = "An Apprentice! You're becoming a regular. I have better supplies for you now."},
					{RequiredProgress = 20, Text = "An Artisan! My premium supplies are available. You've earned them."},
					{RequiredProgress = 30, Text = "A Merchant! The best supplies in the city are yours. You've proven yourself."},
					{RequiredProgress = 40, Text = "A Noble! My legendary supplies are available. Only the best for champions."},
				},
				Story = {
					{RequiredProgress = 0, Text = "I've been running this shop for 20 years. Seen thousands of adventurers come through."},
					{RequiredProgress = 10, Text = "The ones who succeed? They always stock up before dungeons. Preparation is key."},
					{RequiredProgress = 20, Text = "I remember when the first clan formed. They bought all my supplies. Now they're champions."},
					{RequiredProgress = 30, Text = "You remind me of the current champion clan leader. They started just like you. Maybe you'll be next?"},
				},
			},
			Inventory = {
				{ItemId = "health_potion", Name = "Health Potion", Cost = 20, RequiredTier = "Citizen"},
				{ItemId = "mana_potion", Name = "Mana Potion", Cost = 25, RequiredTier = "Citizen"},
				{ItemId = "greater_health", Name = "Greater Health Potion", Cost = 50, RequiredTier = "Apprentice"},
				{ItemId = "elixir", Name = "Elixir of Power", Cost = 100, RequiredTier = "Artisan"},
				{ItemId = "legendary_potion", Name = "Legendary Potion", Cost = 500, RequiredTier = "Noble"},
			},
		},
		{
			Id = "housing_agent",
			Name = "Sophia the Realtor",
			Type = "Shopkeeper",
			ShopType = "Housing",
			Position = Vector3.new(10, 5, 0),
			Dialogue = {
				Greeting = {
					{RequiredProgress = 0, Text = "Welcome! I help citizens find their perfect home. Better housing means better opportunities!"},
					{RequiredProgress = 5, Text = "You're ready for Standard housing! It's a big step up from Basic."},
					{RequiredProgress = 10, Text = "An Artisan! Comfortable housing is available. You'll love the daily income!"},
					{RequiredProgress = 20, Text = "A Merchant! Luxury housing awaits. You've earned the best the city has to offer."},
					{RequiredProgress = 30, Text = "A Noble! Estate housing is yours. Only the most successful can afford these."},
				},
				Story = {
					{RequiredProgress = 0, Text = "I've helped thousands find homes. Everyone starts in Basic housing, but few reach Estates."},
					{RequiredProgress = 10, Text = "The housing system was created after the revolution. It ensures everyone has a fair start."},
					{RequiredProgress = 20, Text = "I've seen many rise through the tiers. The ones who invest in housing always do better."},
					{RequiredProgress = 30, Text = "The Estates... they're reserved for Nobles. Only the most successful reach that level. Will you?"},
				},
			},
		},
	},
	
	-- Social NPCs (Clan Area)
	ClanArea = {
		{
			Id = "clan_recruiter",
			Name = "Commander Valen",
			Type = "Social",
			Position = Vector3.new(20, 5, 10),
			Dialogue = {
				Welcome = {
					{RequiredProgress = 0, Text = "Interested in clans? They're the key to real power in this city."},
					{RequiredProgress = 10, Text = "You've reached Apprentice! You can form families now. That's the first step."},
					{RequiredProgress = 20, Text = "An Artisan! You can unlock manufacturing. Clans need people like you."},
					{RequiredProgress = 30, Text = "A Merchant! You're ready to lead a clan. The city needs strong leaders."},
					{RequiredProgress = 40, Text = "A Noble! You're among the elite. Champion clans are led by Nobles like you."},
				},
				Story = {
					{RequiredProgress = 0, Text = "I've been recruiting for clans for 15 years. I've seen many rise to power."},
					{RequiredProgress = 10, Text = "The first clan I helped form... they're still champions today. Hard work pays off."},
					{RequiredProgress = 20, Text = "Manufacturing changed everything. Clans that unlock it always do better."},
					{RequiredProgress = 30, Text = "The cross-server competition... it's intense. Only the strongest clans survive."},
				},
			},
		},
	},
}

