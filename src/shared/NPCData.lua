-- NPC Data Module
-- Manages NPCs, their stories, and dialogue progression

local NPCData = {}
NPCData.__index = NPCData

function NPCData.new(npcId, npcName, npcType)
	local self = setmetatable({}, NPCData)
	
	self.NPCId = npcId
	self.Name = npcName
	self.Type = npcType -- "Shopkeeper", "Social", "Story", "Quest"
	self.StoryProgress = {} -- PlayerId -> StoryState
	self.DialogueTree = {}
	self.Relationship = {} -- PlayerId -> RelationshipLevel
	
	return self
end

function NPCData:GetDialogue(playerId, dialogueKey)
	local playerProgress = self.StoryProgress[playerId] or 0
	local dialogue = self.DialogueTree[dialogueKey]
	
	if not dialogue then return nil end
	
	-- Get dialogue based on player progress
	for i = #dialogue, 1, -1 do
		local entry = dialogue[i]
		if playerProgress >= entry.RequiredProgress then
			return entry.Text
		end
	end
	
	return dialogue[1].Text -- Default to first dialogue
end

function NPCData:AdvanceStory(playerId, amount)
	local currentProgress = self.StoryProgress[playerId] or 0
	self.StoryProgress[playerId] = currentProgress + amount
end

function NPCData:SetStoryProgress(playerId, progress)
	self.StoryProgress[playerId] = progress
end

function NPCData:GetRelationship(playerId)
	return self.Relationship[playerId] or 0
end

function NPCData:ImproveRelationship(playerId, amount)
	local current = self.Relationship[playerId] or 0
	self.Relationship[playerId] = math.min(100, current + amount)
end

function NPCData:ToTable()
	return {
		NPCId = self.NPCId,
		Name = self.Name,
		Type = self.Type,
		StoryProgress = self.StoryProgress,
		Relationship = self.Relationship,
	}
end

return NPCData

