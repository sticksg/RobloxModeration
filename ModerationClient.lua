-- CLIENT script
local Player = game.Players.LocalPlayer
local ReplicatedService = game:GetService("ReplicatedStorage")

Player.CharacterAdded:Connect(function()
	-- Is banned?
	local isBanned = ReplicatedService.Remotes.ModerationFunction:InvokeServer('banned?')
	if isBanned then
		Player:Kick("You are banned from this experience.")
	else
		print('[Moderation Service]: User is not banned.')
	end

	-- Is admin?
	local isAdmin = ReplicatedService.Remotes.ModerationFunction:InvokeServer('admin?')
	if isAdmin then
		print('[Moderation Service]: User is an admin, initiated Moderation script.')
	else
		print('[Moderation Service]: User is not an admin.')
		script:Destroy()
	end
end)

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Quote then
		if not UserInputService:GetFocusedTextBox() then
			if not Player.PlayerGui:FindFirstChild("AdminPanel") then
				ReplicatedService.Remotes:FindFirstChild("ModerationAction"):FireServer('open me admin pls')
			end
		end
	elseif input.KeyCode == Enum.KeyCode.Return then
		if Player.PlayerGui:FindFirstChild("AdminPanel") then
			ReplicatedService.Remotes:FindFirstChild("ModerationAction"):FireServer(Player.PlayerGui:FindFirstChild("AdminPanel").Frame.TextBox.Text)
		end
	end
end)