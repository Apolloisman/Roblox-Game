-- Clan Data Module
-- Manages clan groups with manufacturing and cross-server competition

local GameConfig = require(script.Parent.GameConfig)

local ClanData = {}
ClanData.__index = ClanData

function ClanData.new(clanId, leaderId, clanName)
	local self = setmetatable({}, ClanData)
	
	self.ClanId = clanId
	self.LeaderId = leaderId
	self.Name = clanName
	self.Members = {leaderId}
	self.Officers = {}
	self.CreatedAt = os.time()
	
	-- Resources
	self.Gold = 0
	self.Materials = {} -- Manufacturing materials
	
	-- Manufacturing
	self.ManufacturingQueue = {}
	self.ActiveManufacturing = {}
	self.ManufacturingUnlocked = false
	
	-- Competition
	self.ServerId = game.JobId -- Current server
	self.CompetitionScore = 0
	self.Wins = 0
	self.Losses = 0
	
	-- Palace Access
	self.HasPalaceAccess = false
	
	return self
end

function ClanData:AddMember(playerId, role)
	if #self.Members >= GameConfig.Clan.MaxMembers then
		return false
	end
	
	for _, memberId in ipairs(self.Members) do
		if memberId == playerId then
			return false -- Already a member
		end
	end
	
	table.insert(self.Members, playerId)
	if role == "Officer" then
		table.insert(self.Officers, playerId)
	end
	return true
end

function ClanData:RemoveMember(playerId)
	for i, memberId in ipairs(self.Members) do
		if memberId == playerId then
			table.remove(self.Members, i)
			break
		end
	end
	
	for i, officerId in ipairs(self.Officers) do
		if officerId == playerId then
			table.remove(self.Officers, i)
			break
		end
	end
end

function ClanData:IsMember(playerId)
	for _, memberId in ipairs(self.Members) do
		if memberId == playerId then
			return true
		end
	end
	return false
end

function ClanData:IsOfficer(playerId)
	for _, officerId in ipairs(self.Officers) do
		if officerId == playerId then
			return true
		end
	end
	return false
end

function ClanData:UnlockManufacturing()
	if not self.ManufacturingUnlocked then
		self.ManufacturingUnlocked = true
		return true
	end
	return false
end

function ClanData:AddManufacturingJob(itemType, playerId)
	if not self.ManufacturingUnlocked then
		return false, "Manufacturing not unlocked"
	end
	
	local config = GameConfig.Manufacturing[itemType]
	if not config then
		return false, "Invalid item type"
	end
	
	if self.Gold < config.BaseCost then
		return false, "Not enough clan gold"
	end
	
	local jobId = #self.ManufacturingQueue + 1
	local job = {
		JobId = jobId,
		ItemType = itemType,
		RequestedBy = playerId,
		Cost = config.BaseCost,
		TimeRequired = config.Time,
		StartTime = nil,
		Status = "Queued",
	}
	
	table.insert(self.ManufacturingQueue, job)
	self.Gold = self.Gold - config.BaseCost
	
	return true, jobId
end

function ClanData:ProcessManufacturing()
	local currentTime = os.time()
	
	-- Process active manufacturing
	for i = #self.ActiveManufacturing, 1, -1 do
		local job = self.ActiveManufacturing[i]
		if currentTime >= job.StartTime + job.TimeRequired then
			-- Job complete
			job.Status = "Complete"
			table.remove(self.ActiveManufacturing, i)
			-- Item ready for pickup
		end
	end
	
	-- Start new jobs from queue
	while #self.ManufacturingQueue > 0 and #self.ActiveManufacturing < 5 do -- Max 5 concurrent
		local job = table.remove(self.ManufacturingQueue, 1)
		job.StartTime = currentTime
		job.Status = "Manufacturing"
		table.insert(self.ActiveManufacturing, job)
	end
end

function ClanData:AddCompetitionScore(amount)
	self.CompetitionScore = self.CompetitionScore + amount
end

function ClanData:SetPalaceAccess(hasAccess)
	self.HasPalaceAccess = hasAccess
end

function ClanData:ToTable()
	return {
		ClanId = self.ClanId,
		LeaderId = self.LeaderId,
		Name = self.Name,
		Members = self.Members,
		Officers = self.Officers,
		Gold = self.Gold,
		ManufacturingUnlocked = self.ManufacturingUnlocked,
		CompetitionScore = self.CompetitionScore,
		Wins = self.Wins,
		Losses = self.Losses,
		HasPalaceAccess = self.HasPalaceAccess,
	}
end

return ClanData

