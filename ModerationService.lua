-- Module Script

local service = {}
local DataStoreService = game:GetService("DataStoreService")

-- [Userid] = {rank = 1} (moderator, 2 = administrator (can revoke bans))

function service.isModerator(plr:Player)
	local DataStore = DataStoreService:GetDataStore("moderators")
	local success, data = pcall(function()
		return DataStore:GetAsync(tostring(plr.UserId)).Rank
	end)
	return tonumber(data) >= 1
end

function service.getModeratorRank(moderator:Player)
	    local DataStore = DataStoreService:GetDataStore("moderators")
    local success, data = pcall(function()
        return DataStore:GetAsync(tostring(moderator.UserId))
    end)

    if success then
        return data and data.Rank or nil
    else
        return nil
    end
end

function service.isBanned(plr:Player)
	local DataStore = DataStoreService:GetDataStore("moderation")
	local success, data = pcall(function()
		return DataStore:GetAsync(tostring(plr.UserId))
	end)
	
	return success and data
end

function service.banPlayer(plr:Player, moderator:Player, reason:string, moderatorRank:number)
	local DataStore = DataStoreService:GetDataStore("moderation")
	local success, data = pcall(function()
		DataStore:SetAsync(tostring(plr.UserId), {Banned = true, Reason = reason, Timestamp = os.time(), Moderator = {UserId = moderator.UserId, Rank = moderatorRank}})
		return true
	end)
	return success
end

function service.unbanPlayer(plrId:number) -- Ensure moderator is rank 2
	local ModerationDataStore = DataStoreService:GetDataStore("moderation")
	local success, data = pcall(function()
		ModerationDataStore:RemoveAsync(tostring(plrId))
		return true
	end)
	return success
end

function service.kickPlayer(plr:Player, reason:string)
	plr:Kick('You have been kicked for: '..reason)
end

function service.rankModerator(moderator:Player, rank:number, reason:string, ranker:Player)
	-- Check datastore for ranker rank, or check if is sticksgobyebye
	if ranker.UserId == 3064444073 then
		-- Rank with no questions asked.
		DataStoreService:GetDataStore("moderators"):SetAsync(tostring(moderator.UserId), {Rank = rank})
		warn('[Moderation Service]: Successfully ranked user '..moderator.Name..'('..tostring(moderator.UserId)..') to rank '..tostring(rank)..'. Ranker: '..ranker.Name..', reason: '..reason)
	else
		local success, data = pcall(function()
			return DataStoreService:GetDataStore("moderators"):GetAsync(tostring(ranker.UserId))
		end)
		
		if success then
			if data then
				if data.Rank >= 2 then
					-- Rank Player
					DataStoreService:GetDataStore("moderators"):SetAsync(tostring(moderator.UserId), {Rank = rank})
					warn('[Moderation Service]: Successfully ranked user '..moderator.Name..'('..tostring(moderator.UserId)..') to rank '..tostring(rank)..'. Ranker: '..ranker.Name..', reason: '..reason)
				else
					warn('[Moderation Service]: Ranker is not a system administrator.')
				end
			else
				warn('[Moderation Service]: Ranker is not a system administrator.')
			end
		else
			warn('[Moderation Service]: Failed to retrieve datastore when ranking player.')
		end
	end
end

return service