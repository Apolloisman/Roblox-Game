-- Family Data Module
-- Manages family groups (small groups before clans)

local FamilyData = {}
FamilyData.__index = FamilyData

function FamilyData.new(familyId, leaderId)
	local self = setmetatable({}, FamilyData)
	
	self.FamilyId = familyId
	self.LeaderId = leaderId
	self.Members = {leaderId}
	self.Name = "Family " .. familyId
	self.CreatedAt = os.time()
	self.SharedGold = 0
	self.SharedStorage = {}
	
	return self
end

function FamilyData:AddMember(playerId)
	if #self.Members >= 4 then -- Max 4 members
		return false
	end
	
	for _, memberId in ipairs(self.Members) do
		if memberId == playerId then
			return false -- Already a member
		end
	end
	
	table.insert(self.Members, playerId)
	return true
end

function FamilyData:RemoveMember(playerId)
	for i, memberId in ipairs(self.Members) do
		if memberId == playerId then
			table.remove(self.Members, i)
			return true
		end
	end
	return false
end

function FamilyData:IsMember(playerId)
	for _, memberId in ipairs(self.Members) do
		if memberId == playerId then
			return true
		end
	end
	return false
end

function FamilyData:AddSharedGold(amount)
	self.SharedGold = self.SharedGold + amount
end

function FamilyData:SpendSharedGold(amount)
	if self.SharedGold >= amount then
		self.SharedGold = self.SharedGold - amount
		return true
	end
	return false
end

function FamilyData:ToTable()
	return {
		FamilyId = self.FamilyId,
		LeaderId = self.LeaderId,
		Members = self.Members,
		Name = self.Name,
		CreatedAt = self.CreatedAt,
		SharedGold = self.SharedGold,
	}
end

return FamilyData

