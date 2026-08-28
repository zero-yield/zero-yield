return function(env)
	function CamViewport()
		if workspace.CurrentCamera then
			return workspace.CurrentCamera.ViewportSize.X
		end
	end

	function UpdateToViewport()
		if Holder.Position.X.Offset < -CamViewport() then
			Holder:TweenPosition(
				UDim2.new(1, -CamViewport(), Holder.Position.Y.Scale, Holder.Position.Y.Offset),
				"InOut",
				"Quart",
				0.04,
				true,
				nil
			)
			Notification:TweenPosition(
				UDim2.new(1, -CamViewport() + 250, Notification.Position.Y.Scale, Notification.Position.Y.Offset),
				"InOut",
				"Quart",
				0.04,
				true,
				nil
			)
		end
	end
	CameraChanged = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateToViewport)

	function updateCamera(child, parent)
		if parent ~= workspace then
			CamMoved:Disconnect()
			CameraChanged:Disconnect()
			repeat
				task.wait()
			until workspace.CurrentCamera
			CameraChanged = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateToViewport)
			CamMoved = workspace.CurrentCamera.AncestryChanged:Connect(updateCamera)
		end
	end
	CamMoved = workspace.CurrentCamera.AncestryChanged:Connect(updateCamera)

	function dragMain(dragpoint, gui)
		task.spawn(function()
			local dragging
			local dragInput
			local dragStart = Vector3.new(0, 0, 0)
			local startPos
			local function update(input)
				local pos = -250
				local delta = input.Position - dragStart
				if startPos.X.Offset + delta.X <= -500 then
					local Position = UDim2.new(1, -250, Notification.Position.Y.Scale, Notification.Position.Y.Offset)
					TweenService:Create(Notification, TweenInfo.new(0.20), { Position = Position }):Play()
					pos = 250
				else
					local Position = UDim2.new(1, -500, Notification.Position.Y.Scale, Notification.Position.Y.Offset)
					TweenService:Create(Notification, TweenInfo.new(0.20), { Position = Position }):Play()
					pos = -250
				end
				if startPos.X.Offset + delta.X <= -250 and -CamViewport() <= startPos.X.Offset + delta.X then
					local Position = UDim2.new(
						startPos.X.Scale,
						startPos.X.Offset + delta.X,
						gui.Position.Y.Scale,
						gui.Position.Y.Offset
					)
					TweenService:Create(gui, TweenInfo.new(0.20), { Position = Position }):Play()
					local Position2 = UDim2.new(
						startPos.X.Scale,
						startPos.X.Offset + delta.X + pos,
						Notification.Position.Y.Scale,
						Notification.Position.Y.Offset
					)
					TweenService:Create(Notification, TweenInfo.new(0.20), { Position = Position2 }):Play()
				elseif startPos.X.Offset + delta.X > -500 then
					local Position = UDim2.new(1, -250, gui.Position.Y.Scale, gui.Position.Y.Offset)
					TweenService:Create(gui, TweenInfo.new(0.20), { Position = Position }):Play()
				elseif -CamViewport() > startPos.X.Offset + delta.X then
					gui:TweenPosition(
						UDim2.new(1, -CamViewport(), gui.Position.Y.Scale, gui.Position.Y.Offset),
						"InOut",
						"Quart",
						0.04,
						true,
						nil
					)
					local Position = UDim2.new(1, -CamViewport(), gui.Position.Y.Scale, gui.Position.Y.Offset)
					TweenService:Create(gui, TweenInfo.new(0.20), { Position = Position }):Play()
					local Position2 = UDim2.new(
						1,
						-CamViewport() + 250,
						Notification.Position.Y.Scale,
						Notification.Position.Y.Offset
					)
					TweenService:Create(Notification, TweenInfo.new(0.20), { Position = Position2 }):Play()
				end
			end
			dragpoint.InputBegan:Connect(function(input)
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
			dragpoint.InputChanged:Connect(function(input)
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

	dragMain(Title, Holder)

	Match = function(name, str)
		str = str:gsub("%W", "%%%1")
		return name:lower():find(str:lower()) and true
	end

	local canvasPos = Vector2.new(0, 0)
	local topCommand = nil
	local function updateCommandCanvasSize(frame)
		local scale = (Scale and Scale.Scale) or 1
		if scale <= 0 then
			scale = 1
		end
		local contentY = cmdListLayout.AbsoluteContentSize.Y
		local unscaledY = math.ceil(contentY / scale)
		frame.CanvasSize = UDim2.new(0, 0, 0, math.max(0, unscaledY))
	end
	cmdListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		updateCommandCanvasSize(CMDsF)
	end)
	IndexContents = function(str, bool, cmdbar, Ianim)
		CMDsF.CanvasPosition = Vector2.new(0, 0)
		local SizeY = 0
		local indexnum = 0
		local frame = CMDsF
		topCommand = nil
		local chunks = {}
		if str:sub(#str, #str) == "\\" then
			str = ""
		end
		for w in string.gmatch(str, "[^\\]+") do
			table.insert(chunks, w)
		end
		if #chunks > 0 then
			str = chunks[#chunks]
		end
		if str:sub(1, 1) == "!" then
			str = str:sub(2)
		end
		for i, v in next, frame:GetChildren() do
			if v:IsA("TextButton") then
				if bool then
					if Match(v.Text, str) then
						indexnum = indexnum + 1
						v.Visible = true
						if topCommand == nil then
							topCommand = v.Text
						end
					else
						v.Visible = false
					end
				else
					v.Visible = true
					if topCommand == nil then
						topCommand = v.Text
					end
				end
			end
		end
		updateCommandCanvasSize(frame)
		if not Ianim then
			if indexnum == 0 or string.find(str, " ") then
				if not cmdbar then
					minimizeHolder()
				elseif cmdbar then
					cmdbarHolder()
				end
			else
				maximizeHolder()
			end
		else
			minimizeHolder()
		end
	end

	task.spawn(function()
		if not isLegacyChat then
			return
		end
		local chatbox
		local success, result = pcall(function()
			chatbox = PlayerGui:WaitForChild("Chat").Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar
		end)
		if success then
			local function chatboxFocused()
				canvasPos = CMDsF.CanvasPosition
			end
			local chatboxFocusedC = chatbox.Focused:Connect(chatboxFocused)

			local function Index()
				if chatbox.Text:lower():sub(1, 1) == prefix then
					if SettingsOpen then
						task.wait(0.2)
						CMDsF.Visible = true
						Settings:TweenPosition(UDim2.new(0, 0, 0, 220), "InOut", "Quart", 0.2, true, nil)
					end
					IndexContents(
						PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar.Text:lower():sub(2),
						true
					)
				else
					minimizeHolder()
					if SettingsOpen then
						task.wait(0.2)
						Settings:TweenPosition(UDim2.new(0, 0, 0, 45), "InOut", "Quart", 0.2, true, nil)
						CMDsF.Visible = false
					end
				end
			end
			local chatboxFunc = chatbox:GetPropertyChangedSignal("Text"):Connect(Index)

			local function chatboxFocusLost(enterpressed)
				if not enterpressed or chatbox.Text:lower():sub(1, 1) ~= prefix then
					IndexContents("", true)
				end
				CMDsF.CanvasPosition = canvasPos
				minimizeHolder()
			end
			local chatboxFocusLostC = chatbox.FocusLost:Connect(chatboxFocusLost)

			PlayerGui:WaitForChild("Chat").Frame.ChatBarParentFrame.ChildAdded:Connect(function(newbar)
				task.wait()
				if newbar:FindFirstChild("BoxFrame") then
					chatbox = PlayerGui:WaitForChild("Chat").Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar
					if chatboxFocusedC then
						chatboxFocusedC:Disconnect()
					end
					chatboxFocusedC = chatbox.Focused:Connect(chatboxFocused)
					if chatboxFunc then
						chatboxFunc:Disconnect()
					end
					chatboxFunc = chatbox:GetPropertyChangedSignal("Text"):Connect(Index)
					if chatboxFocusLostC then
						chatboxFocusLostC:Disconnect()
					end
					chatboxFocusLostC = chatbox.FocusLost:Connect(chatboxFocusLost)
				end
			end)
			--else
			--print('Custom chat detected. Will not provide suggestions for commands typed in the chat.')
		end
	end)

	function autoComplete(str, curText)
		local endingChar = { "[", "/", "(", " " }
		local stop = 0
		for i = 1, #str do
			local c = str:sub(i, i)
			if table.find(endingChar, c) then
				stop = i
				break
			end
		end
		curText = curText or Cmdbar.Text
		local subPos = 0
		local pos = 1
		local findRes = string.find(curText, "\\", pos)
		while findRes do
			subPos = findRes
			pos = findRes + 1
			findRes = string.find(curText, "\\", pos)
		end
		if curText:sub(subPos + 1, subPos + 1) == "!" then
			subPos = subPos + 1
		end
		Cmdbar.Text = curText:sub(1, subPos) .. str:sub(1, stop - 1) .. " "
		RunService.RenderStepped:Wait()
		Cmdbar.Text = Cmdbar.Text:gsub("\t", "")
		Cmdbar.CursorPosition = #Cmdbar.Text + 1 --1020
	end

	CMDs = {}
	CMDs[#CMDs + 1] =
		{ NAME = "discord / support / help", DESC = "Invite to the Zero Yield discord server. (aka Beignet Scripts)" }
	CMDs[#CMDs + 1] = {
		NAME = "guiscale [number]",
		DESC = "Changes the size of the gui. [number] accepts decimals and whole numbers. Min is 0.4 and Max is 2",
	}
	CMDs[#CMDs + 1] =
		{ NAME = "unc / unctest", DESC = "Runs the UNC test suite to check your executor's UNC compatibility" }
	CMDs[#CMDs + 1] = {
		NAME = "sunc / sunctest",
		DESC = "Runs the extended sUNC test suite to test your executor's UNC compatibility (NOTE: you need to join sUNC's testing game)",
	}
	CMDs[#CMDs + 1] = { NAME = "console", DESC = "Opens the Roblox console" }
	CMDs[#CMDs + 1] = { NAME = "oldconsole", DESC = "Loads an old-themed Roblox console" }
	CMDs[#CMDs + 1] = { NAME = "explorer / dex", DESC = "Opens Dex++ by Chillz" }
	CMDs[#CMDs + 1] = { NAME = "moondex / mdex", DESC = "Opens DEX by Moon" }
	CMDs[#CMDs + 1] =
		{ NAME = "remotespy / rspy", DESC = "Opens Cobalt to intercept incoming and outgoing network traffic" }
	CMDs[#CMDs + 1] = {
		NAME = "simplespy / sspy",
		DESC = "Opens Simple Spy V3 to intercept remote calls from the client to the server",
	}
	CMDs[#CMDs + 1] = { NAME = "audiologger / alogger", DESC = "Opens Edges audio logger" }
	CMDs[#CMDs + 1] = { NAME = "serverinfo / info", DESC = "Gives you info about the server" }
	CMDs[#CMDs + 1] = { NAME = "jobid", DESC = "Copies the games JobId to your clipboard" }
	CMDs[#CMDs + 1] = { NAME = "notifyjobid", DESC = "Notifies you the games JobId" }
	CMDs[#CMDs + 1] = { NAME = "rejoin / rj [reposition]", DESC = "Makes you rejoin the game" }
	CMDs[#CMDs + 1] = {
		NAME = "inviteprompt",
		DESC = "Prompts the user of your choice that they had invited you. Requires a rejoin to function.",
	}
	CMDs[#CMDs + 1] =
		{ NAME = "autorejoin / autorj", DESC = "Automatically rejoins the server if you get kicked/disconnected" }
	CMDs[#CMDs + 1] = { NAME = "serverhop / shop", DESC = "Teleports you to a different server" }
	CMDs[#CMDs + 1] = { NAME = "gameteleport / gametp [place ID]", DESC = "Joins a game by ID" }
	CMDs[#CMDs + 1] = { NAME = "antiidle / antiafk", DESC = "Prevents the game from kicking you for being idle/afk" }
	CMDs[#CMDs + 1] = { NAME = "datalimit [num]", DESC = "Set outgoing KBPS limit" }
	CMDs[#CMDs + 1] = { NAME = "replicationlag / backtrack [num]", DESC = "Set IncomingReplicationLag" }
	CMDs[#CMDs + 1] = { NAME = "creatorid / creator", DESC = "Notifies you the creators ID" }
	CMDs[#CMDs + 1] = { NAME = "copycreatorid / copycreator", DESC = "Copies the creators ID to your clipboard" }
	CMDs[#CMDs + 1] = { NAME = "setcreatorid / setcreator", DESC = "Sets your userid to the creators ID" }
	CMDs[#CMDs + 1] = { NAME = "noprompts", DESC = "Prevents the game from showing you purchase/premium prompts" }
	CMDs[#CMDs + 1] = { NAME = "showprompts", DESC = "Allows the game to show purchase/premium prompts again" }
	CMDs[#CMDs + 1] =
		{ NAME = "enable [inventory/playerlist/chat/reset/emotes/all]", DESC = "Toggles visibility of coregui items" }
	CMDs[#CMDs + 1] =
		{ NAME = "disable [inventory/playerlist/chat/reset/emotes/all]", DESC = "Toggles visibility of coregui items" }
	CMDs[#CMDs + 1] = { NAME = "showguis", DESC = "Shows any invisible GUIs" }
	CMDs[#CMDs + 1] = { NAME = "unshowguis", DESC = "Undoes showguis" }
	CMDs[#CMDs + 1] = { NAME = "hideguis", DESC = "Hides any GUIs in PlayerGui" }
	CMDs[#CMDs + 1] = { NAME = "unhideguis", DESC = "Undoes hideguis" }
	CMDs[#CMDs + 1] = { NAME = "guidelete", DESC = "Enables backspace to delete GUI" }
	CMDs[#CMDs + 1] = { NAME = "unguidelete / noguidelete", DESC = "Disables guidelete" }
	CMDs[#CMDs + 1] = { NAME = "hidezy", DESC = "Hides the main ZY GUI" }
	CMDs[#CMDs + 1] = { NAME = "showzy / unhidezy", DESC = "Shows ZY again" }
	CMDs[#CMDs + 1] = { NAME = "keepzy", DESC = "Auto execute ZY when you teleport through servers" }
	CMDs[#CMDs + 1] = { NAME = "unkeepzy", DESC = "Disable keepzy" }
	CMDs[#CMDs + 1] = { NAME = "togglekeepzy", DESC = "Toggles keepzy" }
	CMDs[#CMDs + 1] = { NAME = "removeads / adblock", DESC = "Automatically removes ad billboards" }
	CMDs[#CMDs + 1] = { NAME = "savegame / saveplace", DESC = "Uses saveinstance to save the game" }
	CMDs[#CMDs + 1] = { NAME = "clearerror", DESC = "Clears the annoying box and blur when a game kicks you" }
	CMDs[#CMDs + 1] = {
		NAME = "antigameplaypaused",
		DESC = "Clears the annoying box shown when a game is loading assets due to network lag",
	}
	CMDs[#CMDs + 1] = { NAME = "unantigameplaypaused", DESC = "Disables antigameplaypaused" }
	CMDs[#CMDs + 1] = { NAME = "clientantikick / antikick (CLIENT)", DESC = "Prevents localscripts from kicking you" }
	CMDs[#CMDs + 1] =
		{ NAME = "clientantiteleport / antiteleport (CLIENT)", DESC = "Prevents localscripts from teleporting you" }
	CMDs[#CMDs + 1] =
		{ NAME = "allowrejoin / allowrj (CLIENT)", DESC = "Toggles if antiteleport allows you to rejoin or not" }
	CMDs[#CMDs + 1] = { NAME = "cancelteleport / canceltp", DESC = "Cancels teleports in progress" }
	CMDs[#CMDs + 1] = { NAME = "volume / vol [0-10]", DESC = "Adjusts your game volume on a scale of 0 to 10" }
	CMDs[#CMDs + 1] = { NAME = "antilag / boostfps / lowgraphics", DESC = "Lowers game quality to boost FPS" }
	CMDs[#CMDs + 1] = { NAME = "record / rec", DESC = "Starts Roblox recorder" }
	CMDs[#CMDs + 1] = { NAME = "screenshot / scrnshot", DESC = "Takes a screenshot" }
	CMDs[#CMDs + 1] = { NAME = "togglefullscreen / togglefs", DESC = "Toggles fullscreen" }
	CMDs[#CMDs + 1] = { NAME = "notify [text]", DESC = "Sends you a notification with the provided text" }
	CMDs[#CMDs + 1] = { NAME = "lastcommand / lastcmd", DESC = "Executes the previous command used" }
	CMDs[#CMDs + 1] = { NAME = "notifyping / ping", DESC = "Notify yourself your ping" }
	CMDs[#CMDs + 1] = { NAME = "norender", DESC = "Disable 3d Rendering to decrease the amount of CPU the client uses" }
	CMDs[#CMDs + 1] = { NAME = "render", DESC = "Enable 3d Rendering" }
	CMDs[#CMDs + 1] = { NAME = "use2022materials / 2022materials", DESC = "Enables 2022 material textures" }
	CMDs[#CMDs + 1] = { NAME = "unuse2022materials / un2022materials", DESC = "Disables 2022 material textures" }
	CMDs[#CMDs + 1] = { NAME = "alignmentkeys", DESC = "Enables the left and right alignment keys (comma and period)" }
	CMDs[#CMDs + 1] = { NAME = "unalignmentkeys / noalignmentkeys", DESC = "Disables the alignment keys" }
	CMDs[#CMDs + 1] = { NAME = "ctrllock", DESC = "Binds Shiftlock to LeftControl" }
	CMDs[#CMDs + 1] = { NAME = "unctrllock", DESC = "Re-binds Shiftlock to LeftShift" }
	CMDs[#CMDs + 1] = { NAME = "exit / shutdown / leave", DESC = "Exits the game" }
	CMDs[#CMDs + 1] = { NAME = "removecmd / deletecmd", DESC = "Removes a command until the script is reloaded" }
	CMDs[#CMDs + 1] = { NAME = "breakloops / break (cmd loops)", DESC = "Stops any cmd loops (;100^1^cmd)" }
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] = { NAME = "noclip", DESC = "Go through objects" }
	CMDs[#CMDs + 1] = { NAME = "unnoclip / clip", DESC = "Disables noclip" }
	CMDs[#CMDs + 1] = { NAME = "fly [speed]", DESC = "Makes you fly" }
	CMDs[#CMDs + 1] = { NAME = "unfly", DESC = "Disables fly" }
	CMDs[#CMDs + 1] = { NAME = "flyspeed [num]", DESC = "Set fly speed (default is 20)" }
	CMDs[#CMDs + 1] = { NAME = "vehiclefly / vfly [speed]", DESC = "Makes you fly in a vehicle" }
	CMDs[#CMDs + 1] = { NAME = "unvehiclefly / unvfly", DESC = "Disables vehicle fly" }
	CMDs[#CMDs + 1] = { NAME = "vehicleflyspeed  / vflyspeed [num]", DESC = "Set vehicle fly speed" }
	CMDs[#CMDs + 1] =
		{ NAME = "cframefly / cfly [speed]", DESC = "Makes you fly, bypassing some anti cheats (works on mobile)" }
	CMDs[#CMDs + 1] = { NAME = "uncframefly / uncfly", DESC = "Disables cfly" }
	CMDs[#CMDs + 1] = { NAME = "cframeflyspeed  / cflyspeed [num]", DESC = "Sets cfly speed" }
	CMDs[#CMDs + 1] = { NAME = "qefly [true / false]", DESC = "Enables or disables the Q and E hotkeys for fly" }
	CMDs[#CMDs + 1] = { NAME = "vehiclenoclip / vnoclip", DESC = "Turns off vehicle collision" }
	CMDs[#CMDs + 1] = { NAME = "vehicleclip / vclip / unvnoclip", DESC = "Enables vehicle collision" }
	CMDs[#CMDs + 1] = { NAME = "float /  platform", DESC = "Spawns a platform beneath you causing you to float" }
	CMDs[#CMDs + 1] = { NAME = "unfloat / noplatform", DESC = "Removes the platform" }
	CMDs[#CMDs + 1] = { NAME = "swim", DESC = "Allows you to swim in the air" }
	CMDs[#CMDs + 1] = { NAME = "unswim / noswim", DESC = "Stops you from swimming everywhere" }
	CMDs[#CMDs + 1] = { NAME = "toggleswim", DESC = "Toggles swimming" }
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] = { NAME = "setwaypoint / swp [name]", DESC = "Sets a waypoint at your position" }
	CMDs[#CMDs + 1] = { NAME = "waypointpos / wpp [name] [X Y Z]", DESC = "Sets a waypoint with specified coordinates" }
	CMDs[#CMDs + 1] = { NAME = "waypoints", DESC = "Shows a list of currently active waypoints" }
	CMDs[#CMDs + 1] = { NAME = "showwaypoints / showwp", DESC = "Shows all currently set waypoints" }
	CMDs[#CMDs + 1] = { NAME = "hidewaypoints / hidewp", DESC = "Hides shown waypoints" }
	CMDs[#CMDs + 1] = { NAME = "waypoint / wp [name]", DESC = "Teleports player to a waypoint" }
	CMDs[#CMDs + 1] = { NAME = "tweenwaypoint / twp [name]", DESC = "Tweens player to a waypoint" }
	CMDs[#CMDs + 1] = { NAME = "walktowaypoint / wtwp [name]", DESC = "Walks player to a waypoint" }
	CMDs[#CMDs + 1] = { NAME = "deletewaypoint / dwp [name]", DESC = "Deletes a waypoint" }
	CMDs[#CMDs + 1] = { NAME = "clearwaypoints / cwp", DESC = "Clears all waypoints" }
	CMDs[#CMDs + 1] = { NAME = "cleargamewaypoints / cgamewp", DESC = "Clears all waypoints for the game you are in" }
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] = { NAME = "goto [player] [request stream]", DESC = "Go to a player" }
	CMDs[#CMDs + 1] = { NAME = "tweengoto / tgoto [player]", DESC = "Tween to a player (bypasses some anti cheats)" }
	CMDs[#CMDs + 1] =
		{ NAME = "tweenspeed / tspeed [num]", DESC = "Sets how fast all tween commands go (default is 1)" }
	CMDs[#CMDs + 1] = { NAME = "vehiclegoto / vgoto [player]", DESC = "Go to a player while in a vehicle" }
	CMDs[#CMDs + 1] = { NAME = "loopgoto [player] [distance] [delay]", DESC = "Loop teleport to a player" }
	CMDs[#CMDs + 1] = { NAME = "unloopgoto", DESC = "Stops teleporting you to a player" }
	CMDs[#CMDs + 1] =
		{ NAME = "pulsetp / ptp [player] [seconds]", DESC = "Teleports you to a player for a specified amount of time" }
	CMDs[#CMDs + 1] = { NAME = "clientbring / cbring [player] (CLIENT)", DESC = "Bring a player" }
	CMDs[#CMDs + 1] = {
		NAME = "loopbring [player] [distance] [delay] (CLIENT)",
		DESC = "Loop brings a player to you (useful for killing)",
	}
	CMDs[#CMDs + 1] = { NAME = "unloopbring [player]", DESC = "Undoes loopbring" }
	CMDs[#CMDs + 1] = { NAME = "freeze / fr [player] (CLIENT)", DESC = "Freezes a player" }
	CMDs[#CMDs + 1] = {
		NAME = "freezeanims",
		DESC = "Freezes your animations / pauses your animations - Does not work on default animations",
	}
	CMDs[#CMDs + 1] = { NAME = "unfreezeanims", DESC = "Unfreezes your animations / plays your animations" }
	CMDs[#CMDs + 1] = { NAME = "thaw / unfr [player] (CLIENT)", DESC = "Unfreezes a player" }
	CMDs[#CMDs + 1] = { NAME = "anchor", DESC = "Anchors your characters RootPart" }
	CMDs[#CMDs + 1] = { NAME = "unanchor", DESC = "Unanchors your characters RootPart" }
	CMDs[#CMDs + 1] = { NAME = "tpposition / tppos [X Y Z]", DESC = "Teleports you to certain coordinates" }
	CMDs[#CMDs + 1] =
		{ NAME = "tweentpposition / ttppos [X Y Z]", DESC = "Tween to coordinates (bypasses some anti cheats)" }
	CMDs[#CMDs + 1] = { NAME = "offset [X Y Z]", DESC = "Offsets you by certain coordinates" }
	CMDs[#CMDs + 1] = { NAME = "tweenoffset / toffset [X Y Z]", DESC = "Tween offset (bypasses some anti cheats)" }
	CMDs[#CMDs + 1] =
		{ NAME = "thru [num]", DESC = "Teleports you [num] studs ahead of where your character is facing" }
	CMDs[#CMDs + 1] =
		{ NAME = "notifyposition / notifypos [player]", DESC = "Notifies you the coordinates of a character" }
	CMDs[#CMDs + 1] =
		{ NAME = "copyposition / copypos [player]", DESC = "Copies the coordinates of a character to your clipboard" }
	CMDs[#CMDs + 1] = { NAME = "walktoposition / walktopos [X Y Z]", DESC = "Makes you walk to a coordinate" }
	CMDs[#CMDs + 1] = { NAME = "spawnpoint / spawn [delay]", DESC = "Sets a position where you will spawn" }
	CMDs[#CMDs + 1] = { NAME = "nospawnpoint / nospawn", DESC = "Removes your custom spawn point" }
	CMDs[#CMDs + 1] = { NAME = "flashback / diedtp", DESC = "Teleports you to where you last died" }
	CMDs[#CMDs + 1] = { NAME = "walltp", DESC = "Teleports you above/over any wall you run into" }
	CMDs[#CMDs + 1] = { NAME = "nowalltp / unwalltp", DESC = "Disables walltp" }
	CMDs[#CMDs + 1] = { NAME = "teleporttool / tptool", DESC = "Gives you a teleport tool" }
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] = { NAME = "logs", DESC = "Opens the logs GUI" }
	CMDs[#CMDs + 1] = { NAME = "chatlogs / clogs", DESC = "Log what people say or whisper" }
	CMDs[#CMDs + 1] = { NAME = "joinlogs / jlogs", DESC = "Log when people join" }
	CMDs[#CMDs + 1] = {
		NAME = "chatlogswebhook / logswebhook [url]",
		DESC = "Set a discord webhook for chatlogs to go to (provide no url to disable this)",
	}
	CMDs[#CMDs + 1] = { NAME = "chat / say [text]", DESC = "Makes you chat a string (possible mute bypass)" }
	CMDs[#CMDs + 1] = { NAME = "spam [text]", DESC = "Makes you spam the chat" }
	CMDs[#CMDs + 1] = { NAME = "unspam", DESC = "Turns off spam" }
	CMDs[#CMDs + 1] =
		{ NAME = "whisper / pm [player] [text]", DESC = "Makes you whisper a string to someone (possible mute bypass)" }
	CMDs[#CMDs + 1] = { NAME = "pmspam [player] [text]", DESC = "Makes you spam a players whispers" }
	CMDs[#CMDs + 1] = { NAME = "unpmspam [player]", DESC = "Turns off pm spam" }
	CMDs[#CMDs + 1] = { NAME = "spamspeed [num]", DESC = "How quickly you spam (default is 1)" }
	CMDs[#CMDs + 1] = { NAME = "bubblechat (CLIENT)", DESC = "Enables bubble chat for your client" }
	CMDs[#CMDs + 1] = { NAME = "unbubblechat / nobubblechat", DESC = "Disables the bubblechat command" }
	CMDs[#CMDs + 1] = { NAME = "chatwindow", DESC = "Enables the chat window for your client" }
	CMDs[#CMDs + 1] = { NAME = "unchatwindow / nochatwindow", DESC = "Disables the chat window for your client" }
	CMDs[#CMDs + 1] = { NAME = "darkchat", DESC = "Makes the chat window dark for your client" }
	CMDs[#CMDs + 1] =
		{ NAME = "listento [player]", DESC = "Listens to the area around a player. Can also eavesdrop with vc" }
	CMDs[#CMDs + 1] = { NAME = "unlistento", DESC = "Disables listento" }
	CMDs[#CMDs + 1] = { NAME = "muteallvoices / muteallvcs", DESC = "Mutes voice chat for all players" }
	CMDs[#CMDs + 1] = { NAME = "unmuteallvoices / unmuteallvcs", DESC = "Unmutes voice chat for all players" }
	CMDs[#CMDs + 1] = { NAME = "mutevc [player]", DESC = "Mutes the voice chat of a player" }
	CMDs[#CMDs + 1] = { NAME = "unmutevc [player]", DESC = "Unmutes the voice chat of a player" }
	CMDs[#CMDs + 1] = {
		NAME = "phonebook / call",
		DESC = "Prompts the Roblox phonebook UI to let you call your friends. Needs voice chat enabled",
	}
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] = { NAME = "esp", DESC = "View all players and their status" }
	CMDs[#CMDs + 1] = { NAME = "espteam", DESC = "ESP but teammates are green and bad guys are red" }
	CMDs[#CMDs + 1] = { NAME = "noesp / unesp / unespteam", DESC = "Removes ESP" }
	CMDs[#CMDs + 1] = { NAME = "esptransparency [number]", DESC = "Changes the transparency of ESP related commands" }
	CMDs[#CMDs + 1] = { NAME = "partesp [part name]", DESC = "Highlights a part" }
	CMDs[#CMDs + 1] = { NAME = "unpartesp / nopartesp [part name]", DESC = "removes partesp" }
	CMDs[#CMDs + 1] = { NAME = "chams", DESC = "ESP but without text in the way" }
	CMDs[#CMDs + 1] = { NAME = "nochams / unchams", DESC = "Removes chams" }
	CMDs[#CMDs + 1] = { NAME = "locate [player]", DESC = "View a single player and their status" }
	CMDs[#CMDs + 1] = { NAME = "unlocate / nolocate [player]", DESC = "Removes locate" }
	CMDs[#CMDs + 1] = { NAME = "xray", DESC = "Makes all parts in workspace transparent" }
	CMDs[#CMDs + 1] = { NAME = "unxray / noxray", DESC = "Restores transparency to all parts in workspace" }
	CMDs[#CMDs + 1] = { NAME = "loopxray", DESC = "Makes all parts in workspace transparent but looped" }
	CMDs[#CMDs + 1] = { NAME = "unloopxray", DESC = "Unloops xray" }
	CMDs[#CMDs + 1] = { NAME = "togglexray", DESC = "Toggles xray" }
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] = { NAME = "spectate / view [player]", DESC = "View a player" }
	CMDs[#CMDs + 1] = { NAME = "viewpart / viewp [part name]", DESC = "View a part" }
	CMDs[#CMDs + 1] = { NAME = "unspectate / unview", DESC = "Stops viewing player" }
	CMDs[#CMDs + 1] = { NAME = "freecam / fc", DESC = "Allows you to freely move camera around the game" }
	CMDs[#CMDs + 1] = { NAME = "freecampos / fcpos [X Y Z]", DESC = "Moves / opens freecam in a certain position" }
	CMDs[#CMDs + 1] = { NAME = "freecamwaypoint / fcwp [name]", DESC = "Moves / opens freecam to a waypoint" }
	CMDs[#CMDs + 1] = { NAME = "freecamgoto / fcgoto / fctp [player]", DESC = "Moves / opens freecam to a player" }
	CMDs[#CMDs + 1] = { NAME = "unfreecam / unfc", DESC = "Disables freecam" }
	CMDs[#CMDs + 1] = { NAME = "freecamspeed / fcspeed [num]", DESC = "Adjusts freecam speed (default is 1)" }
	CMDs[#CMDs + 1] = { NAME = "notifyfreecamposition / notifyfcpos", DESC = "Noitifies you your freecam coordinates" }
	CMDs[#CMDs + 1] =
		{ NAME = "copyfreecamposition / copyfcpos", DESC = "Copies your freecam coordinates to your clipboard" }
	CMDs[#CMDs + 1] = { NAME = "gotocamera / gotocam", DESC = "Teleports you to the location of your camera" }
	CMDs[#CMDs + 1] = { NAME = "tweengotocam / tgotocam", DESC = "Tweens you to the location of your camera" }
	CMDs[#CMDs + 1] = { NAME = "firstp", DESC = "Forces camera to go into first person" }
	CMDs[#CMDs + 1] = { NAME = "thirdp", DESC = "Allows camera to go into third person" }
	CMDs[#CMDs + 1] = { NAME = "noclipcam / nccam", DESC = "Allows camera to go through objects like walls" }
	CMDs[#CMDs + 1] = { NAME = "maxzoom [num]", DESC = "Maximum camera zoom" }
	CMDs[#CMDs + 1] = { NAME = "minzoom [num]", DESC = "Minimum camera zoom" }
	CMDs[#CMDs + 1] = { NAME = "camdistance [num]", DESC = "Changes camera distance from your player" }
	CMDs[#CMDs + 1] = { NAME = "fov [num]", DESC = "Adjusts field of view (default is 70)" }
	CMDs[#CMDs + 1] = { NAME = "fixcam / restorecam", DESC = "Fixes camera" }
	CMDs[#CMDs + 1] = { NAME = "enableshiftlock / enablesl", DESC = "Enables the shift lock option" }
	CMDs[#CMDs + 1] = { NAME = "lookat [player]", DESC = "Moves your camera view to a player" }
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] = { NAME = "btools (CLIENT)", DESC = "Gives you building tools (DOES NOT REPLICATE)" }
	CMDs[#CMDs + 1] = { NAME = "f3x (CLIENT)", DESC = "Gives you F3X building tools (DOES NOT REPLICATE)" }
	CMDs[#CMDs + 1] = { NAME = "partname / partpath", DESC = "Allows you to click a part to see its path & name" }
	CMDs[#CMDs + 1] = {
		NAME = "delete [instance name] (CLIENT)",
		DESC = "Removes any part with a certain name from the workspace (DOES NOT REPLICATE)",
	}
	CMDs[#CMDs + 1] = {
		NAME = "deleteclass / dc [class name] (CLIENT)",
		DESC = "Removes any part with a certain classname from the workspace (DOES NOT REPLICATE)",
	}
	CMDs[#CMDs + 1] = { NAME = "lockworkspace / lockws", DESC = "Locks the whole workspace" }
	CMDs[#CMDs + 1] = { NAME = "unlockworkspace / unlockws", DESC = "Unlocks the whole workspace" }
	CMDs[#CMDs + 1] = { NAME = "invisibleparts / invisparts (CLIENT)", DESC = "Shows invisible parts" }
	CMDs[#CMDs + 1] = {
		NAME = "uninvisibleparts / uninvisparts (CLIENT)",
		DESC = "Makes parts affected by invisparts return to normal",
	}
	CMDs[#CMDs + 1] = { NAME = "deleteinvisparts / dip (CLIENT)", DESC = "Deletes invisible parts" }
	CMDs[#CMDs + 1] = { NAME = "gotopart [part name]", DESC = "Moves your character to a part or multiple parts" }
	CMDs[#CMDs + 1] =
		{ NAME = "tweengotopart / tgotopart [part name]", DESC = "Tweens your character to a part or multiple parts" }
	CMDs[#CMDs + 1] = {
		NAME = "gotopartclass / gpc [class name]",
		DESC = "Moves your character to a part or multiple parts based on classname",
	}
	CMDs[#CMDs + 1] = {
		NAME = "tweengotopartclass / tgpc [class name]",
		DESC = "Tweens your character to a part or multiple parts based on classname",
	}
	CMDs[#CMDs + 1] = { NAME = "gotomodel [part name]", DESC = "Moves your character to a model or multiple models" }
	CMDs[#CMDs + 1] = {
		NAME = "tweengotomodel / tgotomodel [part name]",
		DESC = "Tweens your character to a model or multiple models",
	}
	CMDs[#CMDs + 1] = {
		NAME = "gotopartdelay / gotomodeldelay [num]",
		DESC = "Adjusts how quickly you teleport to each part (default is 0.1)",
	}
	CMDs[#CMDs + 1] =
		{ NAME = "bringpart [part name] (CLIENT)", DESC = "Moves a part or multiple parts to your character" }
	CMDs[#CMDs + 1] = {
		NAME = "bringpartclass / bpc [class name] (CLIENT)",
		DESC = "Moves a part or multiple parts to your character based on classname",
	}
	CMDs[#CMDs + 1] = {
		NAME = "noclickdetectorlimits / nocdlimits",
		DESC = "Sets all click detectors MaxActivationDistance to math.huge",
	}
	CMDs[#CMDs + 1] = {
		NAME = "fireclickdetectors / firecd [name]",
		DESC = "Uses all click detectors in a game or uses the optional name",
	}
	CMDs[#CMDs + 1] = {
		NAME = "firetouchinterests / touchinterests [name]",
		DESC = "Uses all touchinterests in a game or uses the optional name",
	}
	CMDs[#CMDs + 1] = {
		NAME = "noproximitypromptlimits / nopplimits",
		DESC = "Sets all proximity prompts MaxActivationDistance to math.huge",
	}
	CMDs[#CMDs + 1] = {
		NAME = "fireproximityprompts / firepp [name]",
		DESC = "Uses all proximity prompts in a game or uses the optional name",
	}
	CMDs[#CMDs + 1] =
		{ NAME = "instantproximityprompts / instantpp", DESC = "Disable the cooldown for proximity prompts" }
	CMDs[#CMDs + 1] = { NAME = "uninstantproximityprompts / uninstantpp", DESC = "Undo the cooldown removal" }
	CMDs[#CMDs + 1] = { NAME = "tpunanchored / tpua [player]", DESC = "Teleports unanchored parts to a player" }
	CMDs[#CMDs + 1] = { NAME = "animsunanchored / freezeua", DESC = "Freezes unanchored parts" }
	CMDs[#CMDs + 1] = { NAME = "thawunanchored / thawua / unfreezeua", DESC = "Thaws unanchored parts" }
	CMDs[#CMDs + 1] = { NAME = "removeterrain / rterrain / noterrain", DESC = "Removes all terrain" }
	CMDs[#CMDs + 1] = { NAME = "clearnilinstances / nonilinstances / cni", DESC = "Removes nil instances" }
	CMDs[#CMDs + 1] = { NAME = "destroyheight / dh [num]", DESC = "Sets FallenPartsDestroyHeight" }
	CMDs[#CMDs + 1] =
		{ NAME = "fakeout", DESC = "Tp to the void and then back (useful to kill people attached to you)" }
	CMDs[#CMDs + 1] = { NAME = "antivoid", DESC = "Prevents you from falling into the void by launching you upwards" }
	CMDs[#CMDs + 1] = { NAME = "unantivoid / noantivoid", DESC = "Disables antivoid" }
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] = { NAME = "fullbright / fb (CLIENT)", DESC = "Makes the map brighter / more visible" }
	CMDs[#CMDs + 1] =
		{ NAME = "loopfullbright / loopfb (CLIENT)", DESC = "Makes the map brighter / more visible but looped" }
	CMDs[#CMDs + 1] = { NAME = "unloopfullbright / unloopfb", DESC = "Unloops fullbright" }
	CMDs[#CMDs + 1] = { NAME = "ambient [num] [num] [num] (CLIENT)", DESC = "Changes ambient" }
	CMDs[#CMDs + 1] = { NAME = "day (CLIENT)", DESC = "Changes the time to day for the client" }
	CMDs[#CMDs + 1] = { NAME = "night (CLIENT)", DESC = "Changes the time to night for the client" }
	CMDs[#CMDs + 1] = { NAME = "nofog (CLIENT)", DESC = "Removes fog" }
	CMDs[#CMDs + 1] = { NAME = "brightness [num] (CLIENT)", DESC = "Changes the brightness lighting property" }
	CMDs[#CMDs + 1] = { NAME = "globalshadows / gshadows (CLIENT)", DESC = "Enables global shadows" }
	CMDs[#CMDs + 1] = { NAME = "noglobalshadows / nogshadows (CLIENT)", DESC = "Disables global shadows" }
	CMDs[#CMDs + 1] = { NAME = "restorelighting / rlighting", DESC = "Restores Lighting properties" }
	CMDs[#CMDs + 1] = { NAME = "light [radius] [brightness] (CLIENT)", DESC = "Gives your player dynamic light" }
	CMDs[#CMDs + 1] = { NAME = "nolight / unlight", DESC = "Removes dynamic light from your player" }
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] = { NAME = "inspect / examine [player]", DESC = "Opens InspectMenu for a certain player" }
	CMDs[#CMDs + 1] = { NAME = "age [player]", DESC = "Tells you the age of a player" }
	CMDs[#CMDs + 1] = { NAME = "chatage [player]", DESC = "Chats the age of a player" }
	CMDs[#CMDs + 1] = { NAME = "joindate / jd [player]", DESC = "Tells you the date the player joined Roblox" }
	CMDs[#CMDs + 1] = { NAME = "chatjoindate / cjd [player]", DESC = "Chats the date the player joined Roblox" }
	CMDs[#CMDs + 1] =
		{ NAME = "copyname / copyuser [player]", DESC = "Copies a players full username to your clipboard" }
	CMDs[#CMDs + 1] = { NAME = "userid / id [player]", DESC = "Notifies a players user ID" }
	CMDs[#CMDs + 1] = { NAME = "copyplaceid / placeid", DESC = "Copies the current place id to your clipboard" }
	CMDs[#CMDs + 1] = { NAME = "copygameid / gameid", DESC = "Copies the current game id to your clipboard" }
	CMDs[#CMDs + 1] = { NAME = "copyuserid / copyid [player]", DESC = "Copies a players user ID to your clipboard" }
	CMDs[#CMDs + 1] = { NAME = "appearanceid / aid [player]", DESC = "Notifies a players appearance ID" }
	CMDs[#CMDs + 1] =
		{ NAME = "copyappearanceid / caid [player]", DESC = "Copies a players appearance ID to your clipboard" }
	CMDs[#CMDs + 1] = { NAME = "bang [player] [speed]", DESC = "owo" }
	CMDs[#CMDs + 1] = { NAME = "unbang", DESC = "uwu" }
	CMDs[#CMDs + 1] = { NAME = "jerk", DESC = "Makes you jork it" }
	CMDs[#CMDs + 1] = { NAME = "scare / spook [player]", DESC = "Teleports in front of a player for half a second" }
	CMDs[#CMDs + 1] = { NAME = "carpet [player]", DESC = "Be someones carpet" }
	CMDs[#CMDs + 1] = { NAME = "uncarpet", DESC = "Undoes carpet" }
	CMDs[#CMDs + 1] = { NAME = "friend [player]", DESC = "Sends a friend request to certain players" }
	CMDs[#CMDs + 1] = { NAME = "unfriend [player]", DESC = "Unfriends certain players" }
	CMDs[#CMDs + 1] = { NAME = "headsit [player]", DESC = "Sit on a players head" }
	CMDs[#CMDs + 1] = { NAME = "walkto / follow [player]", DESC = "Follow a player" }
	CMDs[#CMDs + 1] = { NAME = "pathfindwalkto / pathfindfollow [player]", DESC = "Follow a player using pathfinding" }
	CMDs[#CMDs + 1] =
		{ NAME = "pathfindwalktowaypoint / pathfindwalktowp [waypoint]", DESC = "Walk to a waypoint using pathfinding" }
	CMDs[#CMDs + 1] = { NAME = "unwalkto / unfollow", DESC = "Stops following a player" }
	CMDs[#CMDs + 1] = {
		NAME = "orbit [player] [speed] [distance]",
		DESC = "Makes your character orbit around a player with an optional speed and an optional distance",
	}
	CMDs[#CMDs + 1] = { NAME = "unorbit", DESC = "Disables orbit" }
	CMDs[#CMDs + 1] = { NAME = "stareat / stare [player]", DESC = "Stare / look at a player" }
	CMDs[#CMDs + 1] = { NAME = "unstareat / unstare [player]", DESC = "Disables stareat" }
	CMDs[#CMDs + 1] =
		{ NAME = "rolewatch [group id] [role name]", DESC = "Notify if someone from a watched group joins the server" }
	CMDs[#CMDs + 1] = { NAME = "rolewatchstop / unrolewatch", DESC = "Disable Rolewatch" }
	CMDs[#CMDs + 1] = {
		NAME = "rolewatchleave",
		DESC = "Toggle if you should leave the game if someone from a watched group joins the server",
	}
	CMDs[#CMDs + 1] = { NAME = "staffwatch", DESC = "Notify if a staff member of the game joins the server" }
	CMDs[#CMDs + 1] = { NAME = "unstaffwatch", DESC = "Disable Staffwatch" }
	CMDs[#CMDs + 1] = { NAME = "findfriendgroups", DESC = "Notifies you if any players are friends with each other" }
	CMDs[#CMDs + 1] = {
		NAME = "handlekill / hkill [player] [radius] (TOOL)",
		DESC = "Kills a player using tool damage (YOU NEED A TOOL)",
	}
	CMDs[#CMDs + 1] = { NAME = "fling", DESC = "Flings anyone you touch" }
	CMDs[#CMDs + 1] = { NAME = "flingme / flingmyself / selffling", DESC = "Flings yourself." }
	CMDs[#CMDs + 1] = { NAME = "unfling", DESC = "Disables the fling command" }
	CMDs[#CMDs + 1] = { NAME = "flyfling [speed]", DESC = "Basically the invisfling command but not invisible" }
	CMDs[#CMDs + 1] = { NAME = "unflyfling", DESC = "Disables the flyfling command" }
	CMDs[#CMDs + 1] = { NAME = "walkfling", DESC = "Basically fling but no spinning" }
	CMDs[#CMDs + 1] = { NAME = "unwalkfling / nowalkfling", DESC = "Disables walkfling" }
	CMDs[#CMDs + 1] = {
		NAME = "invisfling",
		DESC = "Enables invisible fling (the invis part is patched, try using the god command before using this)",
	}
	CMDs[#CMDs + 1] = { NAME = "antifling", DESC = "Disables player collisions to prevent you from being flung" }
	CMDs[#CMDs + 1] = { NAME = "unantifling", DESC = "Disables antifling" }
	CMDs[#CMDs + 1] = { NAME = "loopoof", DESC = "Loops everyones character sounds (everyone can hear)" }
	CMDs[#CMDs + 1] = { NAME = "unloopoof", DESC = "Stops the oof chaos" }
	CMDs[#CMDs + 1] = { NAME = "muteboombox [player]", DESC = "Mutes someones boombox" }
	CMDs[#CMDs + 1] = { NAME = "unmuteboombox [player]", DESC = "Unmutes someones boombox" }
	CMDs[#CMDs + 1] = { NAME = "hitboxes", DESC = "Shows all rendered bounding boxes" }
	CMDs[#CMDs + 1] = { NAME = "unhitboxes", DESC = "Stops showing all rendered bounding boxes" }
	CMDs[#CMDs + 1] = {
		NAME = "hitbox [player] [size] [transparency]",
		DESC = "Expands the hitbox for players HumanoidRootPart (default is 1)",
	}
	CMDs[#CMDs + 1] =
		{ NAME = "headsize [player] [size]", DESC = "Expands the head size for players Head (default is 1)" }
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] = { NAME = "reset", DESC = "Resets your character normally" }
	CMDs[#CMDs + 1] = { NAME = "respawn", DESC = "Respawns you" }
	CMDs[#CMDs + 1] = { NAME = "refresh / re", DESC = "Respawns and brings you back to the same position" }
	CMDs[#CMDs + 1] = { NAME = "god", DESC = "Makes your character difficult to kill in most games" }
	CMDs[#CMDs + 1] = { NAME = "invisible / invis", DESC = "Makes you invisible to other players" }
	CMDs[#CMDs + 1] = { NAME = "visible / vis", DESC = "Makes you visible to other players" }
	CMDs[#CMDs + 1] = {
		NAME = "toolinvisible / toolinvis / tinvis",
		DESC = "Makes you invisible to other players and able to use tools",
	}
	CMDs[#CMDs + 1] = { NAME = "speed / ws / walkspeed [num]", DESC = "Change your walkspeed (default is 16)" }
	CMDs[#CMDs + 1] = { NAME = "spoofspeed / spoofws [num]", DESC = "Spoofs your WalkSpeed on the Client" }
	CMDs[#CMDs + 1] = { NAME = "loopspeed / loopws [num]", DESC = "Loops your walkspeed" }
	CMDs[#CMDs + 1] = { NAME = "unloopspeed / unloopws", DESC = "Turns off loopspeed" }
	CMDs[#CMDs + 1] = { NAME = "hipheight / hheight [num]", DESC = "Adjusts hip height" }
	CMDs[#CMDs + 1] = { NAME = "jumppower / jpower / jp [num]", DESC = "Change a players jump height (default is 50)" }
	CMDs[#CMDs + 1] = { NAME = "spoofjumppower / spoofjp [num]", DESC = "Spoofs your JumpPower on the Client" }
	CMDs[#CMDs + 1] = { NAME = "loopjumppower / loopjp [num]", DESC = "Loops your jump height" }
	CMDs[#CMDs + 1] = { NAME = "unloopjumppower / unloopjp", DESC = "Turns off loopjumppower" }
	CMDs[#CMDs + 1] = { NAME = "maxslopeangle / msa [num]", DESC = "Adjusts MaxSlopeAngle" }
	CMDs[#CMDs + 1] = { NAME = "gravity / grav [num] (CLIENT)", DESC = "Change your gravity" }
	CMDs[#CMDs + 1] = { NAME = "sit", DESC = "Makes your character sit" }
	CMDs[#CMDs + 1] = { NAME = "lay / laydown", DESC = "Makes your character lay down" }
	CMDs[#CMDs + 1] = { NAME = "sitwalk", DESC = "Makes your character sit while still being able to walk" }
	CMDs[#CMDs + 1] = { NAME = "nosit", DESC = "Prevents your character from sitting" }
	CMDs[#CMDs + 1] = { NAME = "unnosit", DESC = "Disables nosit" }
	CMDs[#CMDs + 1] = { NAME = "jump", DESC = "Makes your character jump" }
	CMDs[#CMDs + 1] = { NAME = "bhop / bunnyhop", DESC = "Makes your character automatically jump" }
	CMDs[#CMDs + 1] = { NAME = "unbhop / unbunnyhop", DESC = "Stops your character from automatically jumping" }
	CMDs[#CMDs + 1] = { NAME = "infinitejump / infjump", DESC = "Allows you to jump before hitting the ground" }
	CMDs[#CMDs + 1] = { NAME = "uninfinitejump / uninfjump", DESC = "Disables infjump" }
	CMDs[#CMDs + 1] = { NAME = "flyjump", DESC = "Allows you to hold space to fly up" }
	CMDs[#CMDs + 1] = { NAME = "unflyjump", DESC = "Disables flyjump" }
	CMDs[#CMDs + 1] = { NAME = "autojump / ajump", DESC = "Automatically jumps when you run into an object" }
	CMDs[#CMDs + 1] = { NAME = "unautojump / unajump", DESC = "Disables autojump" }
	CMDs[#CMDs + 1] = { NAME = "edgejump / ejump", DESC = "Automatically jumps when you get to the edge of an object" }
	CMDs[#CMDs + 1] = { NAME = "unedgejump / unejump", DESC = "Disables edgejump" }
	CMDs[#CMDs + 1] = { NAME = "platformstand / stun", DESC = "Enables PlatformStand" }
	CMDs[#CMDs + 1] = { NAME = "unplatformstand / unstun", DESC = "Disables PlatformStand" }
	CMDs[#CMDs + 1] = { NAME = "norotate / noautorotate", DESC = "Disables AutoRotate" }
	CMDs[#CMDs + 1] = { NAME = "unnorotate / autorotate", DESC = "Enables AutoRotate" }
	CMDs[#CMDs + 1] = { NAME = "enablestate [StateType]", DESC = "Enables a humanoid state type" }
	CMDs[#CMDs + 1] = { NAME = "disablestate [StateType]", DESC = "Disables a humanoid state type" }
	CMDs[#CMDs + 1] = { NAME = "team [team name] (CLIENT)", DESC = "Changes your team. Sometimes fools localscripts." }
	CMDs[#CMDs + 1] = {
		NAME = "nobillboardgui / nobgui / noname",
		DESC = "Removes billboard and surface GUIs from your players (i.e. name GUIs at cafes)",
	}
	CMDs[#CMDs + 1] = {
		NAME = "loopnobgui / loopnoname",
		DESC = "Loop removes billboard and surface GUIs from your players (i.e. name GUIs at cafes)",
	}
	CMDs[#CMDs + 1] = { NAME = "unloopnobgui / unloopnoname", DESC = "Disables loopnobgui" }
	CMDs[#CMDs + 1] = { NAME = "noarms", DESC = "Removes your arms" }
	CMDs[#CMDs + 1] = { NAME = "nolegs", DESC = "Removes your legs" }
	CMDs[#CMDs + 1] = { NAME = "nolimbs", DESC = "Removes your limbs" }
	CMDs[#CMDs + 1] = { NAME = "naked (CLIENT)", DESC = "Removes your clothing" }
	CMDs[#CMDs + 1] = { NAME = "noface / removeface", DESC = "Removes your face" }
	CMDs[#CMDs + 1] = { NAME = "blockhead", DESC = "Turns your head into a block" }
	CMDs[#CMDs + 1] = { NAME = "blockhats", DESC = "Turns your hats into blocks" }
	CMDs[#CMDs + 1] = { NAME = "blocktool", DESC = "Turns the currently selected tool into a block" }
	CMDs[#CMDs + 1] = { NAME = "creeper", DESC = "Makes you look like a creeper" }
	CMDs[#CMDs + 1] = { NAME = "drophats", DESC = "Drops your hats" }
	CMDs[#CMDs + 1] = { NAME = "nohats / deletehats / rhats", DESC = "Deletes your hats" }
	CMDs[#CMDs + 1] = { NAME = "hatspin / spinhats", DESC = "Spins your characters accessories" }
	CMDs[#CMDs + 1] = { NAME = "unhatspin / unspinhats", DESC = "Undoes spinhats" }
	CMDs[#CMDs + 1] = { NAME = "clearhats / cleanhats", DESC = "Clears hats in the workspace" }
	CMDs[#CMDs + 1] =
		{ NAME = "chardelete / cd [instance name]", DESC = "Removes any part with a certain name from your character" }
	CMDs[#CMDs + 1] = {
		NAME = "chardeleteclass / cdc [class name]",
		DESC = "Removes any part with a certain classname from your character",
	}
	CMDs[#CMDs + 1] = {
		NAME = "deletevelocity / dv / removeforces",
		DESC = "Removes any velocity / force instances in your character",
	}
	CMDs[#CMDs + 1] = { NAME = "weaken [num]", DESC = "Makes your character less dense" }
	CMDs[#CMDs + 1] = { NAME = "unweaken", DESC = "Sets your characters CustomPhysicalProperties to default" }
	CMDs[#CMDs + 1] = { NAME = "strengthen [num]", DESC = "Makes your character more dense (CustomPhysicalProperties)" }
	CMDs[#CMDs + 1] = { NAME = "unstrengthen", DESC = "Sets your characters CustomPhysicalProperties to default" }
	CMDs[#CMDs + 1] = { NAME = "breakvelocity", DESC = "Sets your characters velocity to 0" }
	CMDs[#CMDs + 1] = { NAME = "spin [speed]", DESC = "Spins your character" }
	CMDs[#CMDs + 1] = { NAME = "unspin", DESC = "Disables spin" }
	CMDs[#CMDs + 1] = { NAME = "split", DESC = "Splits your character in half" }
	CMDs[#CMDs + 1] = { NAME = "nilchar", DESC = "Sets your characters parent to nil" }
	CMDs[#CMDs + 1] = { NAME = "unnilchar / nonilchar", DESC = "Sets your characters parent to workspace" }
	CMDs[#CMDs + 1] = { NAME = "noroot / removeroot / rroot", DESC = "Removes your characters HumanoidRootPart" }
	CMDs[#CMDs + 1] = { NAME = "replaceroot", DESC = "Replaces your characters HumanoidRootPart" }
	CMDs[#CMDs + 1] = {
		NAME = "clearcharappearance / clearchar / clrchar",
		DESC = "Removes all accessory, shirt, pants, charactermesh, and bodycolors",
	}
	CMDs[#CMDs + 1] = { NAME = "tpwalk / teleportwalk [num]", DESC = "Teleports you to your move direction" }
	CMDs[#CMDs + 1] = { NAME = "untpwalk / unteleportwalk", DESC = "Undoes tpwalk / teleportwalk" }
	CMDs[#CMDs + 1] = { NAME = "trip", DESC = "Makes your character fall over" }
	CMDs[#CMDs + 1] = { NAME = "wallwalk / walkonwalls", DESC = "Walk on walls" }
	CMDs[#CMDs + 1] = { NAME = "promptr6", DESC = "Prompts the game to switch your rig type to R6" }
	CMDs[#CMDs + 1] = { NAME = "promptr15", DESC = "Prompts the game to switch your rig type to R15" }
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] = {
		NAME = "animation / anim [ID] [speed]",
		DESC = "Makes your character perform an animation (must be an animation on the marketplace or by roblox/stickmasterluke to replicate)",
	}
	CMDs[#CMDs + 1] = {
		NAME = "emote / em [ID] [speed]",
		DESC = "Makes your character perform an emote (must be on the marketplace or by roblox/stickmasterluke to replicate)",
	}
	CMDs[#CMDs + 1] = { NAME = "dance", DESC = "Makes you  d a n c e" }
	CMDs[#CMDs + 1] = { NAME = "undance", DESC = "Stops dance animations" }
	CMDs[#CMDs + 1] = { NAME = "spasm", DESC = "Makes you  c r a z y" }
	CMDs[#CMDs + 1] = { NAME = "unspasm", DESC = "Stops spasm" }
	CMDs[#CMDs + 1] = { NAME = "headthrow", DESC = "Simply makes you throw your head" }
	CMDs[#CMDs + 1] = { NAME = "noanim", DESC = "Disables your animations" }
	CMDs[#CMDs + 1] = { NAME = "reanim", DESC = "Restores your animations" }
	CMDs[#CMDs + 1] = { NAME = "animspeed [num]", DESC = "Changes the speed of your current animation" }
	CMDs[#CMDs + 1] =
		{ NAME = "copyanimation / copyanim / copyemote [player]", DESC = "Copies someone elses animation" }
	CMDs[#CMDs + 1] = {
		NAME = "copyanimationid / copyanimid / copyemoteid [player]",
		DESC = "Copies your animation id or someone elses to your clipboard",
	}
	CMDs[#CMDs + 1] = { NAME = "loopanimation / loopanim", DESC = "Loops your current animation" }
	CMDs[#CMDs + 1] = { NAME = "stopanimations / stopanims", DESC = "Stops running animations" }
	CMDs[#CMDs + 1] = { NAME = "refreshanimations / refreshanims", DESC = "Refreshes animations" }
	CMDs[#CMDs + 1] =
		{ NAME = "allowcustomanim / allowcustomanimations", DESC = "Lets you use custom animation packs instead" }
	CMDs[#CMDs + 1] = {
		NAME = "unallowcustomanim / unallowcustomanimations",
		DESC = "Doesn't let you use custom animation packs instead",
	}
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] =
		{ NAME = "autoclick [click delay] [release delay]", DESC = "Automatically clicks your mouse with a set delay" }
	CMDs[#CMDs + 1] = { NAME = "unautoclick / noautoclick", DESC = "Turns off autoclick" }
	CMDs[#CMDs + 1] =
		{ NAME = "autokeypress [key] [down delay] [up delay]", DESC = "Automatically presses a key with a set delay" }
	CMDs[#CMDs + 1] = { NAME = "unautokeypress", DESC = "Stops autokeypress" }
	CMDs[#CMDs + 1] = { NAME = "hovername", DESC = "Shows a players username when your mouse is hovered over them" }
	CMDs[#CMDs + 1] = { NAME = "unhovername / nohovername", DESC = "Turns off hovername" }
	CMDs[#CMDs + 1] = {
		NAME = "mousesensitivity / ms [0-10]",
		DESC = "Sets your mouse sensitivity (affects first person and right click drag) (default is 1)",
	}
	CMDs[#CMDs + 1] = { NAME = "clickdelete", DESC = "Go to Settings > Keybinds > Add for click delete" }
	CMDs[#CMDs + 1] = { NAME = "clickteleport", DESC = "Go to Settings > Keybinds > Add for click teleport" }
	CMDs[#CMDs + 1] = {
		NAME = "mouseteleport / mousetp",
		DESC = "Teleports your character to your mouse. This is recommended as a keybind",
	}
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] = { NAME = "tools", DESC = "Copies tools from ReplicatedStorage and Lighting" }
	CMDs[#CMDs + 1] =
		{ NAME = "notools / removetools / deletetools", DESC = "Removes tools from character and backpack" }
	CMDs[#CMDs + 1] = { NAME = "deleteselectedtool / dst", DESC = "Removes any currently selected tools" }
	CMDs[#CMDs + 1] = { NAME = "grabtools", DESC = "Automatically get tools that are dropped" }
	CMDs[#CMDs + 1] = { NAME = "ungrabtools / nograbtools", DESC = "Disables grabtools" }
	CMDs[#CMDs + 1] = { NAME = "copytools [player] (CLIENT)", DESC = "Copies a players tools" }
	CMDs[#CMDs + 1] =
		{ NAME = "dupetools / clonetools [num]", DESC = "Duplicates your inventory tools a set amount of times" }
	CMDs[#CMDs + 1] = { NAME = "droptools", DESC = "Drops your tools" }
	CMDs[#CMDs + 1] = { NAME = "droppabletools", DESC = "Makes your tools droppable" }
	CMDs[#CMDs + 1] = { NAME = "equiptools", DESC = "Equips every tool in your inventory at once" }
	CMDs[#CMDs + 1] = { NAME = "unequiptools", DESC = "Unequips every tool you are currently holding at once" }
	CMDs[#CMDs + 1] =
		{ NAME = "removespecifictool [name]", DESC = "Automatically remove a specific tool from your inventory" }
	CMDs[#CMDs + 1] =
		{ NAME = "unremovespecifictool [name]", DESC = "Stops removing a specific tool from your inventory" }
	CMDs[#CMDs + 1] =
		{ NAME = "clearremovespecifictool", DESC = "Stop removing all specific tools from your inventory" }
	CMDs[#CMDs + 1] = { NAME = "reach [num]", DESC = "Increases the hitbox of your held tool" }
	CMDs[#CMDs + 1] = { NAME = "boxreach [num]", DESC = "Increases the hitbox of your held tool in a box shape" }
	CMDs[#CMDs + 1] = { NAME = "unreach / noreach", DESC = "Turns off reach" }
	CMDs[#CMDs + 1] = { NAME = "grippos [X Y Z]", DESC = "Changes your current tools grip position" }
	CMDs[#CMDs + 1] =
		{ NAME = "usetools [amount] [delay]", DESC = "Activates all tools in your backpack at the same time" }
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] = { NAME = "addalias [cmd] [alias]", DESC = "Adds an alias to a command" }
	CMDs[#CMDs + 1] = { NAME = "removealias [alias]", DESC = "Removes a custom alias" }
	CMDs[#CMDs + 1] = { NAME = "clraliases", DESC = "Removes all custom aliases" }
	CMDs[#CMDs + 1] = { NAME = "", DESC = "" }
	CMDs[#CMDs + 1] = { NAME = "addplugin / plugin [name]", DESC = "Add a plugin via command" }
	CMDs[#CMDs + 1] = { NAME = "removeplugin / deleteplugin [name]", DESC = "Remove a plugin via command" }
	CMDs[#CMDs + 1] = { NAME = "reloadplugin [name]", DESC = "Reloads a plugin" }
	CMDs[#CMDs + 1] =
		{ NAME = "addallplugins / loadallplugins", DESC = "Adds all available plugins from the workspace folder" }
	-- task.wait()

	for i = 1, #CMDs do
		local newcmd = Example:Clone()
		newcmd.Parent = CMDsF
		newcmd.Visible = false
		newcmd.Text = CMDs[i].NAME
		newcmd.Name = "CMD"
		table.insert(text1, newcmd)
		if CMDs[i].DESC ~= "" then
			newcmd:SetAttribute("Title", CMDs[i].NAME)
			newcmd:SetAttribute("Desc", CMDs[i].DESC)
			newcmd.MouseButton1Down:Connect(function()
				if not IsOnMobile and newcmd.Visible and newcmd.TextTransparency == 0 then
					local currentText = Cmdbar.Text
					Cmdbar:CaptureFocus()
					autoComplete(newcmd.Text, currentText)
					maximizeHolder()
				end
			end)
		end
	end

	IndexContents("", true)

	function checkTT()
		local t
		local guisAtPosition = COREGUI:GetGuiObjectsAtPosition(ZYMouse.X, ZYMouse.Y)

		for _, gui in pairs(guisAtPosition) do
			if gui.Parent == CMDsF then
				t = gui
			end
		end

		if t ~= nil and t:GetAttribute("Title") ~= nil then
			local x = ZYMouse.X
			local y = ZYMouse.Y
			local xP
			local yP
			if ZYMouse.X > 200 then
				xP = x - 201
			else
				xP = x + 21
			end
			if ZYMouse.Y > (ZYMouse.ViewSizeY - 96) then
				yP = y - 97
			else
				yP = y
			end
			Tooltip.Position = UDim2.new(0, xP, 0, yP)
			Description.Text = t:GetAttribute("Desc")
			if t:GetAttribute("Title") ~= nil then
				Title_3.Text = t:GetAttribute("Title")
			else
				Title_3.Text = ""
			end
			Tooltip.Visible = true
		else
			Tooltip.Visible = false
		end
	end

	cmdHistory = {}
	local lastCmds = {}
	local historyCount = 0
	local split = " "
	local lastBreakTime = 0
	function execCmd(cmdStr, speaker, store)
		cmdStr = cmdStr:gsub("%s+$", "")
		task.spawn(function()
			local rawCmdStr = cmdStr
			cmdStr = string.gsub(cmdStr, "\\\\", "%%BackSlash%%")
			local commandsToRun = splitString(cmdStr, "\\")
			for i, v in pairs(commandsToRun) do
				v = string.gsub(v, "%%BackSlash%%", "\\")
				local x, y, num = v:find("^(%d+)%^")
				local cmdDelay = 0
				local infTimes = false
				if num then
					v = v:sub(y + 1)
					local x, y, del = v:find("^([%d%.]+)%^")
					if del then
						v = v:sub(y + 1)
						cmdDelay = tonumber(del) or 0
					end
				else
					local x, y = v:find("^inf%^")
					if x then
						infTimes = true
						v = v:sub(y + 1)
						local x, y, del = v:find("^([%d%.]+)%^")
						if del then
							v = v:sub(y + 1)
							del = tonumber(del) or 1
							cmdDelay = (del > 0 and del or 1)
						else
							cmdDelay = 1
						end
					end
				end
				num = tonumber(num or 1)

				if v:sub(1, 1) == "!" then
					local chunks = splitString(v:sub(2), split)
					if chunks[1] and lastCmds[chunks[1]] then
						v = lastCmds[chunks[1]]
					end
				end

				local args = splitString(v, split)
				local cmdName = args[1]
				local cmd = findCmd(cmdName)
				if cmd then
					table.remove(args, 1)
					cargs = args
					if not speaker then
						speaker = Players.LocalPlayer
					end
					if store then
						if speaker == Players.LocalPlayer then
							if
								cmdHistory[1] ~= rawCmdStr
								and rawCmdStr:sub(1, 11) ~= "lastcommand"
								and rawCmdStr:sub(1, 7) ~= "lastcmd"
							then
								table.insert(cmdHistory, 1, rawCmdStr)
							end
						end
						if #cmdHistory > 30 then
							table.remove(cmdHistory)
						end

						lastCmds[cmdName] = v
					end
					local cmdStartTime = os.clock()
					if infTimes then
						while lastBreakTime < cmdStartTime do
							local success, err = pcall(cmd.FUNC, args, speaker)
							if not success and _G.ZY_DEBUG then
								warn("Command Error:", cmdName, err)
							end
							task.wait(cmdDelay)
						end
					else
						for rep = 1, num do
							if lastBreakTime > cmdStartTime then
								break
							end
							local success, err = pcall(function()
								cmd.FUNC(args, speaker)
							end)
							if not success and _G.ZY_DEBUG then
								warn("Command Error:", cmdName, err)
							end
							if cmdDelay ~= 0 then
								task.wait(cmdDelay)
							end
						end
					end
				end
			end
		end)
	end

	function addcmd(name, alias, func, plgn)
		cmds[#cmds + 1] = {
			NAME = name,
			ALIAS = alias or {},
			FUNC = func,
			PLUGIN = plgn,
		}
	end

	function removecmd(cmd)
		if cmd ~= " " then
			for i = #cmds, 1, -1 do
				if cmds[i].NAME == cmd or FindInTable(cmds[i].ALIAS, cmd) then
					table.remove(cmds, i)
					for a, c in pairs(CMDsF:GetChildren()) do
						if
							string.find(c.Text, "^" .. cmd .. "$")
							or string.find(c.Text, "^" .. cmd .. " ")
							or string.find(c.Text, " " .. cmd .. "$")
							or string.find(c.Text, " " .. cmd .. " ")
						then
							c.TextTransparency = 0.7
							c.MouseButton1Click:Connect(function()
								notify(c.Text, "Command has been disabled by you or a plugin")
							end)
						end
					end
				end
			end
		end
	end

	function overridecmd(name, func)
		local cmd = findCmd(name)
		if cmd and cmd.FUNC then
			cmd.FUNC = func
		end
	end

	function addbind(cmd, key, iskeyup, toggle)
		if toggle then
			binds[#binds + 1] = {
				COMMAND = cmd,
				KEY = key,
				ISKEYUP = iskeyup,
				TOGGLE = toggle,
			}
		else
			binds[#binds + 1] = {
				COMMAND = cmd,
				KEY = key,
				ISKEYUP = iskeyup,
			}
		end
	end

	function addcmdtext(text, name, desc)
		local newcmd = Example:Clone()
		local tooltipText = tostring(text)
		local tooltipDesc = tostring(desc)
		newcmd.Parent = CMDsF
		newcmd.Visible = false
		newcmd.Text = text
		newcmd.Name = "PLUGIN_" .. name
		table.insert(text1, newcmd)
		if desc and desc ~= "" then
			newcmd:SetAttribute("Title", tooltipText)
			newcmd:SetAttribute("Desc", tooltipDesc)
			newcmd.MouseButton1Down:Connect(function()
				if newcmd.Visible and newcmd.TextTransparency == 0 then
					Cmdbar:CaptureFocus()
					autoComplete(newcmd.Text)
					maximizeHolder()
				end
			end)
		end
	end

	return env
end
