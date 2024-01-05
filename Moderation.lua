-- Server Script

-- ROBLOX services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- Moderation Service
local ModerationService = require(script.Parent.Services.ModerationService)

local function handleRemote(player:Player, arg:string)
	if arg == 'banned?' then
		return ModerationService.isBanned(player)
	elseif arg == 'admin?' then
		local ismod = ModerationService.isModerator(player)
		return ismod
	end
end

ReplicatedStorage.Remotes.ModerationFunction.OnServerInvoke = handleRemote

local function handleAdminCommands(player:Player, commandString:string)
	local command, targetPlayerName, reason = commandString:match(":(%w+)%s*(%w*)%s*(.*)")

	if not command then
		warn("[Moderation Service]: Invalid command format; "..commandString)
		return
	end

	local targetPlayer = game.Players[targetPlayerName]

	if command == "ban" then
		ModerationService.banPlayer(targetPlayer, player, reason, ModerationService.getModeratorRank(player))
		warn('[Moderation Service]: Banned player '..targetPlayerName..' for '..reason..'. Banned by '..player.Name)
		ModerationService.kickPlayer(targetPlayer, 'You have been banned by '..player.Name..' for: '..reason)
	elseif command == "kick" then
		ModerationService.kickPlayer(targetPlayer, reason or 'No reason provided.')
		warn('[Moderation Service]: Kicked player '..targetPlayerName..' for '..reason..'. Kicked by '..player.Name)
	elseif command == "admin" then
		ModerationService.rankModerator(targetPlayer, 1, reason, player)
		warn('[Moderation Service]: Initiated request to rank moderator.')
	elseif command == 'unban' then
		if ModerationService.getModeratorRank(player) >= 2 then
			ModerationService.unbanPlayer(game:GetService("Players"):GetUserIdFromNameAsync(targetPlayerName))
			warn('[Moderation Service]: Unbanned player...')
		end
	elseif command == 'close' then
		local GUI = player.PlayerGui:FindFirstChild("Admin")
		if GUI then
			GUI:Destroy()
		end
	else
		-- Unknown command
		print("Unknown command: " .. command)
	end
end


ReplicatedStorage.Remotes.ModerationAction.OnServerEvent:Connect(function(player:Player, action:string)
	if action == 'open me admin pls' then
		if ModerationService.isModerator(player) then
			ServerStorage.AdminPanel:Clone().Parent = player.PlayerGui
		else
			warn('[Moderation Service]: User is not a moderator.')
		end
	else
		if ModerationService.isModerator(player) then
			handleAdminCommands(player, action)
			local GUI = player.PlayerGui:FindFirstChild("Admin")
			if GUI then
				GUI:Destroy()
			end
		else
			warn('[Moderation Service]: User is not a moderator.')
		end
	end
end)