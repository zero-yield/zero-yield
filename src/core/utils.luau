return function(env)
	function create(data)
		local insts = {}
		for i, v in pairs(data) do
			insts[v[1]] = Instance.new(v[2])
		end

		for _, v in pairs(data) do
			for prop, val in pairs(v[3]) do
				if type(val) == "table" then
					insts[v[1]][prop] = insts[val[1]]
				else
					insts[v[1]][prop] = val
				end
			end
		end

		return insts[1]
	end

	ViewportTextBox = (function()
		local funcs = {}
		funcs.Update = function(self)
			local cursorPos = self.TextBox.CursorPosition
			local text = self.TextBox.Text
			if text == "" then
				self.TextBox.Position = UDim2.new(0, 2, 0, 0)
				return
			end
			if cursorPos == -1 then
				return
			end

			local cursorText = text:sub(1, cursorPos - 1)
			local pos = nil
			local leftEnd = -self.TextBox.Position.X.Offset
			local rightEnd = leftEnd + self.View.AbsoluteSize.X

			local totalTextSize =
				TextService:GetTextSize(text, self.TextBox.TextSize, self.TextBox.Font, Vector2.new(999999999, 100)).X
			local cursorTextSize = TextService:GetTextSize(
				cursorText,
				self.TextBox.TextSize,
				self.TextBox.Font,
				Vector2.new(999999999, 100)
			).X

			if cursorTextSize > rightEnd then
				pos = math.max(-2, cursorTextSize - self.View.AbsoluteSize.X + 2)
			elseif cursorTextSize < leftEnd then
				pos = math.max(-2, cursorTextSize - 2)
			elseif totalTextSize < rightEnd then
				pos = math.max(-2, totalTextSize - self.View.AbsoluteSize.X + 2)
			end

			if pos then
				self.TextBox.Position = UDim2.new(0, -pos, 0, 0)
				self.TextBox.Size = UDim2.new(1, pos, 1, 0)
			end
		end

		local mt = {}
		mt.__index = funcs

		local function convert(textbox)
			local obj = setmetatable({ OffsetX = 0, TextBox = textbox }, mt)

			local view = Instance.new("Frame")
			view.BackgroundTransparency = textbox.BackgroundTransparency
			view.BackgroundColor3 = textbox.BackgroundColor3
			view.BorderSizePixel = textbox.BorderSizePixel
			view.BorderColor3 = textbox.BorderColor3
			view.Position = textbox.Position
			view.Size = textbox.Size
			view.ClipsDescendants = true
			view.Name = textbox.Name
			view.ZIndex = 10
			textbox.BackgroundTransparency = 1
			textbox.Position = UDim2.new(0, 4, 0, 0)
			textbox.Size = UDim2.new(1, -8, 1, 0)
			textbox.TextXAlignment = Enum.TextXAlignment.Left
			textbox.Name = "Input"
			table.insert(text1, textbox)
			table.insert(shade2, view)

			obj.View = view

			textbox.Changed:Connect(function(prop)
				if prop == "Text" or prop == "CursorPosition" or prop == "AbsoluteSize" then
					obj:Update()
				end
			end)

			obj:Update()

			view.Parent = textbox.Parent
			textbox.Parent = view

			return obj
		end

		return { convert = convert }
	end)()

	ViewportTextBox.convert(Cmdbar).View.ZIndex = 10
	ViewportTextBox.convert(Cmdbar_2).View.ZIndex = 10
	ViewportTextBox.convert(Cmdbar_3).View.ZIndex = 10

	function writefileExploit()
		if writefile then
			return true
		end
	end

	function readfileExploit()
		if readfile then
			return true
		end
	end

	function isNumber(str)
		if tonumber(str) ~= nil or str == "inf" then
			return true
		end
	end

	function vtype(o, t)
		if o == nil then
			return false
		end
		if type(o) == "userdata" then
			return typeof(o) == t
		end
		return type(o) == t
	end

	function getRoot(char)
		if char and char:FindFirstChildOfClass("Humanoid") then
			return char:FindFirstChildOfClass("Humanoid").RootPart
		else
			return nil
		end
	end

	function tools(plr)
		if
			plr:FindFirstChildOfClass("Backpack"):FindFirstChildOfClass("Tool")
			or plr.Character:FindFirstChildOfClass("Tool")
		then
			return true
		end
	end

	function r15(plr)
		if plr.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
			return true
		end
	end

	function breakVelocity()
		local V3 = Vector3.new(0, 0, 0)
		for _, v in ipairs(Players.LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Velocity, v.RotVelocity = V3, V3
			end
		end
	end

	function toClipboard(txt)
		if everyClipboard then
			everyClipboard(tostring(txt)) -- some executor errored without tostring btw so dont call me out for this
			notify("Clipboard", "Copied to clipboard")
		else
			notify("Clipboard", "Your exploit doesn't have the ability to use the clipboard")
		end
	end

	function chatMessage(str)
		str = tostring(str)
		if not isLegacyChat then
			TextChatService.TextChannels.RBXGeneral:SendAsync(str)
		else
			ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(str, "All")
		end
	end

	function getHierarchy(obj)
		local fullname
		local period

		if string.find(obj.Name, " ") then
			fullname = '["' .. obj.Name .. '"]'
			period = false
		else
			fullname = obj.Name
			period = true
		end

		local getS = obj
		local parent = obj
		local service = ""

		if getS.Parent ~= game then
			repeat
				getS = getS.Parent
				service = getS.ClassName
			until getS.Parent == game
		end

		if parent.Parent ~= getS then
			repeat
				parent = parent.Parent
				if string.find(tostring(parent), " ") then
					if period then
						fullname = '["' .. parent.Name .. '"].' .. fullname
					else
						fullname = '["' .. parent.Name .. '"]' .. fullname
					end
					period = false
				else
					if period then
						fullname = parent.Name .. "." .. fullname
					else
						fullname = parent.Name .. "" .. fullname
					end
					period = true
				end
			until parent.Parent == getS
		elseif string.find(tostring(parent), " ") then
			fullname = '["' .. parent.Name .. '"]'
			period = false
		end

		if period then
			return 'game:GetService("' .. service .. '").' .. fullname
		else
			return 'game:GetService("' .. service .. '")' .. fullname
		end
	end

	AllWaypoints = {}

	local cooldown = false
	function writefileCooldown(name, data)
		task.spawn(function()
			if not cooldown then
				cooldown = true
				writefile(name, data, true)
			else
				repeat
					wait()
				until cooldown == false
				writefileCooldown(name, data)
			end
			wait(3)
			cooldown = false
		end)
	end

	function dragGUI(gui)
		task.spawn(function()
			local dragging
			local dragInput
			local dragStart = Vector3.new(0, 0, 0)
			local startPos
			local function update(input)
				local delta = input.Position - dragStart
				local Position = UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)
				TweenService:Create(gui, TweenInfo.new(0.20), { Position = Position }):Play()
			end
			gui.InputBegan:Connect(function(input)
				if
					input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch
				then
					dragging = true
					dragStart = input.Position
					startPos = gui.Position

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)
			gui.InputChanged:Connect(function(input)
				if
					input.UserInputType == Enum.UserInputType.MouseMovement
					or input.UserInputType == Enum.UserInputType.Touch
				then
					dragInput = input
				end
			end)
			UserInputService.InputChanged:Connect(function(input)
				if input == dragInput and dragging then
					update(input)
				end
			end)
		end)
	end

	dragGUI(logs)
	dragGUI(KeybindEditor)
	dragGUI(PluginEditor)
	dragGUI(ToPartFrame)

	avatarcache = {}
	function sendChatWebhook(player, message)
		if httprequest and vtype(logsWebhook, "string") then
			local id = player.UserId
			local avatar = avatarcache[id]
			if not avatar then
				local d = HttpService:JSONDecode(httprequest({
					Url = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds="
						.. id
						.. "&size=420x420&format=Png&isCircular=false",
					Method = "GET",
				}).Body)["data"]
				avatar = d and d[1].state == "Completed" and d[1].imageUrl or "https://files.catbox.moe/i968v2.jpg"
				avatarcache[id] = avatar
			end
			local log = HttpService:JSONEncode({
				content = message,
				avatar_url = avatar,
				username = formatUsername(player),
				allowed_mentions = { parse = {} },
			})
			httprequest({
				Url = logsWebhook,
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json" },
				Body = log,
			})
		end
	end

	ChatLog = function(player)
		player.Chatted:Connect(function(message)
			if logsEnabled == true then
				CreateLabel(player.Name, message)
				sendChatWebhook(player, message)
			end
		end)
	end

	JoinLog = function(plr)
		if jLogsEnabled == true then
			CreateJoinLabel(plr, plr.UserId)
		end
	end

	CleanFileName = function(name)
		return tostring(name):gsub("[*\\?:<>|]+", ""):sub(1, 175)
	end

	SaveChatlogs.MouseButton1Down:Connect(function()
		if writefileExploit() then
			if #scroll_2:GetChildren() > 0 then
				notify("Loading", "Hold on a sec")
				local placeName = CleanFileName(MarketplaceService:GetProductInfo(PlaceId).Name)
				local writelogs = '-- Zero Yield Chat logs for "' .. placeName .. '"\n'
				for _, child in pairs(scroll_2:GetChildren()) do
					writelogs = writelogs .. "\n" .. child.Text
				end
				local writelogsFile = tostring(writelogs)
				local fileext = 0
				local function nameFile()
					local file
					pcall(function()
						file = readfile(placeName .. " Chat Logs (" .. fileext .. ").txt")
					end)
					if file then
						fileext = fileext + 1
						nameFile()
					else
						writefileCooldown(placeName .. " Chat Logs (" .. fileext .. ").txt", writelogsFile)
					end
				end
				nameFile()
				notify("Chat Logs", "Saved chat logs to the workspace folder within your exploit folder.")
			end
		else
			notify("Chat Logs", "Your exploit does not support write file. You cannot save chat logs.")
		end
	end)

	if isLegacyChat then
		for _, plr in pairs(Players:GetPlayers()) do
			ChatLog(plr)
		end
	end

	Players.PlayerRemoving:Connect(function(player)
		if ESPenabled or CHMSenabled or COREGUI:FindFirstChild(player.Name .. "_LC") then
			for i, v in pairs(COREGUI:GetChildren()) do
				if
					v.Name == player.Name .. "_ESP"
					or v.Name == player.Name .. "_LC"
					or v.Name == player.Name .. "_CHMS"
				then
					v:Destroy()
				end
			end
		end
		if viewing ~= nil and player == viewing then
			workspace.CurrentCamera.CameraSubject = Players.LocalPlayer.Character
			viewing = nil
			if viewDied then
				viewDied:Disconnect()
				viewChanged:Disconnect()
			end
			notify("Spectate", "View turned off (player left)")
		end
		if eventEditor then
			eventEditor.FireEvent("OnLeave", player.Name)
		end
	end)

	Exit.MouseButton1Down:Connect(function()
		logs:TweenPosition(UDim2.new(0, 0, 1, 10), "InOut", "Quart", 0.3, true, nil)
	end)

	Hide.MouseButton1Down:Connect(function()
		if logs.Position ~= UDim2.new(0, 0, 1, -20) then
			logs:TweenPosition(UDim2.new(0, 0, 1, -20), "InOut", "Quart", 0.3, true, nil)
		else
			logs:TweenPosition(UDim2.new(0, 0, 1, -265), "InOut", "Quart", 0.3, true, nil)
		end
	end)

	EventBind.MouseButton1Click:Connect(function()
		if eventEditor then
			eventEditor.Frame:TweenPosition(UDim2.new(0.5, -175, 0.5, -101), "InOut", "Quart", 0.5, true, nil)
		end
	end)

	Keybinds.MouseButton1Click:Connect(function()
		KeybindsFrame:TweenPosition(UDim2.new(0, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
		wait(0.5)
		SettingsHolder.Visible = false
	end)

	Close.MouseButton1Click:Connect(function()
		SettingsHolder.Visible = true
		KeybindsFrame:TweenPosition(UDim2.new(0, 0, 0, 175), "InOut", "Quart", 0.5, true, nil)
	end)

	Keybinds.MouseButton1Click:Connect(function()
		KeybindsFrame:TweenPosition(UDim2.new(0, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
		wait(0.5)
		SettingsHolder.Visible = false
	end)

	Add.MouseButton1Click:Connect(function()
		KeybindEditor:TweenPosition(UDim2.new(0.5, -180, 0, 260), "InOut", "Quart", 0.5, true, nil)
	end)

	Delete.MouseButton1Click:Connect(function()
		binds = {}
		refreshbinds()
		updatesaves()
		notify("Keybinds Updated", "Removed all keybinds")
	end)

	Close_2.MouseButton1Click:Connect(function()
		SettingsHolder.Visible = true
		AliasesFrame:TweenPosition(UDim2.new(0, 0, 0, 175), "InOut", "Quart", 0.5, true, nil)
	end)

	Aliases.MouseButton1Click:Connect(function()
		AliasesFrame:TweenPosition(UDim2.new(0, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
		wait(0.5)
		SettingsHolder.Visible = false
	end)

	Close_3.MouseButton1Click:Connect(function()
		SettingsHolder.Visible = true
		PositionsFrame:TweenPosition(UDim2.new(0, 0, 0, 175), "InOut", "Quart", 0.5, true, nil)
	end)

	Positions.MouseButton1Click:Connect(function()
		PositionsFrame:TweenPosition(UDim2.new(0, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
		wait(0.5)
		SettingsHolder.Visible = false
	end)

	local selectionBox = Instance.new("SelectionBox")
	selectionBox.Name = randomString()
	selectionBox.Color3 = Color3.new(255, 255, 255)
	selectionBox.Adornee = nil
	selectionBox.Parent = PARENT

	local selected = Instance.new("SelectionBox")
	selected.Name = randomString()
	selected.Color3 = Color3.new(0, 166, 0)
	selected.Adornee = nil
	selected.Parent = PARENT

	local ActivateHighlight = nil
	local ClickSelect = nil
	function selectPart()
		ToPartFrame:TweenPosition(UDim2.new(0.5, -180, 0, 335), "InOut", "Quart", 0.5, true, nil)
		local function HighlightPart()
			if selected.Adornee ~= ZYMouse.Target then
				selectionBox.Adornee = ZYMouse.Target
			else
				selectionBox.Adornee = nil
			end
		end
		ActivateHighlight = ZYMouse.Move:Connect(HighlightPart)
		local function SelectPart()
			if ZYMouse.Target ~= nil then
				selected.Adornee = ZYMouse.Target
				Path.Text = getHierarchy(ZYMouse.Target)
			end
		end
		ClickSelect = ZYMouse.Button1Down:Connect(SelectPart)
	end

	Part.MouseButton1Click:Connect(function()
		selectPart()
	end)

	Exit_4.MouseButton1Click:Connect(function()
		ToPartFrame:TweenPosition(UDim2.new(0.5, -180, 0, -500), "InOut", "Quart", 0.5, true, nil)
		if ActivateHighlight then
			ActivateHighlight:Disconnect()
		end
		if ClickSelect then
			ClickSelect:Disconnect()
		end
		selectionBox.Adornee = nil
		selected.Adornee = nil
		Path.Text = ""
	end)

	CopyPath.MouseButton1Click:Connect(function()
		if Path.Text ~= "" then
			toClipboard(Path.Text)
		else
			notify("Copy Path", "Select a part to copy its path")
		end
	end)

	ChoosePart.MouseButton1Click:Connect(function()
		if Path.Text ~= "" then
			local tpNameExt = ""
			local function handleWpNames()
				local FoundDupe = false
				for i, v in pairs(pWayPoints) do
					if v.NAME:lower() == selected.Adornee.Name:lower() .. tpNameExt then
						FoundDupe = true
					end
				end
				if not FoundDupe then
					notify("Modified Waypoints", "Created waypoint: " .. selected.Adornee.Name .. tpNameExt)
					pWayPoints[#pWayPoints + 1] =
						{ NAME = selected.Adornee.Name .. tpNameExt, COORD = { selected.Adornee } }
				else
					if isNumber(tpNameExt) then
						tpNameExt = tpNameExt + 1
					else
						tpNameExt = 1
					end
					handleWpNames()
				end
			end
			handleWpNames()
			refreshwaypoints()
		else
			notify("Part Selection", "Select a part first")
		end
	end)

	cmds = {}
	customAlias = {}
	Delete_3.MouseButton1Click:Connect(function()
		customAlias = {}
		aliases = {}
		notify("Aliases Modified", "Removed all aliases")
		updatesaves()
		refreshaliases()
	end)

	PrefixBox:GetPropertyChangedSignal("Text"):Connect(function()
		prefix = PrefixBox.Text
		Cmdbar.PlaceholderText = "Command Bar (" .. prefix .. ")"
		updatesaves()
	end)

	function FindInTable(tbl, val)
		if tbl == nil then
			return false
		end
		for _, v in pairs(tbl) do
			if v == val then
				return true
			end
		end
		return false
	end

	function GetInTable(Table, Name)
		for i = 1, #Table do
			if Table[i] == Name then
				return i
			end
		end
		return false
	end

	function respawn(plr)
		if invisRunning then
			TurnVisible()
		end
		local char = plr.Character
		local hum = char:FindFirstChildWhichIsA("Humanoid")
		local archive = workspace.FallenPartsDestroyHeight
		local camType = workspace.CurrentCamera.CameraType
		workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
		workspace.FallenPartsDestroyHeight = 0 / 0
		getRoot(char).Position = Vector3.yAxis * archive
		task.wait(plr:GetNetworkPing())
		workspace.FallenPartsDestroyHeight = archive
		repeat
			task.wait()
		until not char.Parent or not hum.Parent or (hum and hum.Health <= 0)
		if hum then
			hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
		end
	end

	local refreshCmd = false
	function refresh(plr)
		refreshCmd = true
		local root = getRoot(plr.Character)
		local pos = root.CFrame
		local pos1 = workspace.CurrentCamera.CFrame
		respawn(plr)
		task.spawn(function()
			local char = plr.CharacterAdded:Wait()
			local humanoid = char:FindFirstChildOfClass("Humanoid")
			while not humanoid do
				wait()
				humanoid = char:FindFirstChildOfClass("Humanoid")
			end
			humanoid.RootPart.CFrame, workspace.CurrentCamera.CFrame = pos, task.wait() and pos1
			refreshCmd = false
		end)
	end

	local lastDeath

	function onDied()
		task.spawn(function()
			if
				pcall(function()
					Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
				end) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			then
				Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
					if getRoot(Players.LocalPlayer.Character) then
						lastDeath = getRoot(Players.LocalPlayer.Character).CFrame
					end
				end)
			else
				wait(2)
				onDied()
			end
		end)
	end

	Clip = true
	spDelay = 0.1
	Players.LocalPlayer.CharacterAdded:Connect(function()
		NOFLY()
		floating = false

		if not Clip then
			execCmd("clip")
		end

		repeat
			wait()
		until getRoot(Players.LocalPlayer.Character)

		pcall(function()
			if spawnpoint and not refreshCmd and spawnpos ~= nil then
				wait(spDelay)
				getRoot(Players.LocalPlayer.Character).CFrame = spawnpos
			end
		end)

		onDied()
	end)

	onDied()

	local booly = {
		truthy = {
			["true"] = true,
			["t"] = true,
			["1"] = true,
			["yes"] = true,
			["y"] = true,
			["on"] = true,
			["enable"] = true,
			["enabled"] = true,
		},
		falsy = {
			["false"] = true,
			["f"] = true,
			["0"] = true,
			["no"] = true,
			["n"] = true,
			["off"] = true,
			["disable"] = true,
			["disabled"] = true,
		},
	}

	function parseBoolean(raw, default)
		raw = tostring(raw):lower()
		if booly.truthy[raw] then
			return true
		end
		if booly.falsy[raw] then
			return false
		end
		return default or false
	end

	function getstring(begin, args)
		return table.concat(args or cargs, " ", begin)
	end

	findCmd = function(cmd_name)
		for i, v in pairs(cmds) do
			if v.NAME:lower() == cmd_name:lower() or FindInTable(v.ALIAS, cmd_name:lower()) then
				return v
			end
		end
		return customAlias[cmd_name:lower()]
	end

	function splitString(str, delim)
		local broken = {}
		if delim == nil then
			delim = ","
		end
		for w in string.gmatch(str, "[^" .. delim .. "]+") do
			table.insert(broken, w)
		end
		return broken
	end

	function createPopup(title, text)
		local Popup = Instance.new("Frame")
		local background = Instance.new("Frame")
		local Directions = Instance.new("TextLabel")
		local shadow = Instance.new("Frame")
		local PopupText = Instance.new("TextLabel")
		local Exit = Instance.new("TextButton")
		local ExitImage = Instance.new("ImageLabel")

		Popup.Name = randomString()
		Popup.Parent = ScaledHolder
		Popup.Active = true
		Popup.BackgroundTransparency = 1
		Popup.Position = UDim2.new(0.5, -180, 0, -500)
		Popup.Size = UDim2.new(0, 360, 0, 20)
		Popup.ZIndex = 10

		background.Name = "background"
		background.Parent = Popup
		background.Active = true
		background.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
		background.BorderSizePixel = 0
		background.Position = UDim2.new(0, 0, 0, 20)
		background.Size = UDim2.new(0, 360, 0, 205)
		background.ZIndex = 10

		Directions.Name = "Directions"
		Directions.Parent = background
		Directions.BackgroundTransparency = 1
		Directions.BorderSizePixel = 0
		Directions.Position = UDim2.new(0, 10, 0, 10)
		Directions.Size = UDim2.new(0, 340, 0, 185)
		Directions.Font = Enum.Font.SourceSans
		Directions.TextSize = 14
		Directions.Text = text
		Directions.TextColor3 = Color3.new(1, 1, 1)
		Directions.TextWrapped = true
		Directions.TextXAlignment = Enum.TextXAlignment.Left
		Directions.TextYAlignment = Enum.TextYAlignment.Top
		Directions.ZIndex = 10

		shadow.Name = "shadow"
		shadow.Parent = Popup
		shadow.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
		shadow.BorderSizePixel = 0
		shadow.Size = UDim2.new(0, 360, 0, 20)
		shadow.ZIndex = 10

		PopupText.Name = "PopupText"
		PopupText.Parent = shadow
		PopupText.BackgroundTransparency = 1
		PopupText.Size = UDim2.new(1, 0, 0.95, 0)
		PopupText.ZIndex = 10
		PopupText.Font = Enum.Font.SourceSans
		PopupText.TextSize = 14
		PopupText.Text = title
		PopupText.TextColor3 = Color3.new(1, 1, 1)
		PopupText.TextWrapped = true

		Exit.Name = "Exit"
		Exit.Parent = shadow
		Exit.BackgroundTransparency = 1
		Exit.Position = UDim2.new(1, -20, 0, 0)
		Exit.Size = UDim2.new(0, 20, 0, 20)
		Exit.Text = ""
		Exit.ZIndex = 10

		ExitImage.Parent = Exit
		ExitImage.BackgroundColor3 = Color3.new(1, 1, 1)
		ExitImage.BackgroundTransparency = 1
		ExitImage.Position = UDim2.new(0, 5, 0, 5)
		ExitImage.Size = UDim2.new(0, 10, 0, 10)
		ExitImage.Image = getcustomasset("zeroyield/assets/close.png")
		ExitImage.ZIndex = 10

		Popup:TweenPosition(UDim2.new(0.5, -180, 0, 150), "InOut", "Quart", 0.5, true, nil)

		Exit.MouseButton1Click:Connect(function()
			Popup:TweenPosition(UDim2.new(0.5, -180, 0, -500), "InOut", "Quart", 0.5, true, nil)
			task.wait(0.6)
			Popup:Destroy()
		end)
	end

	if currentShade1 == nil then
		currentShade1 = Color3.fromRGB(36, 36, 37)
	end
	if currentShade2 == nil then
		currentShade2 = Color3.fromRGB(46, 46, 47)
	end
	if currentShade3 == nil then
		currentShade3 = Color3.fromRGB(78, 78, 79)
	end
	if currentText1 == nil then
		currentText1 = Color3.new(1, 1, 1)
	end
	if currentText2 == nil then
		currentText2 = Color3.new(0, 0, 0)
	end
	if currentScroll == nil then
		currentScroll = Color3.fromRGB(78, 78, 79)
	end

	local loadedEventData = nil
	local jsonAttempts = 0
	function saves()
		if writefileExploit() and readfileExploit() and jsonAttempts < 10 then
			local readSuccess, out = readfile("ZY_FE.zy", true)
			if readSuccess then
				if out ~= nil and tostring(out):gsub("%s", "") ~= "" then
					local success, response = pcall(function()
						local json = HttpService:JSONDecode(out)
						if vtype(json.prefix, "string") then
							prefix = json.prefix
						else
							prefix = ";"
						end
						if vtype(json.StayOpen, "boolean") then
							StayOpen = json.StayOpen
						else
							StayOpen = false
						end
						if vtype(json.guiScale, "number") then
							guiScale = json.guiScale
						else
							guiScale = defaultGuiScale
						end
						if vtype(json.keepZY, "boolean") then
							KeepInfYield = json.keepZY
						else
							KeepInfYield = true
						end
						if vtype(json.espTransparency, "number") then
							espTransparency = json.espTransparency
						else
							espTransparency = 0.3
						end
						if vtype(json.logsEnabled, "boolean") then
							logsEnabled = json.logsEnabled
						else
							logsEnabled = false
						end
						if vtype(json.jLogsEnabled, "boolean") then
							jLogsEnabled = json.jLogsEnabled
						else
							jLogsEnabled = false
						end
						if vtype(json.logsWebhook, "string") then
							logsWebhook = json.logsWebhook
						else
							logsWebhook = nil
						end
						if vtype(json.currentShade1, "table") then
							currentShade1 =
								Color3.new(json.currentShade1[1], json.currentShade1[2], json.currentShade1[3])
						end
						if vtype(json.currentShade2, "table") then
							currentShade2 =
								Color3.new(json.currentShade2[1], json.currentShade2[2], json.currentShade2[3])
						end
						if vtype(json.currentShade3, "table") then
							currentShade3 =
								Color3.new(json.currentShade3[1], json.currentShade3[2], json.currentShade3[3])
						end
						if vtype(json.currentText1, "table") then
							currentText1 = Color3.new(json.currentText1[1], json.currentText1[2], json.currentText1[3])
						end
						if vtype(json.currentText2, "table") then
							currentText2 = Color3.new(json.currentText2[1], json.currentText2[2], json.currentText2[3])
						end
						if vtype(json.currentScroll, "table") then
							currentScroll =
								Color3.new(json.currentScroll[1], json.currentScroll[2], json.currentScroll[3])
						end
						if vtype(json.aliases, "table") then
							aliases = json.aliases
						end
						if vtype(json.binds, "table") then
							binds = json.binds
						end
						if vtype(json.WayPoints, "table") then
							WayPoints = json.WayPoints
						end
						if vtype(json.PluginsTable, "table") then
							PluginsTable = json.PluginsTable
						end
						if vtype(json.eventBinds, "string") then
							loadedEventData = json.eventBinds
						end
						if vtype(json.spawnCmds, "table") then
							spawnCmds = json.spawnCmds
						end
					end)
					if not success then
						jsonAttempts = jsonAttempts + 1
						warn("Zero Yield: Failed to parse saves JSON. Attempt " .. jsonAttempts .. " of 10.")
					end
				end
			end
		end
	end

	prefix = prefix or ";"
	StayOpen = StayOpen or false
	guiScale = guiScale or 1
	KeepInfYield = KeepInfYield == nil and true or KeepInfYield
	espTransparency = espTransparency or 0.3
	logsEnabled = logsEnabled or false
	jLogsEnabled = jLogsEnabled or false
	aliases = aliases or {}
	binds = binds or {}
	pWayPoints = pWayPoints or {}
	WayPoints = WayPoints or {}
	PluginsTable = PluginsTable or {}

	function updatesaves()
		if writefileExploit() then
			local data = {
				prefix = prefix,
				StayOpen = StayOpen,
				guiScale = guiScale,
				keepZY = KeepInfYield,
				espTransparency = espTransparency,
				logsEnabled = logsEnabled,
				jLogsEnabled = jLogsEnabled,
				logsWebhook = logsWebhook,
				currentShade1 = { currentShade1.R, currentShade1.G, currentShade1.B },
				currentShade2 = { currentShade2.R, currentShade2.G, currentShade2.B },
				currentShade3 = { currentShade3.R, currentShade3.G, currentShade3.B },
				currentText1 = { currentText1.R, currentText1.G, currentText1.B },
				currentText2 = { currentText2.R, currentText2.G, currentText2.B },
				currentScroll = { currentScroll.R, currentScroll.G, currentScroll.B },
				aliases = aliases,
				binds = binds,
				WayPoints = WayPoints,
				PluginsTable = PluginsTable,
				eventBinds = eventEditor and eventEditor.SaveData() or {},
				spawnCmds = spawnCmds,
			}
			writefile("ZY_FE.zy", HttpService:JSONEncode(data), true)
		end
	end

	function Time()
		local HOUR = math.floor((tick() % 86400) / 3600)
		local MINUTE = math.floor((tick() % 3600) / 60)
		local SECOND = math.floor(tick() % 60)
		local AP = HOUR > 11 and "PM" or "AM"
		HOUR = (HOUR % 12 == 0 and 12 or HOUR % 12)
		HOUR = HOUR < 10 and "0" .. HOUR or HOUR
		MINUTE = MINUTE < 10 and "0" .. MINUTE or MINUTE
		SECOND = SECOND < 10 and "0" .. SECOND or SECOND
		return HOUR .. ":" .. MINUTE .. ":" .. SECOND .. " " .. AP
	end

	function maximizeHolder()
		if StayOpen == false then
			Holder:TweenPosition(UDim2.new(1, Holder.Position.X.Offset, 1, -220), "InOut", "Quart", 0.2, true, nil)
		end
	end

	minimizeNum = -20
	function minimizeHolder()
		if StayOpen == false then
			Holder:TweenPosition(UDim2.new(1, Holder.Position.X.Offset, 1, minimizeNum), "InOut", "Quart", 0.5, true, nil)
		end
	end

	function cmdbarHolder()
		if StayOpen == false then
			Holder:TweenPosition(UDim2.new(1, Holder.Position.X.Offset, 1, -45), "InOut", "Quart", 0.5, true, nil)
		end
	end

	pinNotification = nil
	local notifyCount = 0
	function notify(text, text2, length)
		task.spawn(function()
			local LnotifyCount = notifyCount + 1
			local notificationPinned = false
			notifyCount = notifyCount + 1
			if pinNotification then
				pinNotification:Disconnect()
			end
			pinNotification = PinButton.MouseButton1Click:Connect(function()
				task.spawn(function()
					pinNotification:Disconnect()
					notificationPinned = true
					Title_2.BackgroundTransparency = 1
					wait(0.5)
					Title_2.BackgroundTransparency = 0
				end)
			end)
			Notification:TweenPosition(UDim2.new(1, Notification.Position.X.Offset, 1, 0), "InOut", "Quart", 0.5, true, nil)
			wait(0.6)
			local closepressed = false
			if text2 then
				Title_2.Text = text
				Text_2.Text = text2
			else
				Title_2.Text = "Notification"
				Text_2.Text = text
			end
			Notification:TweenPosition(
				UDim2.new(1, Notification.Position.X.Offset, 1, -100),
				"InOut",
				"Quart",
				0.5,
				true,
				nil
			)
			CloseButton.MouseButton1Click:Connect(function()
				Notification:TweenPosition(
					UDim2.new(1, Notification.Position.X.Offset, 1, 0),
					"InOut",
					"Quart",
					0.5,
					true,
					nil
				)
				closepressed = true
				pinNotification:Disconnect()
			end)
			if length and isNumber(length) then
				wait(length)
			else
				wait(10)
			end
			if LnotifyCount == notifyCount then
				if closepressed == false and notificationPinned == false then
					pinNotification:Disconnect()
					Notification:TweenPosition(
						UDim2.new(1, Notification.Position.X.Offset, 1, 0),
						"InOut",
						"Quart",
						0.5,
						true,
						nil
					)
				end
				notifyCount = 0
			end
		end)
	end

	function CreateLabel(name, text)
		local dynamicLabel = Instance.new("TextLabel")
		dynamicLabel.Size = UDim2.new(1, -10, 0, 30)
		dynamicLabel.Position = UDim2.new(0, 5, 0, 0)
		dynamicLabel.BackgroundTransparency = 1
		dynamicLabel.Text = ""
		dynamicLabel.TextColor3 = Color3.new(1, 1, 1)
		dynamicLabel.TextScaled = false
		dynamicLabel.TextSize = 14
		dynamicLabel.Font = Enum.Font.SourceSans
		dynamicLabel.TextXAlignment = Enum.TextXAlignment.Left
		dynamicLabel.TextWrapped = true
		dynamicLabel.ZIndex = 10
		dynamicLabel.RichText = true
		dynamicLabel.Parent = scroll_2
		local time_label = Instance.new("TextLabel")
		time_label.Size = UDim2.new(0, 50, 1, 0)
		time_label.Position = UDim2.new(1, -55, 0, 0)
		time_label.BackgroundTransparency = 1
		time_label.Text = "[" .. Time() .. "]"
		time_label.TextColor3 = Color3.new(1, 1, 1)
		time_label.TextScaled = false
		time_label.TextSize = 14
		time_label.Font = Enum.Font.SourceSans
		time_label.TextXAlignment = Enum.TextXAlignment.Right
		time_label.ZIndex = 10
		time_label.Parent = dynamicLabel
		local msg = Instance.new("TextLabel")
		msg.Size = UDim2.new(1, -10, 1, 0)
		msg.Position = UDim2.new(0, 5, 0, 0)
		msg.BackgroundTransparency = 1
		msg.Text = ""
		msg.TextColor3 = Color3.new(1, 1, 1)
		msg.TextScaled = false
		msg.TextSize = 14
		msg.Font = Enum.Font.SourceSans
		msg.TextXAlignment = Enum.TextXAlignment.Left
		msg.TextWrapped = true
		msg.ZIndex = 10
		msg.RichText = true
		msg.Parent = dynamicLabel
		dynamicLabel.Text = name .. ": "
		msg.Text = text
		scroll_2.CanvasSize = UDim2.new(0, 0, 0, cmdListLayout.AbsoluteContentSize.Y)
	end

	function CreateJoinLabel(name, text)
		local dynamicLabel = Instance.new("TextLabel")
		dynamicLabel.Size = UDim2.new(1, -10, 0, 20)
		dynamicLabel.Position = UDim2.new(0, 5, 0, 0)
		dynamicLabel.BackgroundTransparency = 1
		dynamicLabel.Text = ""
		dynamicLabel.TextColor3 = Color3.new(1, 1, 1)
		dynamicLabel.TextScaled = false
		dynamicLabel.TextSize = 14
		dynamicLabel.Font = Enum.Font.SourceSans
		dynamicLabel.TextXAlignment = Enum.TextXAlignment.Left
		dynamicLabel.TextWrapped = true
		dynamicLabel.ZIndex = 10
		dynamicLabel.RichText = true
		dynamicLabel.Parent = scroll_3
		local time_label = Instance.new("TextLabel")
		time_label.Size = UDim2.new(0, 50, 1, 0)
		time_label.Position = UDim2.new(1, -55, 0, 0)
		time_label.BackgroundTransparency = 1
		time_label.Text = "[" .. Time() .. "]"
		time_label.TextColor3 = Color3.new(1, 1, 1)
		time_label.TextScaled = false
		time_label.TextSize = 14
		time_label.Font = Enum.Font.SourceSans
		time_label.TextXAlignment = Enum.TextXAlignment.Right
		time_label.ZIndex = 10
		time_label.Parent = dynamicLabel
		dynamicLabel.Text = text
		scroll_3.CanvasSize = UDim2.new(0, 0, 0, listlayout.AbsoluteContentSize.Y)
	end

	local lastMinimizeReq = 0
	Holder.MouseEnter:Connect(function()
		lastMinimizeReq = 0
		maximizeHolder()
	end)

	Holder.MouseLeave:Connect(function()
		if not Cmdbar:IsFocused() then
			local reqTime = tick()
			lastMinimizeReq = reqTime
			wait(1)
			if lastMinimizeReq ~= reqTime then
				return
			end
			if not Cmdbar:IsFocused() then
				minimizeHolder()
			end
		end
	end)

	maximizeHolder()
	updatesaves()

	return env
end
