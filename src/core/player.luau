return function(env)
	local WorldToScreen = function(Object)
		local ObjectVector = workspace.CurrentCamera:WorldToScreenPoint(Object.Position)
		return Vector2.new(ObjectVector.X, ObjectVector.Y)
	end

	local MousePositionToVector2 = function()
		return Vector2.new(ZYMouse.X, ZYMouse.Y)
	end

	local GetClosestPlayerFromCursor = function()
		local found = nil
		local ClosestDistance = math.huge
		for i, v in pairs(Players:GetPlayers()) do
			if v ~= Players.LocalPlayer and v.Character and v.Character:FindFirstChildOfClass("Humanoid") then
				for k, x in pairs(v.Character:GetChildren()) do
					if string.find(x.Name, "Torso") then
						local Distance = (WorldToScreen(x) - MousePositionToVector2()).Magnitude
						if Distance < ClosestDistance then
							ClosestDistance = Distance
							found = v
						end
					end
				end
			end
		end
		return found
	end

	SpecialPlayerCases = {
		["all"] = function(speaker)
			return Players:GetPlayers()
		end,
		["others"] = function(speaker)
			local plrs = {}
			for i, v in pairs(Players:GetPlayers()) do
				if v ~= speaker then
					table.insert(plrs, v)
				end
			end
			return plrs
		end,
		["me"] = function(speaker)
			return { speaker }
		end,
		["#(%d+)"] = function(speaker, args, currentList)
			local returns = {}
			local randAmount = tonumber(args[1])
			local players = { unpack(currentList) }
			for i = 1, randAmount do
				if #players == 0 then
					break
				end
				local randIndex = math.random(1, #players)
				table.insert(returns, players[randIndex])
				table.remove(players, randIndex)
			end
			return returns
		end,
		["random"] = function(speaker, args, currentList)
			local players = Players:GetPlayers()
			local localplayer = Players.LocalPlayer
			table.remove(players, table.find(players, localplayer))
			return { players[math.random(1, #players)] }
		end,
		["%%(.+)"] = function(speaker, args)
			local returns = {}
			local team = args[1]
			for _, plr in pairs(Players:GetPlayers()) do
				if plr.Team and string.sub(string.lower(plr.Team.Name), 1, #team) == string.lower(team) then
					table.insert(returns, plr)
				end
			end
			return returns
		end,
		["allies"] = function(speaker)
			local returns = {}
			local team = speaker.Team
			for _, plr in pairs(Players:GetPlayers()) do
				if plr.Team == team then
					table.insert(returns, plr)
				end
			end
			return returns
		end,
		["enemies"] = function(speaker)
			local returns = {}
			local team = speaker.Team
			for _, plr in pairs(Players:GetPlayers()) do
				if plr.Team ~= team then
					table.insert(returns, plr)
				end
			end
			return returns
		end,
		["team"] = function(speaker)
			local returns = {}
			local team = speaker.Team
			for _, plr in pairs(Players:GetPlayers()) do
				if plr.Team == team then
					table.insert(returns, plr)
				end
			end
			return returns
		end,
		["nonteam"] = function(speaker)
			local returns = {}
			local team = speaker.Team
			for _, plr in pairs(Players:GetPlayers()) do
				if plr.Team ~= team then
					table.insert(returns, plr)
				end
			end
			return returns
		end,
		["friends"] = function(speaker, args)
			local returns = {}
			for _, plr in pairs(Players:GetPlayers()) do
				if plr:IsFriendsWith(speaker.UserId) and plr ~= speaker then
					table.insert(returns, plr)
				end
			end
			return returns
		end,
		["nonfriends"] = function(speaker, args)
			local returns = {}
			for _, plr in pairs(Players:GetPlayers()) do
				if not plr:IsFriendsWith(speaker.UserId) and plr ~= speaker then
					table.insert(returns, plr)
				end
			end
			return returns
		end,
		["guests"] = function(speaker, args)
			local returns = {}
			for _, plr in pairs(Players:GetPlayers()) do
				if plr.Guest then
					table.insert(returns, plr)
				end
			end
			return returns
		end,
		["bacons"] = function(speaker, args)
			local returns = {}
			for _, plr in pairs(Players:GetPlayers()) do
				if plr.Character:FindFirstChild("Pal Hair") or plr.Character:FindFirstChild("Kate Hair") then
					table.insert(returns, plr)
				end
			end
			return returns
		end,
		["age(%d+)"] = function(speaker, args)
			local returns = {}
			local age = tonumber(args[1])
			if not age == nil then
				return
			end
			for _, plr in pairs(Players:GetPlayers()) do
				if plr.AccountAge <= age then
					table.insert(returns, plr)
				end
			end
			return returns
		end,
		["nearest"] = function(speaker, args, currentList)
			local speakerChar = speaker.Character
			if not speakerChar or not getRoot(speakerChar) then
				return
			end
			local lowest = math.huge
			local NearestPlayer = nil
			for _, plr in pairs(currentList) do
				if plr ~= speaker and plr.Character then
					local distance = plr:DistanceFromCharacter(getRoot(speakerChar).Position)
					if distance < lowest then
						lowest = distance
						NearestPlayer = { plr }
					end
				end
			end
			return NearestPlayer
		end,
		["farthest"] = function(speaker, args, currentList)
			local speakerChar = speaker.Character
			if not speakerChar or not getRoot(speakerChar) then
				return
			end
			local highest = 0
			local Farthest = nil
			for _, plr in pairs(currentList) do
				if plr ~= speaker and plr.Character then
					local distance = plr:DistanceFromCharacter(getRoot(speakerChar).Position)
					if distance > highest then
						highest = distance
						Farthest = { plr }
					end
				end
			end
			return Farthest
		end,
		["group(%d+)"] = function(speaker, args)
			local returns = {}
			local groupID = tonumber(args[1])
			for _, plr in pairs(Players:GetPlayers()) do
				if plr:IsInGroup(groupID) then
					table.insert(returns, plr)
				end
			end
			return returns
		end,
		["alive"] = function(speaker, args)
			local returns = {}
			for _, plr in pairs(Players:GetPlayers()) do
				if
					plr.Character
					and plr.Character:FindFirstChildOfClass("Humanoid")
					and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0
				then
					table.insert(returns, plr)
				end
			end
			return returns
		end,
		["dead"] = function(speaker, args)
			local returns = {}
			for _, plr in pairs(Players:GetPlayers()) do
				if
					(not plr.Character or not plr.Character:FindFirstChildOfClass("Humanoid"))
					or plr.Character:FindFirstChildOfClass("Humanoid").Health <= 0
				then
					table.insert(returns, plr)
				end
			end
			return returns
		end,
		["rad(%d+)"] = function(speaker, args)
			local returns = {}
			local radius = tonumber(args[1])
			local speakerChar = speaker.Character
			if not speakerChar or not getRoot(speakerChar) then
				return
			end
			for _, plr in pairs(Players:GetPlayers()) do
				if plr.Character and getRoot(plr.Character) then
					local magnitude = (getRoot(plr.Character).Position - getRoot(speakerChar).Position).magnitude
					if magnitude <= radius then
						table.insert(returns, plr)
					end
				end
			end
			return returns
		end,
		["cursor"] = function(speaker)
			local plrs = {}
			local v = GetClosestPlayerFromCursor()
			if v ~= nil then
				table.insert(plrs, v)
			end
			return plrs
		end,
		["npcs"] = function(speaker, args)
			local returns = {}
			for _, v in pairs(workspace:GetDescendants()) do
				if
					v:IsA("Model")
					and getRoot(v)
					and v:FindFirstChildWhichIsA("Humanoid")
					and Players:GetPlayerFromCharacter(v) == nil
				then
					local clone = Instance.new("Player")
					clone.Name = v.Name .. " - " .. v:FindFirstChildWhichIsA("Humanoid").DisplayName
					clone.Character = v
					table.insert(returns, clone)
				end
			end
			return returns
		end,
	}

	function toTokens(str)
		local tokens = {}
		for op, name in string.gmatch(str, "([+-])([^+-]+)") do
			table.insert(tokens, { Operator = op, Name = name })
		end
		return tokens
	end

	function onlyIncludeInTable(tab, matches)
		local matchTable = {}
		local resultTable = {}
		for i, v in pairs(matches) do
			matchTable[v.Name] = true
		end
		for i, v in pairs(tab) do
			if matchTable[v.Name] then
				table.insert(resultTable, v)
			end
		end
		return resultTable
	end

	function removeTableMatches(tab, matches)
		local matchTable = {}
		local resultTable = {}
		for i, v in pairs(matches) do
			matchTable[v.Name] = true
		end
		for i, v in pairs(tab) do
			if not matchTable[v.Name] then
				table.insert(resultTable, v)
			end
		end
		return resultTable
	end

	function getPlayersByName(Name)
		local Name, Len, Found = string.lower(Name), #Name, {}
		for _, v in pairs(Players:GetPlayers()) do
			if Name:sub(0, 1) == "@" then
				if string.sub(string.lower(v.Name), 1, Len - 1) == Name:sub(2) then
					table.insert(Found, v)
				end
			else
				if
					string.sub(string.lower(v.Name), 1, Len) == Name
					or string.sub(string.lower(v.DisplayName), 1, Len) == Name
				then
					table.insert(Found, v)
				end
			end
		end
		return Found
	end

	function getPlayer(list, speaker)
		if list == nil then
			return { speaker.Name }
		end
		local nameList = splitString(list, ",")

		local foundList = {}

		for _, name in pairs(nameList) do
			if string.sub(name, 1, 1) ~= "+" and string.sub(name, 1, 1) ~= "-" then
				name = "+" .. name
			end
			local tokens = toTokens(name)
			local initialPlayers = Players:GetPlayers()

			for i, v in pairs(tokens) do
				if v.Operator == "+" then
					local tokenContent = v.Name
					local foundCase = false
					for regex, case in pairs(SpecialPlayerCases) do
						local matches = { string.match(tokenContent, "^" .. regex .. "$") }
						if #matches > 0 then
							foundCase = true
							initialPlayers = onlyIncludeInTable(initialPlayers, case(speaker, matches, initialPlayers))
						end
					end
					if not foundCase then
						initialPlayers = onlyIncludeInTable(initialPlayers, getPlayersByName(tokenContent))
					end
				else
					local tokenContent = v.Name
					local foundCase = false
					for regex, case in pairs(SpecialPlayerCases) do
						local matches = { string.match(tokenContent, "^" .. regex .. "$") }
						if #matches > 0 then
							foundCase = true
							initialPlayers = removeTableMatches(initialPlayers, case(speaker, matches, initialPlayers))
						end
					end
					if not foundCase then
						initialPlayers = removeTableMatches(initialPlayers, getPlayersByName(tokenContent))
					end
				end
			end

			for i, v in pairs(initialPlayers) do
				table.insert(foundList, v)
			end
		end

		local foundNames = {}
		for i, v in pairs(foundList) do
			table.insert(foundNames, v.Name)
		end

		return foundNames
	end

	function formatUsername(player)
		if player.DisplayName ~= player.Name then
			return string.format("%s (%s)", player.Name, player.DisplayName)
		end
		return player.Name
	end

	getprfx = function(strn)
		if strn:sub(1, string.len(prefix)) == prefix then
			return { "cmd", string.len(prefix) + 1 }
		end
		return
	end

	function do_exec(str, plr)
		str = str:gsub("/e ", "")
		local t = getprfx(str)
		if not t then
			return
		end
		str = str:sub(t[2])
		if t[1] == "cmd" then
			execCmd(str, plr, true)
			IndexContents("", true, false, true)
			CMDsF.CanvasPosition = canvasPos
		end
	end

	lastTextBoxString, lastTextBoxCon, lastEnteredString = nil, nil, nil

	UserInputService.TextBoxFocused:Connect(function(obj)
		if lastTextBoxCon then
			lastTextBoxCon:Disconnect()
		end
		if obj == Cmdbar then
			lastTextBoxString = nil
			return
		end
		lastTextBoxString = obj.Text
		lastTextBoxCon = obj:GetPropertyChangedSignal("Text"):Connect(function()
			if
				not (
					UserInputService:IsKeyDown(Enum.KeyCode.Return)
					or UserInputService:IsKeyDown(Enum.KeyCode.KeypadEnter)
				)
			then
				lastTextBoxString = obj.Text
			end
		end)
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then
			if Cmdbar and Cmdbar:IsFocused() then
				if input.KeyCode == Enum.KeyCode.Up then
					historyCount = historyCount + 1
					if historyCount > #cmdHistory then
						historyCount = #cmdHistory
					end
					Cmdbar.Text = cmdHistory[historyCount] or ""
					Cmdbar.CursorPosition = 1020
				elseif input.KeyCode == Enum.KeyCode.Down then
					historyCount = historyCount - 1
					if historyCount < 0 then
						historyCount = 0
					end
					Cmdbar.Text = cmdHistory[historyCount] or ""
					Cmdbar.CursorPosition = 1020
				end
			elseif input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.KeypadEnter then
				lastEnteredString = lastTextBoxString
			end
		end
	end)

	Players.LocalPlayer.Chatted:Connect(function()
		wait()
		if lastEnteredString then
			local message = lastEnteredString
			lastEnteredString = nil
			do_exec(message, Players.LocalPlayer)
		end
	end)

	Cmdbar.PlaceholderText = "Command Bar (" .. prefix .. ")"
	Cmdbar:GetPropertyChangedSignal("Text"):Connect(function()
		if Cmdbar:IsFocused() then
			IndexContents(Cmdbar.Text, true, true)
		end
	end)

	local tabComplete = nil
	tabAllowed = true
	Cmdbar.FocusLost:Connect(function(enterpressed)
		if enterpressed then
			local cmdbarText = Cmdbar.Text:gsub("^" .. prefix, "")
			execCmd(cmdbarText, Players.LocalPlayer, true)
		end
		if tabComplete then
			tabComplete:Disconnect()
		end
		wait()
		if not Cmdbar:IsFocused() then
			Cmdbar.Text = ""
			IndexContents("", true, false, true)
			if SettingsOpen == true then
				wait(0.2)
				Settings:TweenPosition(UDim2.new(0, 0, 0, 45), "InOut", "Quart", 0.2, true, nil)
				CMDsF.Visible = false
			end
		end
		CMDsF.CanvasPosition = canvasPos
	end)

	Cmdbar.Focused:Connect(function()
		historyCount = 0
		canvasPos = CMDsF.CanvasPosition
		if SettingsOpen == true then
			wait(0.2)
			CMDsF.Visible = true
			Settings:TweenPosition(UDim2.new(0, 0, 0, 220), "InOut", "Quart", 0.2, true, nil)
		end
		tabComplete = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if Cmdbar:IsFocused() then
				if tabAllowed == true and input.KeyCode == Enum.KeyCode.Tab and topCommand ~= nil then
					autoComplete(topCommand)
				end
			else
				tabComplete:Disconnect()
			end
		end)
	end)

	return env
end
