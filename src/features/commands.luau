return function(env)
	addcmd("addalias", {}, function(args, speaker)
		if #args < 2 then
			return
		end
		local cmd = string.lower(args[1])
		local alias = string.lower(args[2])
		for i, v in pairs(cmds) do
			if v.NAME:lower() == cmd or FindInTable(v.ALIAS, cmd) then
				customAlias[alias] = v
				aliases[#aliases + 1] = { CMD = cmd, ALIAS = alias }
				notify("Aliases Modified", "Added " .. alias .. " as an alias to " .. cmd)
				updatesaves()
				refreshaliases()
				break
			end
		end
	end)

	addcmd("removealias", {}, function(args, speaker)
		if #args < 1 then
			return
		end
		local alias = string.lower(args[1])
		if customAlias[alias] then
			local cmd = customAlias[alias].NAME
			customAlias[alias] = nil
			for i = #aliases, 1, -1 do
				if aliases[i].ALIAS == tostring(alias) then
					table.remove(aliases, i)
				end
			end
			notify("Aliases Modified", "Removed the alias " .. alias .. " from " .. cmd)
			updatesaves()
			refreshaliases()
		end
	end)

	addcmd("clraliases", {}, function(args, speaker)
		customAlias = {}
		aliases = {}
		notify("Aliases Modified", "Removed all aliases")
		updatesaves()
		refreshaliases()
	end)

	addcmd("discord", { "support", "help" }, function(args, speaker)
		if everyClipboard then
			toClipboard("https://discord.com/invite/sc5tfyEUqD")
			notify("Discord Invite", "Copied to clipboard!\ndiscord.gg/sc5tfyEUqD")
		else
			notify("Discord Invite", "discord.gg/sc5tfyEUqD")
		end
		if httprequest then
			httprequest({
				Url = "http://127.0.0.1:6463/rpc?v=1",
				Method = "POST",
				Headers = {
					["Content-Type"] = "application/json",
					Origin = "https://discord.com",
				},
				Body = HttpService:JSONEncode({
					cmd = "INVITE_BROWSER",
					nonce = HttpService:GenerateGUID(false),
					args = { code = "sc5tfyEUqD" },
				}),
			})
		end
	end)

	addcmd("unc", { "unctest" }, function(args, speaker)
		notify("Loading", "Hold on a sec. Please check the console for results.")

		loadstring(
			game:HttpGet(
				"https://raw.githubusercontent.com/unified-naming-convention/NamingStandard/refs/heads/main/UNCCheckEnv.lua"
			)
		)()
	end)

	addcmd("sunc", { "sunctest" }, function(args, speaker)
		notify("Loading", "Hold on a sec. Please check the console for results.")

		if not getgenv then
			notify("Incompatible Exploit", "Your executor cannot run the sUNC test suite. (missing getgenv)")
			return
		end

		getgenv().sUNCDebug = {
			printcheckpoints = false,
			delaybetweentests = 0,
			printtesttimetaken = false,
		}

		loadstring(game:HttpGet("https://script.sunc.su/"))()
	end)

	addcmd("keepzy", {}, function(args, speaker)
		if queueteleport then
			KeepInfYield = true
			notify("KeepZY", "Zero Yield will now run after you teleport")
			updatesaves()
		else
			notify("Incompatible Exploit", "Your exploit does not support this command (missing queue_on_teleport)")
		end
	end)

	addcmd("unkeepzy", {}, function(args, speaker)
		if queueteleport then
			KeepInfYield = false
			notify("KeepZY", "Zero Yield will no longer run after you teleport")
			updatesaves()
		else
			notify("Incompatible Exploit", "Your exploit does not support this command (missing queue_on_teleport)")
		end
	end)

	addcmd("togglekeepzy", {}, function(args, speaker)
		if queueteleport then
			KeepInfYield = not KeepInfYield
			updatesaves()
		else
			notify("Incompatible Exploit", "Your exploit does not support this command (missing queue_on_teleport)")
		end
	end)

	local canOpenServerinfo = true
	addcmd("serverinfo", { "info", "sinfo" }, function(args, speaker)
		if not canOpenServerinfo then
			return
		end
		canOpenServerinfo = false
		task.spawn(function()
			local FRAME = Instance.new("Frame")
			local shadow = Instance.new("Frame")
			local PopupText = Instance.new("TextLabel")
			local Exit = Instance.new("TextButton")
			local ExitImage = Instance.new("ImageLabel")
			local background = Instance.new("Frame")
			local TextLabel = Instance.new("TextLabel")
			local TextLabel2 = Instance.new("TextLabel")
			local TextLabel3 = Instance.new("TextLabel")
			local Time = Instance.new("TextLabel")
			local appearance = Instance.new("TextLabel")
			local maxplayers = Instance.new("TextLabel")
			local name = Instance.new("TextLabel")
			local placeid = Instance.new("TextLabel")
			local playerid = Instance.new("TextLabel")
			local players = Instance.new("TextLabel")
			local CopyApp = Instance.new("TextButton")
			local CopyPlrID = Instance.new("TextButton")
			local CopyPlcID = Instance.new("TextButton")
			local CopyPlcName = Instance.new("TextButton")

			FRAME.Name = randomString()
			FRAME.Parent = ScaledHolder
			FRAME.Active = true
			FRAME.BackgroundTransparency = 1
			FRAME.Position = UDim2.new(0.5, -130, 0, -500)
			FRAME.Size = UDim2.new(0, 250, 0, 20)
			FRAME.ZIndex = 10
			dragGUI(FRAME)

			shadow.Name = "shadow"
			shadow.Parent = FRAME
			shadow.BackgroundColor3 = currentShade2
			shadow.BorderSizePixel = 0
			shadow.Size = UDim2.new(0, 250, 0, 20)
			shadow.ZIndex = 10
			table.insert(shade2, shadow)

			PopupText.Name = "PopupText"
			PopupText.Parent = shadow
			PopupText.BackgroundTransparency = 1
			PopupText.Size = UDim2.new(1, 0, 0.95, 0)
			PopupText.ZIndex = 10
			PopupText.Font = Enum.Font.SourceSans
			PopupText.TextSize = 14
			PopupText.Text = "Server"
			PopupText.TextColor3 = currentText1
			PopupText.TextWrapped = true
			table.insert(text1, PopupText)

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

			background.Name = "background"
			background.Parent = FRAME
			background.Active = true
			background.BackgroundColor3 = currentShade1
			background.BorderSizePixel = 0
			background.Position = UDim2.new(0, 0, 1, 0)
			background.Size = UDim2.new(0, 250, 0, 250)
			background.ZIndex = 10
			table.insert(shade1, background)

			TextLabel.Name = "Text Label"
			TextLabel.Parent = background
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderSizePixel = 0
			TextLabel.Position = UDim2.new(0, 5, 0, 80)
			TextLabel.Size = UDim2.new(0, 100, 0, 20)
			TextLabel.ZIndex = 10
			TextLabel.Font = Enum.Font.SourceSansLight
			TextLabel.TextSize = 20
			TextLabel.Text = "Run Time:"
			TextLabel.TextColor3 = currentText1
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			table.insert(text1, TextLabel)

			TextLabel2.Name = "Text Label2"
			TextLabel2.Parent = background
			TextLabel2.BackgroundTransparency = 1
			TextLabel2.BorderSizePixel = 0
			TextLabel2.Position = UDim2.new(0, 5, 0, 130)
			TextLabel2.Size = UDim2.new(0, 100, 0, 20)
			TextLabel2.ZIndex = 10
			TextLabel2.Font = Enum.Font.SourceSansLight
			TextLabel2.TextSize = 20
			TextLabel2.Text = "Statistics:"
			TextLabel2.TextColor3 = currentText1
			TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
			table.insert(text1, TextLabel2)

			TextLabel3.Name = "Text Label3"
			TextLabel3.Parent = background
			TextLabel3.BackgroundTransparency = 1
			TextLabel3.BorderSizePixel = 0
			TextLabel3.Position = UDim2.new(0, 5, 0, 10)
			TextLabel3.Size = UDim2.new(0, 100, 0, 20)
			TextLabel3.ZIndex = 10
			TextLabel3.Font = Enum.Font.SourceSansLight
			TextLabel3.TextSize = 20
			TextLabel3.Text = "Local Player:"
			TextLabel3.TextColor3 = currentText1
			TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
			table.insert(text1, TextLabel3)

			Time.Name = "Time"
			Time.Parent = background
			Time.BackgroundTransparency = 1
			Time.BorderSizePixel = 0
			Time.Position = UDim2.new(0, 5, 0, 105)
			Time.Size = UDim2.new(0, 100, 0, 20)
			Time.ZIndex = 10
			Time.Font = Enum.Font.SourceSans
			Time.FontSize = Enum.FontSize.Size14
			Time.Text = "LOADING"
			Time.TextColor3 = currentText1
			Time.TextXAlignment = Enum.TextXAlignment.Left
			table.insert(text1, Time)

			appearance.Name = "appearance"
			appearance.Parent = background
			appearance.BackgroundTransparency = 1
			appearance.BorderSizePixel = 0
			appearance.Position = UDim2.new(0, 5, 0, 55)
			appearance.Size = UDim2.new(0, 100, 0, 20)
			appearance.ZIndex = 10
			appearance.Font = Enum.Font.SourceSans
			appearance.FontSize = Enum.FontSize.Size14
			appearance.Text = "Appearance: LOADING"
			appearance.TextColor3 = currentText1
			appearance.TextXAlignment = Enum.TextXAlignment.Left
			table.insert(text1, appearance)

			maxplayers.Name = "maxplayers"
			maxplayers.Parent = background
			maxplayers.BackgroundTransparency = 1
			maxplayers.BorderSizePixel = 0
			maxplayers.Position = UDim2.new(0, 5, 0, 175)
			maxplayers.Size = UDim2.new(0, 100, 0, 20)
			maxplayers.ZIndex = 10
			maxplayers.Font = Enum.Font.SourceSans
			maxplayers.FontSize = Enum.FontSize.Size14
			maxplayers.Text = "LOADING"
			maxplayers.TextColor3 = currentText1
			maxplayers.TextXAlignment = Enum.TextXAlignment.Left
			table.insert(text1, maxplayers)

			name.Name = "name"
			name.Parent = background
			name.BackgroundTransparency = 1
			name.BorderSizePixel = 0
			name.Position = UDim2.new(0, 5, 0, 215)
			name.Size = UDim2.new(0, 240, 0, 30)
			name.ZIndex = 10
			name.Font = Enum.Font.SourceSans
			name.FontSize = Enum.FontSize.Size14
			name.Text = "Place Name: LOADING"
			name.TextColor3 = currentText1
			name.TextWrapped = true
			name.TextXAlignment = Enum.TextXAlignment.Left
			name.TextYAlignment = Enum.TextYAlignment.Top
			table.insert(text1, name)

			placeid.Name = "placeid"
			placeid.Parent = background
			placeid.BackgroundTransparency = 1
			placeid.BorderSizePixel = 0
			placeid.Position = UDim2.new(0, 5, 0, 195)
			placeid.Size = UDim2.new(0, 100, 0, 20)
			placeid.ZIndex = 10
			placeid.Font = Enum.Font.SourceSans
			placeid.FontSize = Enum.FontSize.Size14
			placeid.Text = "Place ID: LOADING"
			placeid.TextColor3 = currentText1
			placeid.TextXAlignment = Enum.TextXAlignment.Left
			table.insert(text1, placeid)

			playerid.Name = "playerid"
			playerid.Parent = background
			playerid.BackgroundTransparency = 1
			playerid.BorderSizePixel = 0
			playerid.Position = UDim2.new(0, 5, 0, 35)
			playerid.Size = UDim2.new(0, 100, 0, 20)
			playerid.ZIndex = 10
			playerid.Font = Enum.Font.SourceSans
			playerid.FontSize = Enum.FontSize.Size14
			playerid.Text = "Player ID: LOADING"
			playerid.TextColor3 = currentText1
			playerid.TextXAlignment = Enum.TextXAlignment.Left
			table.insert(text1, playerid)

			players.Name = "players"
			players.Parent = background
			players.BackgroundTransparency = 1
			players.BorderSizePixel = 0
			players.Position = UDim2.new(0, 5, 0, 155)
			players.Size = UDim2.new(0, 100, 0, 20)
			players.ZIndex = 10
			players.Font = Enum.Font.SourceSans
			players.FontSize = Enum.FontSize.Size14
			players.Text = "LOADING"
			players.TextColor3 = currentText1
			players.TextXAlignment = Enum.TextXAlignment.Left
			table.insert(text1, players)

			CopyApp.Name = "CopyApp"
			CopyApp.Parent = background
			CopyApp.BackgroundColor3 = currentShade2
			CopyApp.BorderSizePixel = 0
			CopyApp.Position = UDim2.new(0, 210, 0, 55)
			CopyApp.Size = UDim2.new(0, 35, 0, 20)
			CopyApp.Font = Enum.Font.SourceSans
			CopyApp.TextSize = 14
			CopyApp.Text = "Copy"
			CopyApp.TextColor3 = currentText1
			CopyApp.ZIndex = 10
			table.insert(shade2, CopyApp)
			table.insert(text1, CopyApp)

			CopyPlrID.Name = "CopyPlrID"
			CopyPlrID.Parent = background
			CopyPlrID.BackgroundColor3 = currentShade2
			CopyPlrID.BorderSizePixel = 0
			CopyPlrID.Position = UDim2.new(0, 210, 0, 35)
			CopyPlrID.Size = UDim2.new(0, 35, 0, 20)
			CopyPlrID.Font = Enum.Font.SourceSans
			CopyPlrID.TextSize = 14
			CopyPlrID.Text = "Copy"
			CopyPlrID.TextColor3 = currentText1
			CopyPlrID.ZIndex = 10
			table.insert(shade2, CopyPlrID)
			table.insert(text1, CopyPlrID)

			CopyPlcID.Name = "CopyPlcID"
			CopyPlcID.Parent = background
			CopyPlcID.BackgroundColor3 = currentShade2
			CopyPlcID.BorderSizePixel = 0
			CopyPlcID.Position = UDim2.new(0, 210, 0, 195)
			CopyPlcID.Size = UDim2.new(0, 35, 0, 20)
			CopyPlcID.Font = Enum.Font.SourceSans
			CopyPlcID.TextSize = 14
			CopyPlcID.Text = "Copy"
			CopyPlcID.TextColor3 = currentText1
			CopyPlcID.ZIndex = 10
			table.insert(shade2, CopyPlcID)
			table.insert(text1, CopyPlcID)

			CopyPlcName.Name = "CopyPlcName"
			CopyPlcName.Parent = background
			CopyPlcName.BackgroundColor3 = currentShade2
			CopyPlcName.BorderSizePixel = 0
			CopyPlcName.Position = UDim2.new(0, 210, 0, 215)
			CopyPlcName.Size = UDim2.new(0, 35, 0, 20)
			CopyPlcName.Font = Enum.Font.SourceSans
			CopyPlcName.TextSize = 14
			CopyPlcName.Text = "Copy"
			CopyPlcName.TextColor3 = currentText1
			CopyPlcName.ZIndex = 10
			table.insert(shade2, CopyPlcName)
			table.insert(text1, CopyPlcName)

			local SINFOGUI = background
			FRAME:TweenPosition(UDim2.new(0.5, -130, 0, 100), "InOut", "Quart", 0.5, true, nil)
			wait(0.5)
			Exit.MouseButton1Click:Connect(function()
				FRAME:TweenPosition(UDim2.new(0.5, -130, 0, -500), "InOut", "Quart", 0.5, true, nil)
				wait(0.6)
				FRAME:Destroy()
				canOpenServerinfo = true
			end)
			local Asset = MarketplaceService:GetProductInfo(PlaceId)
			SINFOGUI.name.Text = "Place Name: " .. Asset.Name
			SINFOGUI.playerid.Text = "Player ID: " .. speaker.UserId
			SINFOGUI.maxplayers.Text = Players.MaxPlayers .. " Players Max"
			SINFOGUI.placeid.Text = "Place ID: " .. PlaceId

			CopyApp.MouseButton1Click:Connect(function()
				toClipboard(speaker.CharacterAppearanceId)
			end)
			CopyPlrID.MouseButton1Click:Connect(function()
				toClipboard(speaker.UserId)
			end)
			CopyPlcID.MouseButton1Click:Connect(function()
				toClipboard(PlaceId)
			end)
			CopyPlcName.MouseButton1Click:Connect(function()
				toClipboard(Asset.Name)
			end)

			repeat
				players = Players:GetPlayers()
				SINFOGUI.players.Text = #players .. " Player(s)"
				SINFOGUI.appearance.Text = "Appearance: " .. speaker.CharacterAppearanceId
				local seconds = math.floor(workspace.DistributedGameTime)
				local minutes = math.floor(workspace.DistributedGameTime / 60)
				local hours = math.floor(workspace.DistributedGameTime / 60 / 60)
				local seconds = seconds - (minutes * 60)
				local minutes = minutes - (hours * 60)
				if hours < 1 then
					if minutes < 1 then
						SINFOGUI.Time.Text = seconds .. " Second(s)"
					else
						SINFOGUI.Time.Text = minutes .. " Minute(s), " .. seconds .. " Second(s)"
					end
				else
					SINFOGUI.Time.Text = hours .. " Hour(s), " .. minutes .. " Minute(s), " .. seconds .. " Second(s)"
				end
				wait(1)
			until SINFOGUI.Parent == nil
		end)
	end)

	addcmd("jobid", {}, function(args, speaker)
		toClipboard("roblox://placeId=" .. PlaceId .. "&gameInstanceId=" .. JobId)
	end)

	addcmd("notifyjobid", {}, function(args, speaker)
		notify("JobId / PlaceId", JobId .. " / " .. PlaceId)
	end)

	addcmd("breakloops", { "break" }, function(args, speaker)
		lastBreakTime = tick()
	end)

	addcmd("gametp", { "gameteleport" }, function(args, speaker)
		TeleportService:Teleport(args[1])
	end)

	teleportRespawnHandler = [[
local ok, data = pcall(function() return game:GetService("TeleportService"):GetLocalPlayerTeleportData() end)
if ok and typeof(data) == "CFrame" then
    local Players = game:GetService("Players")
    local ME = Players.LocalPlayer
    while not ME do
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        ME = Players.LocalPlayer
    end

    local Character = ME.Character or ME.CharacterAdded:Wait()
    Character:WaitForChild("HumanoidRootPart")

    local t = tick()
    while (tick() - t) <= 0.3 do
        Character:PivotTo(data)
        task.wait()
    end
end
]]
	addcmd("rejoin", { "rj" }, function(args, speaker)
		local data = nil
		if parseBoolean(args[1], false) == true then
			if queueteleport then
				if speaker.Character then
					data = speaker.Character:GetPivot()
					queueteleport(teleportRespawnHandler)
				end
			else
				notify(
					"Incompatible Exploit",
					"Your exploit does not support this argument (missing queue_on_teleport)"
				)
			end
		end

		if #Players:GetPlayers() <= 1 then
			Players.LocalPlayer:Kick("\nRejoining...")
			task.wait(0.3)
			TeleportService:Teleport(PlaceId, Players.LocalPlayer, data)
		else
			TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer, nil, data)
		end
	end)

	addcmd("inviteprompt", {}, function(args, speaker)
		local plrs = getPlayer(args[1], speaker)
		if #plrs > 0 then
			ExperienceService:LaunchExperience({
				placeId = PlaceId,
				gameInstanceId = JobId,
				referredByPlayerId = plr[1].UserId,
			})
		end
	end)

	addcmd("autorejoin", { "autorj" }, function(args, speaker)
		GuiService.ErrorMessageChanged:Connect(function()
			execCmd("rejoin")
		end)
		notify("Auto Rejoin", "Auto rejoin enabled")
	end)

	addcmd("serverhop", { "shop" }, function(args, speaker)
		-- thanks to Amity for fixing
		local servers = {}
		local req = game:HttpGet(
			"https://games.roblox.com/v1/games/"
				.. PlaceId
				.. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true"
		)
		local body = HttpService:JSONDecode(req)

		if body and body.data then
			for i, v in next, body.data do
				if
					type(v) == "table"
					and tonumber(v.playing)
					and tonumber(v.maxPlayers)
					and v.playing < v.maxPlayers
					and v.id ~= JobId
				then
					table.insert(servers, 1, v.id)
				end
			end
		end

		if #servers > 0 then
			TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], Players.LocalPlayer)
		else
			return notify("Serverhop", "Couldn't find a server.")
		end
	end)

	addcmd("exit", { "shutdown", "leave" }, function(args, speaker)
		game:Shutdown()
	end)

	local NoclipParts = {}
	local Noclipping = nil
	addcmd("noclip", {}, function(args, speaker)
		pcall(function()
			Noclipping:Disconnect()
		end)
		Clip = false
		task.wait(0.1)
		NoclipParts = {}
		Noclipping = RunService.Stepped:Connect(function()
			if Clip == false and speaker.Character ~= nil then
				for _, child in pairs(speaker.Character:GetDescendants()) do
					if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
						child.CanCollide = false
						NoclipParts[child] = true
					end
				end
			end
		end)
		if args[1] and args[1] == "nonotify" then
			return
		end
		notify("Noclip", "Noclip Enabled")
	end)

	addcmd("unnoclip", { "clip" }, function(args, speaker)
		pcall(function()
			Noclipping:Disconnect()
		end)
		Clip = true
		task.wait(0.1)
		for child, _ in pairs(NoclipParts) do
			if typeof(child) == "Instance" and child:IsA("BasePart") and child.Parent then
				child.CanCollide = true
			end
		end
		NoclipParts = {}
		if args[1] and args[1] == "nonotify" then
			return
		end
		notify("Noclip", "Noclip Disabled")
	end)

	addcmd("togglenoclip", {}, function(args, speaker)
		execCmd(Clip and "noclip" or "unnoclip")
	end)

	FLYING = false
	QEfly = true
	zyflyspeed = 1
	vehicleflyspeed = 1
	function sFLY(vfly)
		local plr = Players.LocalPlayer
		local char = plr.Character or plr.CharacterAdded:Wait()
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			repeat
				task.wait()
			until char:FindFirstChildOfClass("Humanoid")
			humanoid = char:FindFirstChildOfClass("Humanoid")
		end

		if flyKeyDown or flyKeyUp then
			flyKeyDown:Disconnect()
			flyKeyUp:Disconnect()
		end

		local T = getRoot(char)
		local CONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
		local lCONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
		local SPEED = 0

		local function FLY()
			FLYING = true
			local BG = Instance.new("BodyGyro")
			local BV = Instance.new("BodyVelocity")
			BG.P = 9e4
			BG.Parent = T
			BV.Parent = T
			BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
			BG.CFrame = T.CFrame
			BV.Velocity = Vector3.new(0, 0, 0)
			BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
			task.spawn(function()
				repeat
					task.wait()
					local camera = workspace.CurrentCamera
					if not vfly and humanoid then
						humanoid.PlatformStand = true
					end

					if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
						SPEED = 50
					elseif
						not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0)
						and SPEED ~= 0
					then
						SPEED = 0
					end
					if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
						BV.Velocity = (
							(camera.CFrame.LookVector * (CONTROL.F + CONTROL.B))
							+ (
								(
									camera.CFrame
									* CFrame.new(
										CONTROL.L + CONTROL.R,
										(CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2,
										0
									).p
								) - camera.CFrame.p
							)
						) * SPEED
						lCONTROL = { F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R }
					elseif
						(CONTROL.L + CONTROL.R) == 0
						and (CONTROL.F + CONTROL.B) == 0
						and (CONTROL.Q + CONTROL.E) == 0
						and SPEED ~= 0
					then
						BV.Velocity = (
							(camera.CFrame.LookVector * (lCONTROL.F + lCONTROL.B))
							+ (
								(
									camera.CFrame
									* CFrame.new(
										lCONTROL.L + lCONTROL.R,
										(lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2,
										0
									).p
								) - camera.CFrame.p
							)
						) * SPEED
					else
						BV.Velocity = Vector3.new(0, 0, 0)
					end
					BG.CFrame = camera.CFrame
				until not FLYING
				CONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
				lCONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
				SPEED = 0
				BG:Destroy()
				BV:Destroy()

				if humanoid then
					humanoid.PlatformStand = false
				end
			end)
		end

		flyKeyDown = UserInputService.InputBegan:Connect(function(input, processed)
			if processed then
				return
			end
			if input.KeyCode == Enum.KeyCode.W then
				CONTROL.F = (vfly and vehicleflyspeed or zyflyspeed)
			elseif input.KeyCode == Enum.KeyCode.S then
				CONTROL.B = -(vfly and vehicleflyspeed or zyflyspeed)
			elseif input.KeyCode == Enum.KeyCode.A then
				CONTROL.L = -(vfly and vehicleflyspeed or zyflyspeed)
			elseif input.KeyCode == Enum.KeyCode.D then
				CONTROL.R = (vfly and vehicleflyspeed or zyflyspeed)
			elseif input.KeyCode == Enum.KeyCode.E and QEfly then
				CONTROL.Q = (vfly and vehicleflyspeed or zyflyspeed) * 2
			elseif input.KeyCode == Enum.KeyCode.Q and QEfly then
				CONTROL.E = -(vfly and vehicleflyspeed or zyflyspeed) * 2
			end
			pcall(function()
				camera.CameraType = Enum.CameraType.Track
			end)
		end)

		flyKeyUp = UserInputService.InputEnded:Connect(function(input, processed)
			if processed then
				return
			end
			if input.KeyCode == Enum.KeyCode.W then
				CONTROL.F = 0
			elseif input.KeyCode == Enum.KeyCode.S then
				CONTROL.B = 0
			elseif input.KeyCode == Enum.KeyCode.A then
				CONTROL.L = 0
			elseif input.KeyCode == Enum.KeyCode.D then
				CONTROL.R = 0
			elseif input.KeyCode == Enum.KeyCode.E then
				CONTROL.Q = 0
			elseif input.KeyCode == Enum.KeyCode.Q then
				CONTROL.E = 0
			end
		end)
		FLY()
	end

	function NOFLY()
		FLYING = false
		if flyKeyDown or flyKeyUp then
			flyKeyDown:Disconnect()
			flyKeyUp:Disconnect()
		end
		if Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
			Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
		end
		pcall(function()
			workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
		end)
	end

	local velocityHandlerName = randomString()
	local gyroHandlerName = randomString()
	local mfly1
	local mfly2

	local unmobilefly = function(speaker)
		pcall(function()
			FLYING = false
			local root = getRoot(speaker.Character)
			root:FindFirstChild(velocityHandlerName):Destroy()
			root:FindFirstChild(gyroHandlerName):Destroy()
			speaker.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
			mfly1:Disconnect()
			mfly2:Disconnect()
		end)
	end

	local mobilefly = function(speaker, vfly)
		unmobilefly(speaker)
		FLYING = true

		local root = getRoot(speaker.Character)
		local camera = workspace.CurrentCamera
		local v3none = Vector3.new()
		local v3zero = Vector3.new(0, 0, 0)
		local v3inf = Vector3.new(9e9, 9e9, 9e9)

		local controlModule = require(speaker.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
		local bv = Instance.new("BodyVelocity")
		bv.Name = velocityHandlerName
		bv.Parent = root
		bv.MaxForce = v3zero
		bv.Velocity = v3zero

		local bg = Instance.new("BodyGyro")
		bg.Name = gyroHandlerName
		bg.Parent = root
		bg.MaxTorque = v3inf
		bg.P = 1000
		bg.D = 50

		mfly1 = speaker.CharacterAdded:Connect(function()
			local bv = Instance.new("BodyVelocity")
			bv.Name = velocityHandlerName
			bv.Parent = root
			bv.MaxForce = v3zero
			bv.Velocity = v3zero

			local bg = Instance.new("BodyGyro")
			bg.Name = gyroHandlerName
			bg.Parent = root
			bg.MaxTorque = v3inf
			bg.P = 1000
			bg.D = 50
		end)

		mfly2 = RunService.RenderStepped:Connect(function()
			root = getRoot(speaker.Character)
			camera = workspace.CurrentCamera
			if
				speaker.Character:FindFirstChildWhichIsA("Humanoid")
				and root
				and root:FindFirstChild(velocityHandlerName)
				and root:FindFirstChild(gyroHandlerName)
			then
				local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
				local VelocityHandler = root:FindFirstChild(velocityHandlerName)
				local GyroHandler = root:FindFirstChild(gyroHandlerName)

				VelocityHandler.MaxForce = v3inf
				GyroHandler.MaxTorque = v3inf
				if not vfly then
					humanoid.PlatformStand = true
				end
				GyroHandler.CFrame = camera.CoordinateFrame
				VelocityHandler.Velocity = v3none

				local direction = controlModule:GetMoveVector()
				if direction.X > 0 then
					VelocityHandler.Velocity = VelocityHandler.Velocity
						+ camera.CFrame.RightVector
							* (direction.X * ((vfly and vehicleflyspeed or zyflyspeed) * 50))
				end
				if direction.X < 0 then
					VelocityHandler.Velocity = VelocityHandler.Velocity
						+ camera.CFrame.RightVector
							* (direction.X * ((vfly and vehicleflyspeed or zyflyspeed) * 50))
				end
				if direction.Z > 0 then
					VelocityHandler.Velocity = VelocityHandler.Velocity
						- camera.CFrame.LookVector * (direction.Z * ((vfly and vehicleflyspeed or zyflyspeed) * 50))
				end
				if direction.Z < 0 then
					VelocityHandler.Velocity = VelocityHandler.Velocity
						- camera.CFrame.LookVector * (direction.Z * ((vfly and vehicleflyspeed or zyflyspeed) * 50))
				end
			end
		end)
	end

	addcmd("fly", {}, function(args, speaker)
		if not IsOnMobile then
			NOFLY()
			wait()
			sFLY()
		else
			mobilefly(speaker)
		end
		if args[1] and isNumber(args[1]) then
			zyflyspeed = args[1]
		end
	end)

	addcmd("flyspeed", { "flysp" }, function(args, speaker)
		local speed = args[1] or 1
		if isNumber(speed) then
			zyflyspeed = speed
		end
	end)

	addcmd("unfly", { "nofly", "novfly", "unvehiclefly", "novehiclefly", "unvfly" }, function(args, speaker)
		if not IsOnMobile then
			NOFLY()
		else
			unmobilefly(speaker)
		end
	end)

	addcmd("vfly", { "vehiclefly" }, function(args, speaker)
		if not IsOnMobile then
			NOFLY()
			wait()
			sFLY(true)
		else
			mobilefly(speaker, true)
		end
		if args[1] and isNumber(args[1]) then
			vehicleflyspeed = args[1]
		end
	end)

	addcmd("togglevfly", {}, function(args, speaker)
		if FLYING then
			if not IsOnMobile then
				NOFLY()
			else
				unmobilefly(speaker)
			end
		else
			if not IsOnMobile then
				sFLY(true)
			else
				mobilefly(speaker, true)
			end
		end
	end)

	addcmd("vflyspeed", { "vflysp", "vehicleflyspeed", "vehicleflysp" }, function(args, speaker)
		local speed = args[1] or 1
		if isNumber(speed) then
			vehicleflyspeed = speed
		end
	end)

	addcmd("qefly", { "flyqe" }, function(args, speaker)
		if args[1] == "false" then
			QEfly = false
		else
			QEfly = true
		end
	end)

	addcmd("togglefly", {}, function(args, speaker)
		if FLYING then
			if not IsOnMobile then
				NOFLY()
			else
				unmobilefly(speaker)
			end
		else
			if not IsOnMobile then
				sFLY()
			else
				mobilefly(speaker)
			end
		end
	end)

	CFspeed = 50
	addcmd("cframefly", { "cfly" }, function(args, speaker)
		if args[1] and isNumber(args[1]) then
			CFspeed = args[1]
		end

		-- Full credit to peyton#9148 (apeyton)
		speaker.Character:FindFirstChildOfClass("Humanoid").PlatformStand = true
		local Head = speaker.Character:WaitForChild("Head")
		Head.Anchored = true
		if CFloop then
			CFloop:Disconnect()
		end
		CFloop = RunService.Heartbeat:Connect(function(deltaTime)
			local moveDirection = speaker.Character:FindFirstChildOfClass("Humanoid").MoveDirection
				* (CFspeed * deltaTime)
			local headCFrame = Head.CFrame
			local camera = workspace.CurrentCamera
			local cameraCFrame = camera.CFrame
			local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
			cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
			local cameraPosition = cameraCFrame.Position
			local headPosition = headCFrame.Position

			local objectSpaceVelocity =
				CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z))
					:VectorToObjectSpace(moveDirection)
			Head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
		end)
	end)

	addcmd("uncframefly", { "uncfly" }, function(args, speaker)
		if CFloop then
			CFloop:Disconnect()
			speaker.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
			local Head = speaker.Character:WaitForChild("Head")
			Head.Anchored = false
		end
	end)

	addcmd("cframeflyspeed", { "cflyspeed" }, function(args, speaker)
		if isNumber(args[1]) then
			CFspeed = args[1]
		end
	end)

	floating = false
	local beganListener: RBXScriptConnection
	local endListener: RBXScriptConnection
	local floatingFunc: RBXScriptConnection

	addcmd("float", { "platform" }, function(args, speaker)
		local pchar = speaker.Character
		floatName = randomString()
		floating = true

		if pchar and not pchar:FindFirstChild(floatName) then
			task.spawn(function()
				local floatPoint = -3.1
				local floatPart = Instance.new("Part")
				floatPart.Name = floatName
				floatPart.Parent = pchar
				floatPart.Transparency = 1
				floatPart.Size = Vector3.new(2, 0.2, 1.5)
				floatPart.Anchored = true

				notify("Float", "Started floating (Q = down & E = up)")

				beganListener = UserInputService.InputBegan:Connect(function(key, processed)
					if processed then
						return
					end

					if key.KeyCode == Enum.KeyCode.Q then
						floatPoint -= 0.5
					end
					if key.KeyCode == Enum.KeyCode.E then
						floatPoint += 1.5
					end
				end)
				endListener = UserInputService.InputEnded:Connect(function(key, processed)
					if processed then
						return
					end

					if key.KeyCode == Enum.KeyCode.Q then
						floatPoint += 0.5
					end
					if key.KeyCode == Enum.KeyCode.E then
						floatPoint -= 1.5
					end
				end)

				floatDied = speaker.Character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
					floatingFunc:Disconnect()
					floatPart:Destroy()
					floatDied:Disconnect()
					beganListener:Disconnect()
					endListener:Disconnect()
					floatName = nil
				end)
				local function floatPadLoop()
					if pchar:FindFirstChild(floatName) and getRoot(pchar) then
						floatPart.CFrame = getRoot(pchar).CFrame * CFrame.new(0, floatPoint, 0)
					else
						floatingFunc:Disconnect()
						floatPart:Destroy()
						floatDied:Disconnect()
						beganListener:Disconnect()
						endListener:Disconnect()
						floatName = nil
					end
				end
				floatingFunc = RunService.PreAnimation:Connect(floatPadLoop)
			end)
		end
	end)

	addcmd("unfloat", { "nofloat", "unplatform", "noplatform" }, function(args, speaker)
		floating = false
		local pchar = speaker.Character
		notify("Float", "Stopped floating")
		if pchar:FindFirstChild(floatName) then
			pchar:FindFirstChild(floatName):Destroy()
		end
		if floatDied then
			floatingFunc:Disconnect()
			floatDied:Disconnect()
			beganListener:Disconnect()
			endListener:Disconnect()
			floatName = nil
		end
	end)

	addcmd("togglefloat", {}, function(args, speaker)
		if floating then
			execCmd("unfloat")
		else
			execCmd("float")
		end
	end)

	swimming = false
	local oldgrav = workspace.Gravity
	local swimbeat = nil
	addcmd("swim", {}, function(args, speaker)
		if not swimming and speaker and speaker.Character and speaker.Character:FindFirstChildWhichIsA("Humanoid") then
			oldgrav = workspace.Gravity
			workspace.Gravity = 0
			local swimDied = function()
				workspace.Gravity = oldgrav
				swimming = false
			end
			local Humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
			gravReset = Humanoid.Died:Connect(swimDied)
			local enums = Enum.HumanoidStateType:GetEnumItems()
			table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))
			for i, v in pairs(enums) do
				Humanoid:SetStateEnabled(v, false)
			end
			Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
			swimbeat = RunService.Heartbeat:Connect(function()
				pcall(function()
					getRoot(speaker.Character).Velocity = (
						(Humanoid.MoveDirection ~= Vector3.new() or UserInputService:IsKeyDown(Enum.KeyCode.Space))
							and getRoot(speaker.Character).Velocity
						or Vector3.new()
					)
				end)
			end)
			swimming = true
		end
	end)

	addcmd("unswim", { "noswim" }, function(args, speaker)
		if speaker and speaker.Character and speaker.Character:FindFirstChildWhichIsA("Humanoid") then
			workspace.Gravity = oldgrav
			swimming = false
			if gravReset then
				gravReset:Disconnect()
			end
			if swimbeat ~= nil then
				swimbeat:Disconnect()
				swimbeat = nil
			end
			local Humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
			local enums = Enum.HumanoidStateType:GetEnumItems()
			table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))
			for i, v in pairs(enums) do
				Humanoid:SetStateEnabled(v, true)
			end
		end
	end)

	addcmd("toggleswim", {}, function(args, speaker)
		if swimming then
			execCmd("unswim")
		else
			execCmd("swim")
		end
	end)

	addcmd("setwaypoint", { "swp", "setwp", "spos", "saveposition", "savepos" }, function(args, speaker)
		local WPName = tostring(getstring(1, args))
		if getRoot(speaker.Character) then
			notify("Modified Waypoints", "Created waypoint: " .. getstring(1, args))
			local torso = getRoot(speaker.Character)
			WayPoints[#WayPoints + 1] = {
				NAME = WPName,
				COORD = { math.floor(torso.Position.X), math.floor(torso.Position.Y), math.floor(torso.Position.Z) },
				GAME = PlaceId,
			}
			if AllWaypoints ~= nil then
				AllWaypoints[#AllWaypoints + 1] = {
					NAME = WPName,
					COORD = { math.floor(torso.Position.X), math.floor(torso.Position.Y), math.floor(torso.Position.Z) },
					GAME = PlaceId,
				}
			end
		end
		refreshwaypoints()
		updatesaves()
	end)

	addcmd(
		"waypointpos",
		{ "wpp", "setwaypointposition", "setpos", "setwaypoint", "setwaypointpos" },
		function(args, speaker)
			local WPName = tostring(getstring(1, args))
			if getRoot(speaker.Character) then
				notify("Modified Waypoints", "Created waypoint: " .. getstring(1, args))
				WayPoints[#WayPoints + 1] = { NAME = WPName, COORD = { args[2], args[3], args[4] }, GAME = PlaceId }
				if AllWaypoints ~= nil then
					AllWaypoints[#AllWaypoints + 1] =
						{ NAME = WPName, COORD = { args[2], args[3], args[4] }, GAME = PlaceId }
				end
			end
			refreshwaypoints()
			updatesaves()
		end
	)

	addcmd("waypoints", { "positions" }, function(args, speaker)
		if SettingsOpen == false then
			SettingsOpen = true
			Settings:TweenPosition(UDim2.new(0, 0, 0, 45), "InOut", "Quart", 0.5, true, nil)
			CMDsF.Visible = false
		end
		KeybindsFrame:TweenPosition(UDim2.new(0, 0, 0, 175), "InOut", "Quart", 0.5, true, nil)
		AliasesFrame:TweenPosition(UDim2.new(0, 0, 0, 175), "InOut", "Quart", 0.5, true, nil)
		PluginsFrame:TweenPosition(UDim2.new(0, 0, 0, 175), "InOut", "Quart", 0.5, true, nil)
		PositionsFrame:TweenPosition(UDim2.new(0, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
		wait(0.5)
		SettingsHolder.Visible = false
		maximizeHolder()
	end)

	waypointParts = {}
	addcmd("showwaypoints", { "showwp", "showwps" }, function(args, speaker)
		execCmd("hidewaypoints")
		wait()
		for i, _ in pairs(WayPoints) do
			local x = WayPoints[i].COORD[1]
			local y = WayPoints[i].COORD[2]
			local z = WayPoints[i].COORD[3]
			local part = Instance.new("Part")
			part.Size = Vector3.new(5, 5, 5)
			part.CFrame = CFrame.new(x, y, z)
			part.Parent = workspace
			part.Anchored = true
			part.CanCollide = false
			table.insert(waypointParts, part)
			local view = Instance.new("BoxHandleAdornment")
			view.Adornee = part
			view.AlwaysOnTop = true
			view.ZIndex = 10
			view.Size = part.Size
			view.Parent = part
		end
		for i, v in pairs(pWayPoints) do
			local view = Instance.new("BoxHandleAdornment")
			view.Adornee = pWayPoints[i].COORD[1]
			view.AlwaysOnTop = true
			view.ZIndex = 10
			view.Size = pWayPoints[i].COORD[1].Size
			view.Parent = pWayPoints[i].COORD[1]
			table.insert(waypointParts, view)
		end
	end)

	addcmd("hidewaypoints", { "hidewp", "hidewps" }, function(args, speaker)
		for i, v in pairs(waypointParts) do
			v:Destroy()
		end
		waypointParts = {}
	end)

	addcmd("waypoint", { "wp", "lpos", "loadposition", "loadpos" }, function(args, speaker)
		local WPName = tostring(getstring(1, args))
		if speaker.Character then
			for i, _ in pairs(WayPoints) do
				if tostring(WayPoints[i].NAME):lower() == tostring(WPName):lower() then
					local x = WayPoints[i].COORD[1]
					local y = WayPoints[i].COORD[2]
					local z = WayPoints[i].COORD[3]
					getRoot(speaker.Character).CFrame = CFrame.new(x, y, z)
				end
			end
			for i, _ in pairs(pWayPoints) do
				if tostring(pWayPoints[i].NAME):lower() == tostring(WPName):lower() then
					getRoot(speaker.Character).CFrame = CFrame.new(pWayPoints[i].COORD[1].Position)
				end
			end
		end
	end)

	tweenSpeed = 1
	addcmd("tweenspeed", { "tspeed" }, function(args, speaker)
		local newSpeed = args[1] or 1
		if tonumber(newSpeed) then
			tweenSpeed = tonumber(newSpeed)
		end
	end)

	addcmd("tweenwaypoint", { "twp" }, function(args, speaker)
		local WPName = tostring(getstring(1, args))
		if speaker.Character then
			for i, _ in pairs(WayPoints) do
				local x = WayPoints[i].COORD[1]
				local y = WayPoints[i].COORD[2]
				local z = WayPoints[i].COORD[3]
				if tostring(WayPoints[i].NAME):lower() == tostring(WPName):lower() then
					TweenService:Create(
						getRoot(speaker.Character),
						TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear),
						{ CFrame = CFrame.new(x, y, z) }
					):Play()
				end
			end
			for i, _ in pairs(pWayPoints) do
				if tostring(pWayPoints[i].NAME):lower() == tostring(WPName):lower() then
					TweenService:Create(
						getRoot(speaker.Character),
						TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear),
						{ CFrame = CFrame.new(pWayPoints[i].COORD[1].Position) }
					):Play()
				end
			end
		end
	end)

	addcmd("walktowaypoint", { "wtwp" }, function(args, speaker)
		local WPName = tostring(getstring(1, args))
		if speaker.Character then
			for i, _ in pairs(WayPoints) do
				local x = WayPoints[i].COORD[1]
				local y = WayPoints[i].COORD[2]
				local z = WayPoints[i].COORD[3]
				if tostring(WayPoints[i].NAME):lower() == tostring(WPName):lower() then
					if
						speaker.Character:FindFirstChildOfClass("Humanoid")
						and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
					then
						speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
						wait(0.1)
					end
					speaker.Character:FindFirstChildOfClass("Humanoid").WalkToPoint = Vector3.new(x, y, z)
				end
			end
			for i, _ in pairs(pWayPoints) do
				if tostring(pWayPoints[i].NAME):lower() == tostring(WPName):lower() then
					if
						speaker.Character:FindFirstChildOfClass("Humanoid")
						and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
					then
						speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
						wait(0.1)
					end
					speaker.Character:FindFirstChildOfClass("Humanoid").WalkToPoint =
						Vector3.new(pWayPoints[i].COORD[1].Position)
				end
			end
		end
	end)

	addcmd("deletewaypoint", { "dwp", "dpos", "deleteposition", "deletepos" }, function(args, speaker)
		for i, v in pairs(WayPoints) do
			if v.NAME:lower() == tostring(getstring(1, args)):lower() then
				notify("Modified Waypoints", "Deleted waypoint: " .. v.NAME)
				table.remove(WayPoints, i)
			end
		end
		if AllWaypoints ~= nil and #AllWaypoints > 0 then
			for i, v in pairs(AllWaypoints) do
				if v.NAME:lower() == tostring(getstring(1, args)):lower() then
					if not v.GAME or v.GAME == PlaceId then
						table.remove(AllWaypoints, i)
					end
				end
			end
		end
		for i, v in pairs(pWayPoints) do
			if v.NAME:lower() == tostring(getstring(1, args)):lower() then
				notify("Modified Waypoints", "Deleted waypoint: " .. v.NAME)
				table.remove(pWayPoints, i)
			end
		end
		refreshwaypoints()
		updatesaves()
	end)

	addcmd("clearwaypoints", { "cwp", "clearpositions", "cpos", "clearpos" }, function(args, speaker)
		WayPoints = {}
		pWayPoints = {}
		refreshwaypoints()
		updatesaves()
		AllWaypoints = {}
		notify("Modified Waypoints", "Removed all waypoints")
	end)

	addcmd("cleargamewaypoints", { "cgamewp" }, function(args, speaker)
		for i, v in pairs(WayPoints) do
			if v.GAME == PlaceId then
				table.remove(WayPoints, i)
			end
		end
		if AllWaypoints ~= nil and #AllWaypoints > 0 then
			for i, v in pairs(AllWaypoints) do
				if v.GAME == PlaceId then
					table.remove(AllWaypoints, i)
				end
			end
		end
		for i, v in pairs(pWayPoints) do
			if v.GAME == PlaceId then
				table.remove(pWayPoints, i)
			end
		end
		refreshwaypoints()
		updatesaves()
		notify("Modified Waypoints", "Deleted game waypoints")
	end)

	local coreGuiTypeNames = {
		-- predefined aliases
		["inventory"] = Enum.CoreGuiType.Backpack,
		["leaderboard"] = Enum.CoreGuiType.PlayerList,
		["emotes"] = Enum.CoreGuiType.EmotesMenu,
	}

	-- Load the full list of enums
	for _, enumItem in ipairs(Enum.CoreGuiType:GetEnumItems()) do
		coreGuiTypeNames[enumItem.Name:lower()] = enumItem
	end

	addcmd("enable", {}, function(args, speaker)
		local input = args[1] and args[1]:lower()
		if input then
			if input == "reset" then
				StarterGui:SetCore("ResetButtonCallback", true)
			else
				local coreGuiType = coreGuiTypeNames[input]
				if coreGuiType then
					StarterGui:SetCoreGuiEnabled(coreGuiType, true)
				end
			end
		end
	end)

	addcmd("disable", {}, function(args, speaker)
		local input = args[1] and args[1]:lower()
		if input then
			if input == "reset" then
				StarterGui:SetCore("ResetButtonCallback", false)
			else
				local coreGuiType = coreGuiTypeNames[input]
				if coreGuiType then
					StarterGui:SetCoreGuiEnabled(coreGuiType, false)
				end
			end
		end
	end)

	local invisGUIS = {}
	addcmd("showguis", {}, function(args, speaker)
		for i, v in pairs(PlayerGui:GetDescendants()) do
			if (v:IsA("Frame") or v:IsA("ImageLabel") or v:IsA("ScrollingFrame")) and not v.Visible then
				v.Visible = true
				if not FindInTable(invisGUIS, v) then
					table.insert(invisGUIS, v)
				end
			end
		end
	end)

	addcmd("unshowguis", {}, function(args, speaker)
		for i, v in pairs(invisGUIS) do
			v.Visible = false
		end
		invisGUIS = {}
	end)

	local hiddenGUIS = {}
	addcmd("hideguis", {}, function(args, speaker)
		for i, v in pairs(PlayerGui:GetDescendants()) do
			if (v:IsA("Frame") or v:IsA("ImageLabel") or v:IsA("ScrollingFrame")) and v.Visible then
				v.Visible = false
				if not FindInTable(hiddenGUIS, v) then
					table.insert(hiddenGUIS, v)
				end
			end
		end
	end)

	addcmd("unhideguis", {}, function(args, speaker)
		for i, v in pairs(hiddenGUIS) do
			v.Visible = true
		end
		hiddenGUIS = {}
	end)

	function deleteGuisAtPos()
		pcall(function()
			local guisAtPosition = PlayerGui:GetGuiObjectsAtPosition(ZYMouse.X, ZYMouse.Y)
			for _, gui in pairs(guisAtPosition) do
				if gui.Visible == true then
					gui:Destroy()
				end
			end
		end)
	end

	local deleteGuiInput
	addcmd("guidelete", {}, function(args, speaker)
		deleteGuiInput = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
			if not gameProcessedEvent then
				if input.KeyCode == Enum.KeyCode.Backspace then
					deleteGuisAtPos()
				end
			end
		end)
		notify("GUI Delete Enabled", "Hover over a GUI and press backspace to delete it")
	end)

	addcmd("unguidelete", { "noguidelete" }, function(args, speaker)
		if deleteGuiInput then
			deleteGuiInput:Disconnect()
		end
		notify("GUI Delete Disabled", "GUI backspace delete has been disabled")
	end)

	local wasStayOpen = StayOpen
	addcmd("hidezy", {}, function(args, speaker)
		isHidden = true
		wasStayOpen = StayOpen
		if StayOpen then
			StayOpen = false
			On.BackgroundTransparency = 1
		end
		minimizeNum = 0
		minimizeHolder()
		if not (args[1] and tostring(args[1]) == "nonotify") then
			notify("ZY Hidden", "You can press the prefix key to access the command bar")
		end
	end)

	addcmd("showzy", { "unhidezy" }, function(args, speaker)
		isHidden = false
		minimizeNum = -20
		if wasStayOpen then
			maximizeHolder()
			StayOpen = true
			On.BackgroundTransparency = 0
		else
			minimizeHolder()
		end
	end)

	addcmd("rec", { "record" }, function(args, speaker)
		return COREGUI:ToggleRecording()
	end)

	addcmd("screenshot", { "scrnshot" }, function(args, speaker)
		return COREGUI:TakeScreenshot()
	end)

	addcmd("togglefs", { "togglefullscreen" }, function(args, speaker)
		return GuiService:ToggleFullscreen()
	end)

	addcmd("inspect", { "examine" }, function(args, speaker)
		for _, v in ipairs(getPlayer(args[1], speaker)) do
			GuiService:CloseInspectMenu()
			GuiService:InspectPlayerFromUserId(Players[v].UserId)
		end
	end)

	addcmd("savegame", { "saveplace" }, function(args, speaker)
		if saveinstance then
			notify("Loading", "Downloading game. This will take a while")
			saveinstance()
			notify("Game Saved", "Saved place to the workspace folder within your exploit folder.")
		else
			notify("Incompatible Exploit", "Your exploit does not support this command (missing saveinstance)")
		end
	end)

	addcmd("clearerror", { "clearerrors" }, function(args, speaker)
		GuiService:ClearError()
	end)

	addcmd("antigameplaypaused", {}, function(args, speaker)
		pcall(function()
			networkPaused:Disconnect()
		end)
		networkPaused = COREGUI.RobloxGui.ChildAdded:Connect(function(obj)
			if obj.Name == "CoreScripts/NetworkPause" then
				obj:Destroy()
			end
		end)
		COREGUI.RobloxGui["CoreScripts/NetworkPause"]:Destroy()
	end)

	addcmd("unantigameplaypaused", {}, function(args, speaker)
		networkPaused:Disconnect()
	end)

	addcmd("clientantikick", { "antikick" }, function(args, speaker)
		if not hookmetamethod then
			return notify("Incompatible Exploit", "Your exploit does not support this command (missing hookmetamethod)")
		end
		local LocalPlayer = Players.LocalPlayer
		local oldNamecall
		oldNamecall = hookmetamethod(
			game,
			"__namecall",
			newcclosure(function(...)
				local method = getnamecallmethod and getnamecallmethod() or ""
				if select(1, ...) == LocalPlayer and method == "Kick" or method == "kick" then
					return nil
				end
				return oldNamecall(...)
			end)
		)
		hookfunction(
			LocalPlayer.Kick,
			newcclosure(function(self, _)
				if self ~= lp then
					error("Expected ':' not '.' calling member function Kick", 2)
				end
				return nil
			end)
		)

		notify("Client Antikick", "Client anti kick is now active (only effective on localscript kick)")
	end)

	allow_rj = true
	addcmd("clientantiteleport", { "antiteleport" }, function(args, speaker)
		if not hookmetamethod then
			return notify("Incompatible Exploit", "Your exploit does not support this command (missing hookmetamethod)")
		end

		local oldTp
		oldTp = hookfunction(
			TeleportService.Teleport,
			newcclosure(function(self, placeId, player, _teleportData, customLoadingScreen)
				if checkcaller() or (allow_rj and placeId == game.PlaceId) then
					return oldTp(self, placeId, player, _teleportData, customLoadingScreen)
				end
				if self ~= TeleportService then
					error("Expected ':' not '.' calling member function Teleport", 2)
				end
				if placeId == nil then
					error("Argument 1 missing or nil", 2)
				end
				if typeof(placeId) ~= "number" and placeId ~= true then
					error("Unable to cast {typeof(placeId)} to int64", 2)
				elseif placeId == true then
					-- somehow raise raiseTeleportInitFailedEvent
					return
				end
				if typeof(customLoadingScreen) ~= "Instance" and customLoadingScreen ~= nil then
					error("Unable to cast value to Object", 2)
				end
				return nil
			end)
		)
		hookfunction(
			TeleportService.TeleportAsync,
			newcclosure(function(self, placeId, players, teleportOptions)
				if self ~= TeleportService then
					error("Expected ':' not '.' calling member function TeleportAsync", 2)
				end
				if players == nil then
					error("Argument 2 missing or nil", 2)
				end
				if typeof(players) ~= "table" then
					error("Unable to cast value to Objects", 2)
				end
				error("TeleportUnknown must be called from a Server", 2)
			end)
		)
		local oldNamecall
		oldNamecall = hookmetamethod(
			game,
			"__namecall",
			newcclosure(function(...)
				local nmc = getnamecallmethod()
				if
					select(1, ...) == TeleportService and nmc == "teleport"
					or nmc == "Teleport"
					or nmc == "TeleportToPlaceInstance"
					or nmc == "TeleportAsync"
				then
					if checkcaller() or (allow_rj and select(2, ...) == game.PlaceId) then
						return oldNamecall(...)
					end
					return
				end
				return oldNamecall(...)
			end)
		)

		notify("Client AntiTP", "Client anti teleport is now active (only effective on localscript teleport)")
	end)

	addcmd("allowrejoin", { "allowrj" }, function(args, speaker)
		allow_rj = not allow_rj
		notify("Client AntiTP", "Scripts now may" .. (allow_rj and "" or " not") .. " make you rejoin the server")
	end)

	addcmd("cancelteleport", { "canceltp" }, function(args, speaker)
		TeleportService:TeleportCancel()
	end)

	addcmd("volume", { "vol" }, function(args, speaker)
		UserSettings():GetService("UserGameSettings").MasterVolume = args[1] / 10
	end)

	addcmd("antilag", { "boostfps", "lowgraphics" }, function(args, speaker)
		local Terrain = workspace:FindFirstChildWhichIsA("Terrain")
		Terrain.WaterWaveSize = 0
		Terrain.WaterWaveSpeed = 0
		Terrain.WaterReflectance = 0
		Terrain.WaterTransparency = 1
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 9e9
		Lighting.FogStart = 9e9
		settings().Rendering.QualityLevel = 1
		for _, v in pairs(game:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CastShadow = false
				v.Material = "Plastic"
				v.Reflectance = 0
				v.BackSurface = "SmoothNoOutlines"
				v.BottomSurface = "SmoothNoOutlines"
				v.FrontSurface = "SmoothNoOutlines"
				v.LeftSurface = "SmoothNoOutlines"
				v.RightSurface = "SmoothNoOutlines"
				v.TopSurface = "SmoothNoOutlines"
			elseif v:IsA("Decal") then
				v.Transparency = 1
				v.Texture = ""
			elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
				v.Lifetime = NumberRange.new(0)
			end
		end
		for _, v in pairs(Lighting:GetDescendants()) do
			if v:IsA("PostEffect") then
				v.Enabled = false
			end
		end
		workspace.DescendantAdded:Connect(function(child)
			task.spawn(function()
				if
					child:IsA("ForceField")
					or child:IsA("Sparkles")
					or child:IsA("Smoke")
					or child:IsA("Fire")
					or child:IsA("Beam")
				then
					RunService.Heartbeat:Wait()
					child:Destroy()
				elseif child:IsA("BasePart") then
					child.CastShadow = false
				end
			end)
		end)
	end)

	addcmd("setfpscap", { "fpscap", "maxfps" }, function(args, speaker)
		if fpscaploop then
			task.cancel(fpscaploop)
			fpscaploop = nil
		end

		local fpsCap = 60
		local num = tonumber(args[1]) or 1e6
		if num == "none" then
			return
		elseif num > 0 then
			fpsCap = num
		else
			return notify("Invalid argument", "Please provide a number above 0 or 'none'.")
		end

		if setfpscap and type(setfpscap) == "function" then
			setfpscap(fpsCap)
		else
			fpscaploop = task.spawn(function()
				local timer = os.clock()
				while true do
					if os.clock() >= timer + 1 / fpsCap then
						timer = os.clock()
						task.wait()
					end
				end
			end)
		end
	end)

	addcmd("notify", {}, function(args, speaker)
		notify(getstring(1, args))
	end)

	addcmd("lastcommand", { "lastcmd" }, function(args, speaker)
		if cmdHistory[1]:sub(1, 11) ~= "lastcommand" and cmdHistory[1]:sub(1, 7) ~= "lastcmd" then
			execCmd(cmdHistory[1])
		end
	end)

	addcmd("esp", {}, function(args, speaker)
		if not CHMSenabled then
			ESPenabled = true
			for i, v in pairs(Players:GetPlayers()) do
				if v.Name ~= speaker.Name then
					ESP(v)
				end
			end
		else
			notify("ESP", "Disable chams (nochams) before using esp")
		end
	end)

	addcmd("espteam", {}, function(args, speaker)
		if not CHMSenabled then
			ESPenabled = true
			for i, v in pairs(Players:GetPlayers()) do
				if v.Name ~= speaker.Name then
					ESP(v, true)
				end
			end
		else
			notify("ESP", "Disable chams (nochams) before using esp")
		end
	end)

	addcmd("noesp", { "unesp", "unespteam" }, function(args, speaker)
		ESPenabled = false
		for i, c in pairs(COREGUI:GetChildren()) do
			if string.sub(c.Name, -4) == "_ESP" then
				c:Destroy()
			end
		end
	end)

	addcmd("esptransparency", {}, function(args, speaker)
		espTransparency = tonumber(args[1]) or 0.3
		if ESPenabled then
			execCmd("esp")
		end
		if CHMSenabled then
			execCmd("chams")
		end
		updatesaves()
	end)

	local espParts = {}
	local partEspTrigger = nil
	function partAdded(part)
		if #espParts > 0 then
			if FindInTable(espParts, part.Name:lower()) then
				local a = Instance.new("BoxHandleAdornment")
				a.Name = part.Name:lower() .. "_PESP"
				a.Parent = part
				a.Adornee = part
				a.AlwaysOnTop = true
				a.ZIndex = 0
				a.Size = part.Size
				a.Transparency = espTransparency
				a.Color = BrickColor.new("Lime green")
			end
		else
			partEspTrigger:Disconnect()
			partEspTrigger = nil
		end
	end

	addcmd("partesp", {}, function(args, speaker)
		local partEspName = getstring(1, args):lower()
		if not FindInTable(espParts, partEspName) then
			table.insert(espParts, partEspName)
			for i, v in pairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") and v.Name:lower() == partEspName then
					local a = Instance.new("BoxHandleAdornment")
					a.Name = partEspName .. "_PESP"
					a.Parent = v
					a.Adornee = v
					a.AlwaysOnTop = true
					a.ZIndex = 0
					a.Size = v.Size
					a.Transparency = espTransparency
					a.Color = BrickColor.new("Lime green")
				end
			end
		end
		if partEspTrigger == nil then
			partEspTrigger = workspace.DescendantAdded:Connect(partAdded)
		end
	end)

	addcmd("unpartesp", { "nopartesp" }, function(args, speaker)
		if args[1] then
			local partEspName = getstring(1, args):lower()
			if FindInTable(espParts, partEspName) then
				table.remove(espParts, GetInTable(espParts, partEspName))
			end
			for i, v in pairs(workspace:GetDescendants()) do
				if v:IsA("BoxHandleAdornment") and v.Name == partEspName .. "_PESP" then
					v:Destroy()
				end
			end
		else
			partEspTrigger:Disconnect()
			partEspTrigger = nil
			espParts = {}
			for i, v in pairs(workspace:GetDescendants()) do
				if v:IsA("BoxHandleAdornment") and v.Name:sub(-5) == "_PESP" then
					v:Destroy()
				end
			end
		end
	end)

	addcmd("chams", {}, function(args, speaker)
		if not ESPenabled then
			CHMSenabled = true
			for i, v in pairs(Players:GetPlayers()) do
				if v.Name ~= speaker.Name then
					CHMS(v)
				end
			end
		else
			notify("Chams", "Disable ESP (noesp) before using chams")
		end
	end)

	addcmd("nochams", { "unchams" }, function(args, speaker)
		CHMSenabled = false
		for i, v in pairs(Players:GetPlayers()) do
			local chmsplr = v
			for i, c in pairs(COREGUI:GetChildren()) do
				if c.Name == chmsplr.Name .. "_CHMS" then
					c:Destroy()
				end
			end
		end
	end)

	addcmd("locate", {}, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			Locate(Players[v])
		end
	end)

	addcmd("nolocate", { "unlocate" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		if args[1] then
			for i, v in pairs(players) do
				for i, c in pairs(COREGUI:GetChildren()) do
					if c.Name == Players[v].Name .. "_LC" then
						c:Destroy()
					end
				end
			end
		else
			for i, c in pairs(COREGUI:GetChildren()) do
				if string.sub(c.Name, -3) == "_LC" then
					c:Destroy()
				end
			end
		end
	end)

	viewing = nil
	addcmd("view", { "spectate" }, function(args, speaker)
		StopFreecam()
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			if viewDied then
				viewDied:Disconnect()
				viewChanged:Disconnect()
			end
			viewing = Players[v]
			workspace.CurrentCamera.CameraSubject = viewing.Character
			notify("Spectate", "Viewing " .. Players[v].Name)
			local function viewDiedFunc()
				repeat
					wait()
				until Players[v].Character ~= nil and getRoot(Players[v].Character)
				workspace.CurrentCamera.CameraSubject = viewing.Character
			end
			viewDied = Players[v].CharacterAdded:Connect(viewDiedFunc)
			local function viewChangedFunc()
				workspace.CurrentCamera.CameraSubject = viewing.Character
			end
			viewChanged = workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(viewChangedFunc)
		end
	end)

	addcmd("viewpart", { "viewp" }, function(args, speaker)
		StopFreecam()
		if args[1] then
			for i, v in pairs(workspace:GetDescendants()) do
				if v.Name:lower() == getstring(1, args):lower() and v:IsA("BasePart") then
					wait(0.1)
					workspace.CurrentCamera.CameraSubject = v
				end
			end
		end
	end)

	addcmd("unview", { "unspectate" }, function(args, speaker)
		StopFreecam()
		if viewing ~= nil then
			viewing = nil
			notify("Spectate", "View turned off")
		end
		if viewDied then
			viewDied:Disconnect()
			viewChanged:Disconnect()
		end
		workspace.CurrentCamera.CameraSubject = speaker.Character
	end)

	fcRunning = false
	local Camera = workspace.CurrentCamera
	workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		local newCamera = workspace.CurrentCamera
		if newCamera then
			Camera = newCamera
		end
	end)

	local INPUT_PRIORITY = Enum.ContextActionPriority.High.Value

	Spring = {}
	do
		Spring.__index = Spring

		function Spring.new(freq, pos)
			local self = setmetatable({}, Spring)
			self.f = freq
			self.p = pos
			self.v = pos * 0
			return self
		end

		function Spring:Update(dt, goal)
			local f = self.f * 2 * math.pi
			local p0 = self.p
			local v0 = self.v

			local offset = goal - p0
			local decay = math.exp(-f * dt)

			local p1 = goal + (v0 * dt - offset * (f * dt + 1)) * decay
			local v1 = (f * dt * (offset * f - v0) + v0) * decay

			self.p = p1
			self.v = v1

			return p1
		end

		function Spring:Reset(pos)
			self.p = pos
			self.v = pos * 0
		end
	end

	local cameraPos = Vector3.new()
	local cameraRot = Vector2.new()

	local velSpring = Spring.new(5, Vector3.new())
	local panSpring = Spring.new(5, Vector2.new())

	Input = {}
	do
		keyboard = {
			W = 0,
			A = 0,
			S = 0,
			D = 0,
			E = 0,
			Q = 0,
			Up = 0,
			Down = 0,
			LeftShift = 0,
		}

		mouse = {
			Delta = Vector2.new(),
		}

		NAV_KEYBOARD_SPEED = Vector3.new(1, 1, 1)
		PAN_MOUSE_SPEED = Vector2.new(1, 1) * (math.pi / 64)
		NAV_ADJ_SPEED = 0.75
		NAV_SHIFT_MUL = 0.25

		navSpeed = 1

		function Input.Vel(dt)
			navSpeed = math.clamp(navSpeed + dt * (keyboard.Up - keyboard.Down) * NAV_ADJ_SPEED, 0.01, 4)

			local kKeyboard = Vector3.new(keyboard.D - keyboard.A, keyboard.E - keyboard.Q, keyboard.S - keyboard.W)
				* NAV_KEYBOARD_SPEED

			local shift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)

			return kKeyboard * (navSpeed * (shift and NAV_SHIFT_MUL or 1))
		end

		function Input.Pan(dt)
			local kMouse = mouse.Delta * PAN_MOUSE_SPEED
			mouse.Delta = Vector2.new()
			return kMouse
		end

		do
			function Keypress(action, state, input)
				keyboard[input.KeyCode.Name] = state == Enum.UserInputState.Begin and 1 or 0
				return Enum.ContextActionResult.Sink
			end

			function MousePan(action, state, input)
				local delta = input.Delta
				mouse.Delta = Vector2.new(-delta.y, -delta.x)
				return Enum.ContextActionResult.Sink
			end

			function Zero(t)
				for k, v in pairs(t) do
					t[k] = v * 0
				end
			end

			function Input.StartCapture()
				ContextActionService:BindActionAtPriority(
					"FreecamKeyboard",
					Keypress,
					false,
					INPUT_PRIORITY,
					Enum.KeyCode.W,
					Enum.KeyCode.A,
					Enum.KeyCode.S,
					Enum.KeyCode.D,
					Enum.KeyCode.E,
					Enum.KeyCode.Q,
					Enum.KeyCode.Up,
					Enum.KeyCode.Down
				)
				ContextActionService:BindActionAtPriority(
					"FreecamMousePan",
					MousePan,
					false,
					INPUT_PRIORITY,
					Enum.UserInputType.MouseMovement
				)
			end

			function Input.StopCapture()
				navSpeed = 1
				Zero(keyboard)
				Zero(mouse)
				ContextActionService:UnbindAction("FreecamKeyboard")
				ContextActionService:UnbindAction("FreecamMousePan")
			end
		end
	end

	function GetFocusDistance(cameraFrame)
		local znear = 0.1
		local viewport = Camera.ViewportSize
		local projy = 2 * math.tan(cameraFov / 2)
		local projx = viewport.x / viewport.y * projy
		local fx = cameraFrame.rightVector
		local fy = cameraFrame.upVector
		local fz = cameraFrame.lookVector

		local minVect = Vector3.new()
		local minDist = 512

		for x = 0, 1, 0.5 do
			for y = 0, 1, 0.5 do
				local cx = (x - 0.5) * projx
				local cy = (y - 0.5) * projy
				local offset = fx * cx - fy * cy + fz
				local origin = cameraFrame.p + offset * znear
				local _, hit = workspace:FindPartOnRay(Ray.new(origin, offset.unit * minDist))
				local dist = (hit - origin).magnitude
				if minDist > dist then
					minDist = dist
					minVect = offset.unit
				end
			end
		end

		return fz:Dot(minVect) * minDist
	end

	local function StepFreecam(dt)
		local vel = velSpring:Update(dt, Input.Vel(dt))
		local pan = panSpring:Update(dt, Input.Pan(dt))

		local zoomFactor = math.sqrt(math.tan(math.rad(70 / 2)) / math.tan(math.rad(cameraFov / 2)))

		cameraRot = cameraRot + pan * Vector2.new(0.75, 1) * 8 * (dt / zoomFactor)
		cameraRot = Vector2.new(math.clamp(cameraRot.x, -math.rad(90), math.rad(90)), cameraRot.y % (2 * math.pi))

		local cameraCFrame = CFrame.new(cameraPos)
			* CFrame.fromOrientation(cameraRot.x, cameraRot.y, 0)
			* CFrame.new(vel * Vector3.new(1, 1, 1) * 64 * dt)
		cameraPos = cameraCFrame.p

		Camera.CFrame = cameraCFrame
		Camera.Focus = cameraCFrame * CFrame.new(0, 0, -GetFocusDistance(cameraCFrame))
		Camera.FieldOfView = cameraFov
	end

	local PlayerState = {}
	do
		mouseBehavior = ""
		mouseIconEnabled = ""
		cameraType = ""
		cameraFocus = ""
		cameraCFrame = ""
		cameraFieldOfView = ""

		function PlayerState.Push()
			cameraFieldOfView = Camera.FieldOfView
			Camera.FieldOfView = 70

			cameraType = Camera.CameraType
			Camera.CameraType = Enum.CameraType.Custom

			cameraCFrame = Camera.CFrame
			cameraFocus = Camera.Focus

			mouseIconEnabled = UserInputService.MouseIconEnabled
			UserInputService.MouseIconEnabled = true

			mouseBehavior = UserInputService.MouseBehavior
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		end

		function PlayerState.Pop()
			Camera.FieldOfView = 70

			Camera.CameraType = cameraType
			cameraType = nil

			Camera.CFrame = cameraCFrame
			cameraCFrame = nil

			Camera.Focus = cameraFocus
			cameraFocus = nil

			UserInputService.MouseIconEnabled = mouseIconEnabled
			mouseIconEnabled = nil

			UserInputService.MouseBehavior = mouseBehavior
			mouseBehavior = nil
		end
	end

	function StartFreecam(pos)
		if fcRunning then
			StopFreecam()
		end
		local cameraCFrame = Camera.CFrame
		if pos then
			cameraCFrame = pos
		end
		cameraRot = Vector2.new()
		cameraPos = cameraCFrame.p
		cameraFov = Camera.FieldOfView

		velSpring:Reset(Vector3.new())
		panSpring:Reset(Vector2.new())

		PlayerState.Push()
		RunService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, StepFreecam)
		Input.StartCapture()
		fcRunning = true
	end

	function StopFreecam()
		if not fcRunning then
			return
		end
		Input.StopCapture()
		RunService:UnbindFromRenderStep("Freecam")
		PlayerState.Pop()
		workspace.Camera.FieldOfView = 70
		fcRunning = false
	end

	addcmd("freecam", { "fc" }, function(args, speaker)
		StartFreecam()
	end)

	addcmd("freecampos", { "fcpos", "fcp", "freecamposition", "fcposition" }, function(args, speaker)
		if not args[1] then
			return
		end
		local freecamPos = CFrame.new(args[1], args[2], args[3])
		StartFreecam(freecamPos)
	end)

	addcmd("freecamwaypoint", { "fcwp" }, function(args, speaker)
		local WPName = tostring(getstring(1, args))
		if speaker.Character then
			for i, _ in pairs(WayPoints) do
				local x = WayPoints[i].COORD[1]
				local y = WayPoints[i].COORD[2]
				local z = WayPoints[i].COORD[3]
				if tostring(WayPoints[i].NAME):lower() == tostring(WPName):lower() then
					StartFreecam(CFrame.new(x, y, z))
				end
			end
			for i, _ in pairs(pWayPoints) do
				if tostring(pWayPoints[i].NAME):lower() == tostring(WPName):lower() then
					StartFreecam(CFrame.new(pWayPoints[i].COORD[1].Position))
				end
			end
		end
	end)

	addcmd("freecamgoto", { "fcgoto", "freecamtp", "fctp" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			StartFreecam(getRoot(Players[v].Character).CFrame)
		end
	end)

	addcmd("unfreecam", { "nofreecam", "unfc", "nofc" }, function(args, speaker)
		StopFreecam()
	end)

	addcmd("freecamspeed", { "fcspeed" }, function(args, speaker)
		local FCspeed = args[1] or 1
		if isNumber(FCspeed) then
			NAV_KEYBOARD_SPEED = Vector3.new(FCspeed, FCspeed, FCspeed)
		end
	end)

	addcmd("notifyfreecamposition", { "notifyfcpos" }, function(args, speaker)
		if fcRunning then
			local X, Y, Z =
				workspace.CurrentCamera.CFrame.Position.X,
				workspace.CurrentCamera.CFrame.Position.Y,
				workspace.CurrentCamera.CFrame.Position.Z
			local Format, Round = string.format, math.round
			notify("Current Position", Format("%s, %s, %s", Round(X), Round(Y), Round(Z)))
		end
	end)

	addcmd("copyfreecamposition", { "copyfcpos" }, function(args, speaker)
		if fcRunning then
			local X, Y, Z =
				workspace.CurrentCamera.CFrame.Position.X,
				workspace.CurrentCamera.CFrame.Position.Y,
				workspace.CurrentCamera.CFrame.Position.Z
			local Format, Round = string.format, math.round
			toClipboard(Format("%s, %s, %s", Round(X), Round(Y), Round(Z)))
		end
	end)

	addcmd("gotocamera", { "gotocam", "tocam" }, function(args, speaker)
		getRoot(speaker.Character).CFrame = workspace.Camera.CFrame
	end)

	addcmd("tweengotocamera", { "tweengotocam", "tgotocam", "ttocam" }, function(args, speaker)
		TweenService:Create(
			getRoot(speaker.Character),
			TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear),
			{ CFrame = workspace.Camera.CFrame }
		):Play()
	end)

	addcmd("fov", {}, function(args, speaker)
		local fov = args[1] or 70
		if isNumber(fov) then
			workspace.CurrentCamera.FieldOfView = fov
		end
	end)

	local preMaxZoom = Players.LocalPlayer.CameraMaxZoomDistance
	local preMinZoom = Players.LocalPlayer.CameraMinZoomDistance
	addcmd("lookat", {}, function(args, speaker)
		if speaker.CameraMaxZoomDistance ~= 0.5 then
			preMaxZoom = speaker.CameraMaxZoomDistance
			preMinZoom = speaker.CameraMinZoomDistance
		end
		speaker.CameraMaxZoomDistance = 0.5
		speaker.CameraMinZoomDistance = 0.5
		wait()
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			local target = Players[v].Character
			if target and target:FindFirstChild("Head") then
				workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, target.Head.CFrame.p)
				wait(0.1)
			end
		end
		speaker.CameraMaxZoomDistance = preMaxZoom
		speaker.CameraMinZoomDistance = preMinZoom
	end)

	addcmd("fixcam", { "restorecam" }, function(args, speaker)
		StopFreecam()
		execCmd("unview")
		workspace.CurrentCamera:remove()
		wait(0.1)
		repeat
			wait()
		until speaker.Character ~= nil
		workspace.CurrentCamera.CameraSubject = speaker.Character:FindFirstChildWhichIsA("Humanoid")
		workspace.CurrentCamera.CameraType = "Custom"
		speaker.CameraMinZoomDistance = 0.5
		speaker.CameraMaxZoomDistance = 400
		speaker.CameraMode = "Classic"
		speaker.Character.Head.Anchored = false
	end)

	addcmd("enableshiftlock", { "enablesl", "shiftlock" }, function(args, speaker)
		local function enableShiftlock()
			speaker.DevEnableMouseLock = true
		end
		speaker:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(enableShiftlock)
		enableShiftlock()
		notify("Shiftlock", "Shift lock should now be available")
	end)

	addcmd("firstp", {}, function(args, speaker)
		speaker.CameraMode = "LockFirstPerson"
	end)

	addcmd("thirdp", {}, function(args, speaker)
		speaker.CameraMode = "Classic"
	end)

	addcmd("noclipcam", { "nccam" }, function(args, speaker)
		local sc = (debug and debug.setconstant) or setconstant
		local gc = (debug and debug.getconstants) or getconstants
		if not sc or not getgc or not gc then
			return notify(
				"Incompatible Exploit",
				"Your exploit does not support this command (missing setconstant or getconstants or getgc)"
			)
		end
		local pop = speaker.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper
		for _, v in pairs(getgc()) do
			if type(v) == "function" and getfenv(v).script == pop then
				for i, v1 in pairs(gc(v)) do
					if tonumber(v1) == 0.25 then
						sc(v, i, 0)
					elseif tonumber(v1) == 0 then
						sc(v, i, 0.25)
					end
				end
			end
		end
	end)

	addcmd("maxzoom", {}, function(args, speaker)
		speaker.CameraMaxZoomDistance = args[1]
	end)

	addcmd("minzoom", {}, function(args, speaker)
		speaker.CameraMinZoomDistance = args[1]
	end)

	addcmd("camdistance", {}, function(args, speaker)
		local camMax = speaker.CameraMaxZoomDistance
		local camMin = speaker.CameraMinZoomDistance
		if camMax < tonumber(args[1]) then
			camMax = args[1]
		end
		speaker.CameraMaxZoomDistance = args[1]
		speaker.CameraMinZoomDistance = args[1]
		wait()
		speaker.CameraMaxZoomDistance = camMax
		speaker.CameraMinZoomDistance = camMin
	end)

	addcmd("unlockws", { "unlockworkspace" }, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Locked = false
			end
		end
	end)

	addcmd("lockws", { "lockworkspace" }, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Locked = true
			end
		end
	end)

	addcmd("delete", { "remove" }, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v.Name:lower() == getstring(1, args):lower() then
				v:Destroy()
			end
		end
		notify("Item(s) Deleted", "Deleted " .. getstring(1, args))
	end)

	addcmd("deleteclass", { "removeclass", "deleteclassname", "removeclassname", "dc" }, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v.ClassName:lower() == getstring(1, args):lower() then
				v:Destroy()
			end
		end
		notify("Item(s) Deleted", "Deleted items with ClassName " .. getstring(1, args))
	end)

	addcmd("chardelete", { "charremove", "cd" }, function(args, speaker)
		for i, v in pairs(speaker.Character:GetDescendants()) do
			if v.Name:lower() == getstring(1, args):lower() then
				v:Destroy()
			end
		end
		notify("Item(s) Deleted", "Deleted " .. getstring(1, args))
	end)

	addcmd(
		"chardeleteclass",
		{ "charremoveclass", "chardeleteclassname", "charremoveclassname", "cdc" },
		function(args, speaker)
			for i, v in pairs(speaker.Character:GetDescendants()) do
				if v.ClassName:lower() == getstring(1, args):lower() then
					v:Destroy()
				end
			end
			notify("Item(s) Deleted", "Deleted items with ClassName " .. getstring(1, args))
		end
	)

	addcmd("deletevelocity", { "dv", "removevelocity", "removeforces" }, function(args, speaker)
		for i, v in pairs(speaker.Character:GetDescendants()) do
			if
				v:IsA("BodyVelocity")
				or v:IsA("BodyGyro")
				or v:IsA("RocketPropulsion")
				or v:IsA("BodyThrust")
				or v:IsA("BodyAngularVelocity")
				or v:IsA("AngularVelocity")
				or v:IsA("BodyForce")
				or v:IsA("VectorForce")
				or v:IsA("LineForce")
			then
				v:Destroy()
			end
		end
	end)

	addcmd("deleteinvisparts", { "deleteinvisibleparts", "dip" }, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") and v.Transparency == 1 and v.CanCollide then
				v:Destroy()
			end
		end
	end)

	local shownParts = {}
	addcmd("invisibleparts", { "invisparts" }, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") and v.Transparency == 1 then
				if not table.find(shownParts, v) then
					table.insert(shownParts, v)
				end
				v.Transparency = 0
			end
		end
	end)

	addcmd("uninvisibleparts", { "uninvisparts" }, function(args, speaker)
		for i, v in pairs(shownParts) do
			v.Transparency = 1
		end
		shownParts = {}
	end)

	addcmd("btools", {}, function(args, speaker)
		for i = 1, 4 do
			local Tool = Instance.new("HopperBin")
			Tool.BinType = i
			Tool.Name = randomString()
			Tool.Parent = speaker:FindFirstChildWhichIsA("Backpack")
		end
	end)

	addcmd("f3x", { "fex" }, function(args, speaker)
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/refs/heads/main/f3x.lua"))()
	end)

	addcmd("partpath", { "partname" }, function(args, speaker)
		selectPart()
	end)

	local antiAfkCon = nil
	addcmd("antiafk", { "antiidle" }, function(args, speaker)
		if getconnections then
			for _, c in getconnections(speaker.Idled) do
				pcall(function()
					c:Disable()
				end) -- supposed to "pause" it
				pcall(function()
					c:Disconnect()
				end) -- supposed to disconnect it
			end
		end

		if antiAfkCon then
			antiAfkCon:Disconnect()
			antiAfkCon = nil
		end
		antiAfkCon = speaker.Idled:Connect(function()
			Services.VirtualUser:CaptureController()
			Services.VirtualUser:ClickButton2(Vector2.zero)
		end)

		if not (args[1] and tostring(args[1]) == "nonotify") then
			notify("Anti Idle", "Anti idle is enabled")
		end
	end)

	addcmd("datalimit", {}, function(args, speaker)
		local kbps = tonumber(args[1])
		if kbps then
			Services.NetworkClient:SetOutgoingKBPSLimit(kbps)
		end
	end)

	addcmd("replicationlag", { "backtrack" }, function(args, speaker)
		if tonumber(args[1]) then
			settings():GetService("NetworkSettings").IncomingReplicationLag = args[1]
		end
	end)

	addcmd("noprompts", { "nopurchaseprompts" }, function(args, speaker)
		COREGUI.PurchasePromptApp.Enabled = false
	end)

	addcmd("showprompts", { "showpurchaseprompts" }, function(args, speaker)
		COREGUI.PurchasePromptApp.Enabled = true
	end)

	promptNewRig = function(speaker, rig)
		local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
		if humanoid then
			AvatarEditorService:PromptSaveAvatar(humanoid.HumanoidDescription, Enum.HumanoidRigType[rig])
			local result = AvatarEditorService.PromptSaveAvatarCompleted:Wait()
			if result == Enum.AvatarPromptResult.Success then
				execCmd("reset")
			end
		end
	end

	addcmd("promptr6", {}, function(args, speaker)
		promptNewRig(speaker, "R6")
	end)

	addcmd("promptr15", {}, function(args, speaker)
		promptNewRig(speaker, "R15")
	end)

	addcmd("wallwalk", { "walkonwalls" }, function(args, speaker)
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/wallwalker.lua"))()
	end)

	addcmd("age", {}, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		local ages = {}
		for i, v in pairs(players) do
			local p = Players[v]
			table.insert(ages, p.Name .. "'s age is: " .. p.AccountAge)
		end
		notify("Account Age", table.concat(ages, ",\n"))
	end)

	addcmd("chatage", {}, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		local ages = {}
		for i, v in pairs(players) do
			local p = Players[v]
			table.insert(ages, p.Name .. "'s age is: " .. p.AccountAge)
		end
		local chatString = table.concat(ages, ", ")
		chatMessage(chatString)
	end)

	addcmd("joindate", { "jd" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		local dates = {}
		for i, v in pairs(players) do
			local p = Players[v]

			local secondsOld = p.AccountAge * 24 * 60 * 60
			local now = os.time()
			local dateJoined = p.Name .. " joined: " .. os.date("%m/%d/%y", now - secondsOld)

			table.insert(dates, dateJoined)
		end
		notify("Join Date (Month/Day/Year)", table.concat(dates, ",\n"))
	end)

	addcmd("chatjoindate", { "cjd" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		local dates = {}
		for i, v in pairs(players) do
			local p = Players[v]

			local secondsOld = p.AccountAge * 24 * 60 * 60
			local now = os.time()
			local dateJoined = p.Name .. " joined: " .. os.date("%m/%d/%y", now - secondsOld)

			table.insert(dates, dateJoined)
		end
		local chatString = table.concat(dates, ", ")
		chatMessage(chatString)
	end)

	addcmd("copyname", { "copyuser" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			local name = tostring(Players[v].Name)
			toClipboard(name)
		end
	end)

	addcmd("userid", { "id" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			local id = tostring(Players[v].UserId)
			notify("User ID", id)
		end
	end)

	addcmd("copyplaceid", { "placeid" }, function(args, speaker)
		toClipboard(PlaceId)
	end)

	addcmd("copygameid", { "gameid" }, function(args, speaker)
		toClipboard(game.GameId)
	end)

	addcmd("copyid", { "copyuserid" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			local id = tostring(Players[v].UserId)
			toClipboard(id)
		end
	end)

	addcmd("creatorid", { "creator" }, function(args, speaker)
		if game.CreatorType == Enum.CreatorType.User then
			notify("Creator ID", game.CreatorId)
		elseif game.CreatorType == Enum.CreatorType.Group then
			local OwnerID = GroupService:GetGroupInfoAsync(game.CreatorId).Owner.Id
			speaker.UserId = OwnerID
			notify("Creator ID", OwnerID)
		end
	end)

	addcmd("copycreatorid", { "copycreator" }, function(args, speaker)
		if game.CreatorType == Enum.CreatorType.User then
			toClipboard(game.CreatorId)
			notify("Copied ID", "Copied creator ID to clipboard")
		elseif game.CreatorType == Enum.CreatorType.Group then
			local OwnerID = GroupService:GetGroupInfoAsync(game.CreatorId).Owner.Id
			toClipboard(OwnerID)
			notify("Copied ID", "Copied creator ID to clipboard")
		end
	end)

	addcmd("setcreatorid", { "setcreator" }, function(args, speaker)
		if game.CreatorType == Enum.CreatorType.User then
			speaker.UserId = game.CreatorId
			notify("Set ID", "Set UserId to " .. game.CreatorId)
		elseif game.CreatorType == Enum.CreatorType.Group then
			local OwnerID = GroupService:GetGroupInfoAsync(game.CreatorId).Owner.Id
			speaker.UserId = OwnerID
			notify("Set ID", "Set UserId to " .. OwnerID)
		end
	end)

	addcmd("appearanceid", { "aid" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			local aid = tostring(Players[v].CharacterAppearanceId)
			notify("Appearance ID", aid)
		end
	end)

	addcmd("copyappearanceid", { "caid" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			local aid = tostring(Players[v].CharacterAppearanceId)
			toClipboard(aid)
		end
	end)

	addcmd("norender", {}, function(args, speaker)
		RunService:Set3dRenderingEnabled(false)
	end)

	addcmd("render", {}, function(args, speaker)
		RunService:Set3dRenderingEnabled(true)
	end)

	addcmd("2022materials", { "use2022materials" }, function(args, speaker)
		if sethidden then
			sethidden(MaterialService, "Use2022Materials", true)
		else
			notify("Incompatible Exploit", "Your exploit does not support this command (missing sethiddenproperty)")
		end
	end)

	addcmd("un2022materials", { "unuse2022materials" }, function(args, speaker)
		if sethidden then
			sethidden(MaterialService, "Use2022Materials", false)
		else
			notify("Incompatible Exploit", "Your exploit does not support this command (missing sethiddenproperty)")
		end
	end)

	addcmd("goto", { "to" }, function(args, speaker)
		local character = speaker and speaker.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		if humanoid == nil then
			return
		end

		if humanoid and humanoid.SeatPart then
			humanoid.Sit = false
			task.wait(0.1)
		end

		local waitForStream = parseBoolean(args[2], false)
		for _, name in getPlayer(args[1], speaker) do
			local targetCharacter = Players[name].Character
			if targetCharacter ~= nil then
				local targetPivot = targetCharacter:GetPivot()
				local targetPosition = targetPivot.Position

				if waitForStream and workspace.StreamingEnabled then
					task.spawn(speaker.RequestStreamAroundAsync, speaker, targetPosition, 5)
					targetCharacter:WaitForChild("HumanoidRootPart", 5)
				end

				speaker.Character:PivotTo(CFrame.new(targetPosition + (targetPivot.LookVector * 3), targetPosition))
				breakVelocity()
				break
			end
		end
	end)

	addcmd("tweengoto", { "tgoto", "tto", "tweento" }, function(args, speaker)
		local character = speaker and speaker.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")

		local oldState = humanoid and humanoid:GetStateEnabled(Enum.HumanoidStateType.Seated)
		if humanoid then
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
		end

		local players = getPlayer(args[1], speaker)
		for _, v in pairs(players) do
			if Players[v].Character ~= nil then
				if humanoid and humanoid.SeatPart then
					humanoid.Sit = false
					task.wait(0.1)
				end
				TweenService:Create(getRoot(speaker.Character), TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear), {
					CFrame = getRoot(Players[v].Character):GetPivot() + Vector3.new(3, 1, 0),
				}):Play()
			end
		end
		execCmd("breakvelocity")

		if type(oldState) == "boolean" then
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, oldState)
		end
	end)

	addcmd("vehiclegoto", { "vgoto", "vtp", "vehicletp" }, function(args, speaker)
		local character = speaker.Character
		local humanoid = if character then character:FindFirstChildOfClass("Humanoid") else nil
		if not humanoid then
			return
		end

		local seat = humanoid.SeatPart
		local vehicleModel = if seat then seat:FindFirstAncestorWhichIsA("Model") else nil
		if vehicleModel == nil then
			notify("Vehicle Goto", "Make sure you're sitting in a vehicle.")
			return
		end

		for _, v in getPlayer(args[1], speaker) do
			if Players[v].Character == nil then
				continue
			end

			local root = getRoot(Players[v].Character)
			if root == nil then
				continue
			end

			vehicleModel:PivotTo(root:GetPivot())
			break
		end
	end)

	addcmd("pulsetp", { "ptp" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			if Players[v].Character ~= nil then
				local startPos = getRoot(speaker.Character).CFrame
				local seconds = args[2] or 1
				if
					speaker.Character:FindFirstChildOfClass("Humanoid")
					and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
				then
					speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
					wait(0.1)
				end
				getRoot(speaker.Character).CFrame = getRoot(Players[v].Character).CFrame + Vector3.new(3, 1, 0)
				wait(seconds)
				getRoot(speaker.Character).CFrame = startPos
			end
		end
		execCmd("breakvelocity")
	end)

	local vnoclipParts = {}
	addcmd("vehiclenoclip", { "vnoclip" }, function(args, speaker)
		vnoclipParts = {}
		local seat = speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
		local vehicleModel = seat.Parent
		repeat
			if vehicleModel.ClassName ~= "Model" then
				vehicleModel = vehicleModel.Parent
			end
		until vehicleModel.ClassName == "Model"
		wait(0.1)
		execCmd("noclip")
		for i, v in pairs(vehicleModel:GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide then
				table.insert(vnoclipParts, v)
				v.CanCollide = false
			end
		end
	end)

	addcmd("vehicleclip", { "vclip", "unvnoclip", "unvehiclenoclip" }, function(args, speaker)
		execCmd("clip")
		for i, v in pairs(vnoclipParts) do
			v.CanCollide = true
		end
		vnoclipParts = {}
	end)

	addcmd("togglevnoclip", {}, function(args, speaker)
		execCmd(Clip and "vnoclip" or "vclip")
	end)

	addcmd("clientbring", { "cbring" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			if Players[v].Character ~= nil then
				if Players[v].Character:FindFirstChildOfClass("Humanoid") then
					Players[v].Character:FindFirstChildOfClass("Humanoid").Sit = false
				end
				wait()
				getRoot(Players[v].Character).CFrame = getRoot(speaker.Character).CFrame + Vector3.new(3, 1, 0)
			end
		end
	end)

	local bringT = {}
	addcmd("loopbring", {}, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			task.spawn(function()
				if Players[v].Name ~= speaker.Name and not FindInTable(bringT, Players[v].Name) then
					table.insert(bringT, Players[v].Name)
					local plrName = Players[v].Name
					local pchar = Players[v].Character
					local distance = 3
					if args[2] and isNumber(args[2]) then
						distance = args[2]
					end
					local lDelay = 0
					if args[3] and isNumber(args[3]) then
						lDelay = args[3]
					end
					repeat
						for i, c in pairs(players) do
							if Players:FindFirstChild(v) then
								pchar = Players[v].Character
								if
									pchar ~= nil
									and Players[v].Character ~= nil
									and getRoot(pchar)
									and speaker.Character ~= nil
									and getRoot(speaker.Character)
								then
									getRoot(pchar).CFrame = getRoot(speaker.Character).CFrame
										+ Vector3.new(distance, 1, 0)
								end
								wait(lDelay)
							else
								for a, b in pairs(bringT) do
									if b == plrName then
										table.remove(bringT, a)
									end
								end
							end
						end
					until not FindInTable(bringT, plrName)
				end
			end)
		end
	end)

	addcmd("unloopbring", { "noloopbring" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			task.spawn(function()
				for a, b in pairs(bringT) do
					if b == Players[v].Name then
						table.remove(bringT, a)
					end
				end
			end)
		end
	end)

	local walkto = false
	local waypointwalkto = false
	addcmd("walkto", { "follow" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			if Players[v].Character ~= nil then
				if
					speaker.Character:FindFirstChildOfClass("Humanoid")
					and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
				then
					speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
					wait(0.1)
				end
				walkto = true
				repeat
					wait()
					speaker.Character:FindFirstChildOfClass("Humanoid"):MoveTo(getRoot(Players[v].Character).Position)
				until Players[v].Character == nil or not getRoot(Players[v].Character) or walkto == false
			end
		end
	end)

	addcmd("pathfindwalkto", { "pathfindfollow" }, function(args, speaker)
		walkto = false
		wait()
		local players = getPlayer(args[1], speaker)
		local hum = Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		local path = PathService:CreatePath()
		for i, v in pairs(players) do
			if Players[v].Character ~= nil then
				if
					speaker.Character:FindFirstChildOfClass("Humanoid")
					and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
				then
					speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
					wait(0.1)
				end
				walkto = true
				repeat
					wait()
					local success, response = pcall(function()
						path:ComputeAsync(getRoot(speaker.Character).Position, getRoot(Players[v].Character).Position)
						local waypoints = path:GetWaypoints()
						local distance
						for waypointIndex, waypoint in pairs(waypoints) do
							local waypointPosition = waypoint.Position
							hum:MoveTo(waypointPosition)
							repeat
								distance = (waypointPosition - hum.Parent.PrimaryPart.Position).magnitude
								wait()
							until distance <= 5
						end
					end)
					if not success then
						speaker.Character
							:FindFirstChildOfClass("Humanoid")
							:MoveTo(getRoot(Players[v].Character).Position)
					end
				until Players[v].Character == nil or not getRoot(Players[v].Character) or walkto == false
			end
		end
	end)

	addcmd("pathfindwalktowaypoint", { "pathfindwalktowp" }, function(args, speaker)
		waypointwalkto = false
		wait()
		local WPName = tostring(getstring(1, args))
		local hum = Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		local path = PathService:CreatePath()
		if speaker.Character then
			for i, _ in pairs(WayPoints) do
				if tostring(WayPoints[i].NAME):lower() == tostring(WPName):lower() then
					if
						speaker.Character:FindFirstChildOfClass("Humanoid")
						and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
					then
						speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
						wait(0.1)
					end
					local TrueCoords = Vector3.new(WayPoints[i].COORD[1], WayPoints[i].COORD[2], WayPoints[i].COORD[3])
					waypointwalkto = true
					repeat
						wait()
						local success, response = pcall(function()
							path:ComputeAsync(getRoot(speaker.Character).Position, TrueCoords)
							local waypoints = path:GetWaypoints()
							local distance
							for waypointIndex, waypoint in pairs(waypoints) do
								local waypointPosition = waypoint.Position
								hum:MoveTo(waypointPosition)
								repeat
									distance = (waypointPosition - hum.Parent.PrimaryPart.Position).magnitude
									wait()
								until distance <= 5
							end
						end)
						if not success then
							speaker.Character:FindFirstChildOfClass("Humanoid"):MoveTo(TrueCoords)
						end
					until not speaker.Character or waypointwalkto == false
				end
			end
			for i, _ in pairs(pWayPoints) do
				if tostring(pWayPoints[i].NAME):lower() == tostring(WPName):lower() then
					if
						speaker.Character:FindFirstChildOfClass("Humanoid")
						and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
					then
						speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
						wait(0.1)
					end
					local TrueCoords = pWayPoints[i].COORD[1].Position
					waypointwalkto = true
					repeat
						wait()
						local success, response = pcall(function()
							path:ComputeAsync(getRoot(speaker.Character).Position, TrueCoords)
							local waypoints = path:GetWaypoints()
							local distance
							for waypointIndex, waypoint in pairs(waypoints) do
								local waypointPosition = waypoint.Position
								hum:MoveTo(waypointPosition)
								repeat
									distance = (waypointPosition - hum.Parent.PrimaryPart.Position).magnitude
									wait()
								until distance <= 5
							end
						end)
						if not success then
							speaker.Character:FindFirstChildOfClass("Humanoid"):MoveTo(TrueCoords)
						end
					until not speaker.Character or waypointwalkto == false
				end
			end
		end
	end)

	addcmd("unwalkto", { "nowalkto", "unfollow", "nofollow" }, function(args, speaker)
		walkto = false
		waypointwalkto = false
	end)

	addcmd("orbit", {}, function(args, speaker)
		execCmd("unorbit nonotify")

		local target = Players:FindFirstChild(getPlayer(args[1], speaker)[1])
		local root = getRoot(speaker.Character)
		local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")

		if target and target.Character and getRoot(target.Character) and root and humanoid then
			local rotation = 0
			local speed = tonumber(args[2]) or 0.2
			local distance = tonumber(args[3]) or 6

			orbit1 = RunService.Stepped:Connect(function()
				breakVelocity()
				rotation = rotation + speed

				local targetRoot = getRoot(target.Character).Position
				local orbitPosition = (CFrame.new(targetRoot) * CFrame.Angles(0, math.rad(rotation), 0) * CFrame.new(
					distance,
					0,
					0
				)).Position
				root.CFrame = CFrame.lookAt(orbitPosition, Vector3.new(targetRoot.X, orbitPosition.Y, targetRoot.Z))
			end)

			orbit2 = humanoid.Died:Connect(function()
				execCmd("unorbit")
			end)

			orbit3 = humanoid.Seated:Connect(function(value)
				if value then
					execCmd("unorbit")
				end
			end)

			notify("Orbit", "Started orbiting " .. formatUsername(target))
		end
	end)

	addcmd("unorbit", {}, function(args, speaker)
		if orbit1 then
			orbit1:Disconnect()
		end
		if orbit2 then
			orbit2:Disconnect()
		end
		if orbit3 then
			orbit3:Disconnect()
		end
		if args[1] ~= "nonotify" then
			notify("Orbit", "Stopped orbiting player")
		end
	end)

	addcmd("freeze", { "fr" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		if players ~= nil then
			for i, v in pairs(players) do
				task.spawn(function()
					for i, x in next, Players[v].Character:GetDescendants() do
						if x:IsA("BasePart") and not x.Anchored then
							x.Anchored = true
						end
					end
				end)
			end
		end
	end)

	addcmd("thaw", { "unfreeze", "unfr" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		if players ~= nil then
			for i, v in pairs(players) do
				task.spawn(function()
					for i, x in next, Players[v].Character:GetDescendants() do
						if x.Name ~= floatName and x:IsA("BasePart") and x.Anchored then
							x.Anchored = false
						end
					end
				end)
			end
		end
	end)

	addcmd("anchor", {}, function(args, speaker)
		getRoot(speaker.Character).Anchored = true
	end)

	addcmd("unanchor", {}, function(args, speaker)
		getRoot(speaker.Character).Anchored = false
	end)

	oofing = false
	addcmd("loopoof", {}, function(args, speaker)
		oofing = true
		repeat
			wait(0.1)
			for i, v in pairs(Players:GetPlayers()) do
				if v.Character ~= nil and v.Character:FindFirstChild("Head") then
					for _, x in pairs(v.Character.Head:GetChildren()) do
						if x:IsA("Sound") then
							x.Playing = true
						end
					end
				end
			end
		until oofing == false
	end)

	addcmd("unloopoof", {}, function(args, speaker)
		oofing = false
	end)

	local notifiedRespectFiltering = false
	addcmd("muteboombox", {}, function(args, speaker)
		if not notifiedRespectFiltering and SoundService.RespectFilteringEnabled then
			notifiedRespectFiltering = true
			notify(
				"RespectFilteringEnabled",
				"RespectFilteringEnabled is set to true (the command will still work but may only be clientsided)"
			)
		end
		local players = getPlayer(args[1], speaker)
		if players ~= nil then
			for i, v in pairs(players) do
				task.spawn(function()
					for i, x in next, Players[v].Character:GetDescendants() do
						if x:IsA("Sound") and x.Playing == true then
							x.Playing = false
						end
					end
					for i, x in next, Players[v]:FindFirstChildOfClass("Backpack"):GetDescendants() do
						if x:IsA("Sound") and x.Playing == true then
							x.Playing = false
						end
					end
				end)
			end
		end
	end)

	addcmd("unmuteboombox", {}, function(args, speaker)
		if not notifiedRespectFiltering and SoundService.RespectFilteringEnabled then
			notifiedRespectFiltering = true
			notify(
				"RespectFilteringEnabled",
				"RespectFilteringEnabled is set to true (the command will still work but may only be clientsided)"
			)
		end
		local players = getPlayer(args[1], speaker)
		if players ~= nil then
			for i, v in pairs(players) do
				task.spawn(function()
					for i, x in next, Players[v].Character:GetDescendants() do
						if x:IsA("Sound") and x.Playing == false then
							x.Playing = true
						end
					end
				end)
			end
		end
	end)

	addcmd("reset", {}, function(args, speaker)
		local humanoid = speaker.Character and speaker.Character:FindFirstChildWhichIsA("Humanoid")
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Dead)
		else
			speaker.Character:BreakJoints()
		end
	end)

	addcmd("freezeanims", {}, function(args, speaker)
		local Humanoid = speaker.Character:FindFirstChildOfClass("Humanoid")
			or speaker.Character:FindFirstChildOfClass("AnimationController")
		local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
		for _, v in pairs(ActiveTracks) do
			v:AdjustSpeed(0)
		end
	end)

	addcmd("unfreezeanims", {}, function(args, speaker)
		local Humanoid = speaker.Character:FindFirstChildOfClass("Humanoid")
			or speaker.Character:FindFirstChildOfClass("AnimationController")
		local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
		for _, v in pairs(ActiveTracks) do
			v:AdjustSpeed(1)
		end
	end)

	addcmd("respawn", {}, function(args, speaker)
		respawn(speaker)
	end)

	addcmd("refresh", { "re" }, function(args, speaker)
		refresh(speaker)
	end)

	addcmd("god", {}, function(args, speaker)
		local Cam = workspace.CurrentCamera
		local Char, Pos = speaker.Character, Cam.CFrame
		local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
		local nHuman = Human:Clone()
		nHuman.Parent = char
		speaker.Character = nil
		nHuman:SetStateEnabled(15, false)
		nHuman:SetStateEnabled(1, false)
		nHuman:SetStateEnabled(0, false)
		nHuman.BreakJointsOnDeath = true
		Human:Destroy()
		speaker.Character = char
		Cam.CameraSubject = nHuman
		Cam.CFrame = task.wait() and pos
		nHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		local Script = Char:FindFirstChild("Animate")
		if Script then
			Script.Disabled = true
			task.wait()
			Script.Disabled = false
		end
		nHuman.Health = nHuman.MaxHealth
	end)

	invisRunning = false
	addcmd("invisible", { "invis" }, function(args, speaker)
		if invisRunning then
			return
		end
		invisRunning = true
		-- Full credit to AmokahFox @V3rmillion
		local Player = speaker
		repeat
			wait(0.1)
		until Player.Character
		local Character = Player.Character
		Character.Archivable = true
		local IsInvis = false
		local IsRunning = true
		local InvisibleCharacter = Character:Clone()
		InvisibleCharacter.Parent = Lighting
		local Void = workspace.FallenPartsDestroyHeight
		InvisibleCharacter.Name = ""
		local CF

		local invisFix = RunService.Stepped:Connect(function()
			pcall(function()
				local IsInteger
				if tostring(Void):find("-") then
					IsInteger = true
				else
					IsInteger = false
				end
				local Pos = Player.Character.Humanoid.RootPart.Position
				local Pos_String = tostring(Pos)
				local Pos_Seperate = Pos_String:split(", ")
				local X = tonumber(Pos_Seperate[1])
				local Y = tonumber(Pos_Seperate[2])
				local Z = tonumber(Pos_Seperate[3])
				if IsInteger == true then
					if Y <= Void then
						Respawn()
					end
				elseif IsInteger == false then
					if Y >= Void then
						Respawn()
					end
				end
			end)
		end)

		for i, v in pairs(InvisibleCharacter:GetDescendants()) do
			if v:IsA("BasePart") then
				if v.Name == "HumanoidRootPart" then
					v.Transparency = 1
				else
					v.Transparency = 0.5
				end
			end
		end

		function Respawn()
			IsRunning = false
			if IsInvis == true then
				pcall(function()
					Player.Character = Character
					wait()
					Character.Parent = workspace
					Character:FindFirstChildWhichIsA("Humanoid"):Destroy()
					IsInvis = false
					InvisibleCharacter.Parent = nil
					invisRunning = false
				end)
			elseif IsInvis == false then
				pcall(function()
					Player.Character = Character
					wait()
					Character.Parent = workspace
					Character:FindFirstChildWhichIsA("Humanoid"):Destroy()
					TurnVisible()
				end)
			end
		end

		local invisDied
		invisDied = InvisibleCharacter:FindFirstChildOfClass("Humanoid").Died:Connect(function()
			Respawn()
			invisDied:Disconnect()
		end)

		if IsInvis == true then
			return
		end
		IsInvis = true
		CF = workspace.CurrentCamera.CFrame
		local CF_1 = Player.Character.Humanoid.RootPart.CFrame
		Character:MoveTo(Vector3.new(0, math.pi * 1000000, 0))
		workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
		wait(0.2)
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
		InvisibleCharacter = InvisibleCharacter
		Character.Parent = Lighting
		InvisibleCharacter.Parent = workspace
		InvisibleCharacter.Humanoid.RootPart.CFrame = CF_1
		Player.Character = InvisibleCharacter
		execCmd("fixcam")
		Player.Character.Animate.Disabled = true
		Player.Character.Animate.Disabled = false

		function TurnVisible()
			if IsInvis == false then
				return
			end
			invisFix:Disconnect()
			invisDied:Disconnect()
			CF = workspace.CurrentCamera.CFrame
			Character = Character
			local CF_1 = Player.Character.Humanoid.RootPart.CFrame
			Character.Humanoid.RootPart.CFrame = CF_1
			InvisibleCharacter:Destroy()
			Player.Character = Character
			Character.Parent = workspace
			IsInvis = false
			Player.Character.Animate.Disabled = true
			Player.Character.Animate.Disabled = false
			invisDied = Character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
				Respawn()
				invisDied:Disconnect()
			end)
			invisRunning = false
		end
		notify("Invisible", "You now appear invisible to other players")
	end)

	addcmd("visible", { "vis", "uninvisible" }, function(args, speaker)
		TurnVisible()
	end)

	addcmd("toggleinvis", {}, function(args, speaker)
		execCmd(invisRunning and "visible" or "invisible")
	end)

	addcmd("toolinvisible", { "toolinvis", "tinvis" }, function(args, speaker)
		local Char = Players.LocalPlayer.Character
		local touched = false
		local tpdback = false
		local box = Instance.new("Part")
		box.Anchored = true
		box.CanCollide = true
		box.Size = Vector3.new(10, 1, 10)
		box.Position = Vector3.new(0, 10000, 0)
		box.Parent = workspace
		local boxTouched = box.Touched:connect(function(part)
			if part.Parent.Name == Players.LocalPlayer.Name then
				if touched == false then
					touched = true
					local function apply()
						local no = Char.Humanoid.RootPart:Clone()
						task.wait(0.25)
						Char.Humanoid.RootPart:Destroy()
						no.Parent = Char
						Char:MoveTo(loc)
						touched = false
					end
					if Char then
						apply()
					end
				end
			end
		end)
		repeat
			wait()
		until Char
		local cleanUp
		cleanUp = Players.LocalPlayer.CharacterAdded:connect(function(char)
			boxTouched:Disconnect()
			box:Destroy()
			cleanUp:Disconnect()
		end)
		loc = Char.Humanoid.RootPart.Position
		Char:MoveTo(box.Position + Vector3.new(0, 0.5, 0))
	end)

	addcmd("strengthen", {}, function(args, speaker)
		for _, child in pairs(speaker.Character:GetDescendants()) do
			if child.ClassName == "Part" then
				if args[1] then
					child.CustomPhysicalProperties = PhysicalProperties.new(args[1], 0.3, 0.5)
				else
					child.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
				end
			end
		end
	end)

	addcmd("weaken", {}, function(args, speaker)
		for _, child in pairs(speaker.Character:GetDescendants()) do
			if child.ClassName == "Part" then
				if args[1] then
					child.CustomPhysicalProperties = PhysicalProperties.new(-args[1], 0.3, 0.5)
				else
					child.CustomPhysicalProperties = PhysicalProperties.new(0, 0.3, 0.5)
				end
			end
		end
	end)

	addcmd("unweaken", { "unstrengthen" }, function(args, speaker)
		for _, child in pairs(speaker.Character:GetDescendants()) do
			if child.ClassName == "Part" then
				child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
			end
		end
	end)

	addcmd("breakvelocity", {}, function(args, speaker)
		local BeenASecond, V3 = false, Vector3.new(0, 0, 0)
		delay(1, function()
			BeenASecond = true
		end)
		while not BeenASecond do
			for _, v in ipairs(speaker.Character:GetDescendants()) do
				if v:IsA("BasePart") then
					v.Velocity, v.RotVelocity = V3, V3
				end
			end
			wait()
		end
	end)

	addcmd("jpower", { "jumppower", "jp" }, function(args, speaker)
		local jpower = args[1] or 50
		if isNumber(jpower) then
			if speaker.Character:FindFirstChildOfClass("Humanoid").UseJumpPower then
				speaker.Character:FindFirstChildOfClass("Humanoid").JumpPower = jpower
			else
				speaker.Character:FindFirstChildOfClass("Humanoid").JumpHeight = jpower
			end
		end
	end)

	addcmd("maxslopeangle", { "msa" }, function(args, speaker)
		local sangle = args[1] or 89
		if isNumber(sangle) then
			speaker.Character:FindFirstChildWhichIsA("Humanoid").MaxSlopeAngle = sangle
		end
	end)

	addcmd("gravity", { "grav" }, function(args, speaker)
		local grav = args[1] or oldgrav
		if isNumber(grav) then
			workspace.Gravity = grav
		end
	end)

	addcmd("hipheight", { "hheight" }, function(args, speaker)
		local hipHeight = args[1] or (r15(speaker) and 2.1 or 0)
		if isNumber(hipHeight) then
			speaker.Character:FindFirstChildWhichIsA("Humanoid").HipHeight = hipHeight
		end
	end)

	addcmd("dance", {}, function(args, speaker)
		pcall(execCmd, "undance")
		local dances = { "27789359", "30196114", "248263260", "45834924", "33796059", "28488254", "52155728" }
		if r15(speaker) then
			dances = {
				"3333432454",
				"4555808220",
				"4049037604",
				"4555782893",
				"10214311282",
				"10714010337",
				"10713981723",
				"10714372526",
				"10714076981",
				"10714392151",
				"11444443576",
			}
		end
		local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://" .. dances[math.random(1, #dances)]
		danceTrack = speaker.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(animation)
		danceTrack.Looped = true
		danceTrack:Play()
	end)

	addcmd("undance", { "nodance" }, function(args, speaker)
		danceTrack:Stop()
		danceTrack:Destroy()
	end)

	addcmd("nolimbs", { "rlimbs" }, function(args, speaker)
		if r15(speaker) then
			for i, v in pairs(speaker.Character:GetChildren()) do
				if
					v:IsA("BasePart") and v.Name == "RightUpperLeg"
					or v.Name == "LeftUpperLeg"
					or v.Name == "RightUpperArm"
					or v.Name == "LeftUpperArm"
				then
					v:Destroy()
				end
			end
		else
			for i, v in pairs(speaker.Character:GetChildren()) do
				if
					v:IsA("BasePart") and v.Name == "Right Leg"
					or v.Name == "Left Leg"
					or v.Name == "Right Arm"
					or v.Name == "Left Arm"
				then
					v:Destroy()
				end
			end
		end
	end)

	addcmd("noarms", { "rarms" }, function(args, speaker)
		if r15(speaker) then
			for i, v in pairs(speaker.Character:GetChildren()) do
				if v:IsA("BasePart") and v.Name == "RightUpperArm" or v.Name == "LeftUpperArm" then
					v:Destroy()
				end
			end
		else
			for i, v in pairs(speaker.Character:GetChildren()) do
				if v:IsA("BasePart") and v.Name == "Right Arm" or v.Name == "Left Arm" then
					v:Destroy()
				end
			end
		end
	end)

	addcmd("nolegs", { "rlegs" }, function(args, speaker)
		if r15(speaker) then
			for i, v in pairs(speaker.Character:GetChildren()) do
				if v:IsA("BasePart") and v.Name == "RightUpperLeg" or v.Name == "LeftUpperLeg" then
					v:Destroy()
				end
			end
		else
			for i, v in pairs(speaker.Character:GetChildren()) do
				if v:IsA("BasePart") and v.Name == "Right Leg" or v.Name == "Left Leg" then
					v:Destroy()
				end
			end
		end
	end)

	addcmd("sit", {}, function(args, speaker)
		speaker.Character:FindFirstChildWhichIsA("Humanoid").Sit = true
	end)

	addcmd("lay", { "laydown" }, function(args, speaker)
		local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
		humanoid.Sit = true
		task.wait(0.1)
		humanoid.RootPart.CFrame = humanoid.RootPart.CFrame * CFrame.Angles(math.pi * 0.5, 0, 0)
		for _, v in ipairs(humanoid:GetPlayingAnimationTracks()) do
			v:Stop()
		end
	end)

	addcmd("sitwalk", {}, function(args, speaker)
		local anims = speaker.Character.Animate
		local sit = anims.sit:FindFirstChildWhichIsA("Animation").AnimationId
		anims.idle:FindFirstChildWhichIsA("Animation").AnimationId = sit
		anims.walk:FindFirstChildWhichIsA("Animation").AnimationId = sit
		anims.run:FindFirstChildWhichIsA("Animation").AnimationId = sit
		anims.jump:FindFirstChildWhichIsA("Animation").AnimationId = sit
		speaker.Character:FindFirstChildWhichIsA("Humanoid").HipHeight = not r15(speaker) and -1.5 or 0.5
	end)

	addcmd("nosit", {}, function(args, speaker)
		speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Seated, false)
	end)

	addcmd("unnosit", {}, function(args, speaker)
		speaker.Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Seated, true)
	end)

	addcmd("jump", {}, function(args, speaker)
		speaker.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
	end)

	local bhopConnection
	local bhopCharConnection

	addcmd("bhop", { "bunnyhop" }, function(args, speaker)
		if bhopConnection then
			bhopConnection:Disconnect()
		end
		if bhopCharConnection then
			bhopCharConnection:Disconnect()
		end

		local function onCharacter(character)
			local humanoid = character:WaitForChild("Humanoid")
			if bhopConnection then
				bhopConnection:Disconnect()
			end
			bhopConnection = RunService.Heartbeat:Connect(function()
				if humanoid and humanoid.FloorMaterial ~= Enum.Material.Air then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end)
		end

		if speaker.Character then
			onCharacter(speaker.Character)
		end
		bhopCharConnection = speaker.CharacterAdded:Connect(onCharacter)
	end)

	addcmd("unbhop", { "unbunnyhop" }, function(args, speaker)
		if bhopConnection then
			bhopConnection:Disconnect()
			bhopConnection = nil
		end
		if bhopCharConnection then
			bhopCharConnection:Disconnect()
			bhopCharConnection = nil
		end
	end)

	local infJump
	infJumpDebounce = false
	addcmd("infjump", { "infinitejump" }, function(args, speaker)
		if infJump then
			infJump:Disconnect()
		end
		infJumpDebounce = false
		infJump = UserInputService.JumpRequest:Connect(function()
			if not infJumpDebounce then
				infJumpDebounce = true
				speaker.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
				wait()
				infJumpDebounce = false
			end
		end)
	end)

	addcmd("uninfjump", { "uninfinitejump", "noinfjump", "noinfinitejump" }, function(args, speaker)
		if infJump then
			infJump:Disconnect()
		end
		infJumpDebounce = false
	end)

	local flyjump
	addcmd("flyjump", {}, function(args, speaker)
		if flyjump then
			flyjump:Disconnect()
		end
		flyjump = UserInputService.JumpRequest:Connect(function()
			speaker.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
		end)
	end)

	addcmd("unflyjump", { "noflyjump" }, function(args, speaker)
		if flyjump then
			flyjump:Disconnect()
		end
	end)

	local HumanModCons = {}
	addcmd("autojump", { "ajump" }, function(args, speaker)
		local Char = speaker.Character
		local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
		local function autoJump()
			if Char and Human then
				local check1 = workspace:FindPartOnRay(
					Ray.new(Human.RootPart.Position - Vector3.new(0, 1.5, 0), Human.RootPart.CFrame.lookVector * 3),
					Human.Parent
				)
				local check2 = workspace:FindPartOnRay(
					Ray.new(Human.RootPart.Position + Vector3.new(0, 1.5, 0), Human.RootPart.CFrame.lookVector * 3),
					Human.Parent
				)
				if check1 or check2 then
					Human.Jump = true
				end
			end
		end
		autoJump()
		HumanModCons.ajLoop = (HumanModCons.ajLoop and HumanModCons.ajLoop:Disconnect() and false)
			or RunService.RenderStepped:Connect(autoJump)
		HumanModCons.ajCA = (HumanModCons.ajCA and HumanModCons.ajCA:Disconnect() and false)
			or speaker.CharacterAdded:Connect(function(nChar)
				Char, Human = nChar, nChar:WaitForChild("Humanoid")
				autoJump()
				HumanModCons.ajLoop = (HumanModCons.ajLoop and HumanModCons.ajLoop:Disconnect() and false)
					or RunService.RenderStepped:Connect(autoJump)
			end)
	end)

	addcmd("unautojump", { "noautojump", "noajump", "unajump" }, function(args, speaker)
		HumanModCons.ajLoop = (HumanModCons.ajLoop and HumanModCons.ajLoop:Disconnect() and false) or nil
		HumanModCons.ajCA = (HumanModCons.ajCA and HumanModCons.ajCA:Disconnect() and false) or nil
	end)

	addcmd("edgejump", { "ejump" }, function(args, speaker)
		local Char = speaker.Character
		local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
		-- Full credit to NoelGamer06 @V3rmillion
		local state
		local laststate
		local lastcf
		local function edgejump()
			if Char and Human then
				laststate = state
				state = Human:GetState()
				if
					laststate ~= state
					and state == Enum.HumanoidStateType.Freefall
					and laststate ~= Enum.HumanoidStateType.Jumping
				then
					Char.Humanoid.RootPart.CFrame = lastcf
					Char.Humanoid.RootPart.Velocity = Vector3.new(
						Char.Humanoid.RootPart.Velocity.X,
						Human.JumpPower or Human.JumpHeight,
						Char.Humanoid.RootPart.Velocity.Z
					)
				end
				lastcf = Char.Humanoid.RootPart.CFrame
			end
		end
		edgejump()
		HumanModCons.ejLoop = (HumanModCons.ejLoop and HumanModCons.ejLoop:Disconnect() and false)
			or RunService.RenderStepped:Connect(edgejump)
		HumanModCons.ejCA = (HumanModCons.ejCA and HumanModCons.ejCA:Disconnect() and false)
			or speaker.CharacterAdded:Connect(function(nChar)
				Char, Human = nChar, nChar:WaitForChild("Humanoid")
				edgejump()
				HumanModCons.ejLoop = (HumanModCons.ejLoop and HumanModCons.ejLoop:Disconnect() and false)
					or RunService.RenderStepped:Connect(edgejump)
			end)
	end)

	addcmd("unedgejump", { "noedgejump", "noejump", "unejump" }, function(args, speaker)
		HumanModCons.ejLoop = (HumanModCons.ejLoop and HumanModCons.ejLoop:Disconnect() and false) or nil
		HumanModCons.ejCA = (HumanModCons.ejCA and HumanModCons.ejCA:Disconnect() and false) or nil
	end)

	addcmd("team", {}, function(args, speaker)
		local teamName = getstring(1, args)
		local team = nil
		local root = speaker.Character and getRoot(speaker.Character)
		for _, v in ipairs(Teams:GetChildren()) do
			if v.Name:lower():match(teamName:lower()) then
				team = v
				break
			end
		end
		if not team then
			return notify("Invalid Team", teamName .. " is not a valid team")
		end
		if root and firetouchinterest then
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("SpawnLocation") and v.BrickColor == team.TeamColor and v.AllowTeamChangeOnTouch == true then
					firetouchinterest(v, root, 0)
					firetouchinterest(v, root, 1)
					break
				end
			end
		else
			speaker.Team = team
		end
	end)

	addcmd("nobgui", { "unbgui", "nobillboardgui", "unbillboardgui", "noname", "rohg" }, function(args, speaker)
		for i, v in pairs(speaker.Character:GetDescendants()) do
			if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
				v:Destroy()
			end
		end
	end)

	addcmd(
		"loopnobgui",
		{ "loopunbgui", "loopnobillboardgui", "loopunbillboardgui", "loopnoname", "looprohg" },
		function(args, speaker)
			for i, v in pairs(speaker.Character:GetDescendants()) do
				if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
					v:Destroy()
				end
			end
			local function charPartAdded(part)
				if part:IsA("BillboardGui") or part:IsA("SurfaceGui") then
					wait()
					part:Destroy()
				end
			end
			charPartTrigger = speaker.Character.DescendantAdded:Connect(charPartAdded)
		end
	)

	addcmd(
		"unloopnobgui",
		{ "unloopunbgui", "unloopnobillboardgui", "unloopunbillboardgui", "unloopnoname", "unlooprohg" },
		function(args, speaker)
			if charPartTrigger then
				charPartTrigger:Disconnect()
			end
		end
	)

	addcmd("spasm", {}, function(args, speaker)
		if not r15(speaker) then
			local pchar = speaker.Character
			local AnimationId = "33796059"
			SpasmAnim = Instance.new("Animation")
			SpasmAnim.AnimationId = "rbxassetid://" .. AnimationId
			Spasm = pchar:FindFirstChildOfClass("Humanoid"):LoadAnimation(SpasmAnim)
			Spasm:Play()
			Spasm:AdjustSpeed(99)
		else
			notify("R6 Required", "This command requires the r6 rig type")
		end
	end)

	addcmd("unspasm", { "nospasm" }, function(args, speaker)
		Spasm:Stop()
		SpasmAnim:Destroy()
	end)

	addcmd("headthrow", {}, function(args, speaker)
		if not r15(speaker) then
			local AnimationId = "35154961"
			local Anim = Instance.new("Animation")
			Anim.AnimationId = "rbxassetid://" .. AnimationId
			local k = speaker.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(Anim)
			k:Play(0)
			k:AdjustSpeed(1)
		else
			notify("R6 Required", "This command requires the r6 rig type")
		end
	end)

	local function anim2track(asset_id)
		local objs = game:GetObjects(asset_id)
		for i = 1, #objs do
			if objs[i]:IsA("Animation") then
				return objs[i].AnimationId
			end
		end
		return asset_id
	end

	addcmd("animation", { "anim" }, function(args, speaker)
		local animid = tostring(args[1])
		if not animid:find("rbxassetid://") then
			animid = "rbxassetid://" .. animid
		end
		animid = anim2track(animid)
		local animation = Instance.new("Animation")
		animation.AnimationId = animid
		local anim = speaker.Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(animation)
		anim.Priority = Enum.AnimationPriority.Movement
		anim:Play()
		if args[2] then
			anim:AdjustSpeed(tostring(args[2]))
		end
	end)

	addcmd("emote", { "em" }, function(args, speaker)
		local anim = humanoid:PlayEmoteAndGetAnimTrackById(args[1])
		if args[2] then
			anim:AdjustSpeed(tostring(args[2]))
		end
	end)

	addcmd("noanim", {}, function(args, speaker)
		speaker.Character.Animate.Disabled = true
	end)

	addcmd("reanim", {}, function(args, speaker)
		speaker.Character.Animate.Disabled = false
	end)

	addcmd("animspeed", {}, function(args, speaker)
		local Char = speaker.Character
		local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

		for i, v in next, Hum:GetPlayingAnimationTracks() do
			v:AdjustSpeed(tonumber(args[1] or 1))
		end
	end)

	addcmd("copyanimation", { "copyanim", "copyemote" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for _, v in ipairs(players) do
			local char = Players[v].Character
			for _, v1 in pairs(speaker.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
				v1:Stop()
			end
			for _, v1 in pairs(Players[v].Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
				if not string.find(v1.Animation.AnimationId, "507768375") then
					local ANIM = speaker.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(v1.Animation)
					ANIM:Play(0.1, 1, v1.Speed)
					ANIM.TimePosition = v1.TimePosition
					task.spawn(function()
						v1.Stopped:Wait()
						ANIM:Stop()
						ANIM:Destroy()
					end)
				end
			end
		end
	end)

	addcmd("copyanimationid", { "copyanimid", "copyemoteid" }, function(args, speaker)
		local copyAnimId = function(player)
			local found = "Animations Copied"

			for _, v in pairs(player.Character:FindFirstChildWhichIsA("Humanoid"):GetPlayingAnimationTracks()) do
				local animationId = v.Animation.AnimationId
				local assetId = animationId:find("rbxassetid://") and animationId:match("%d+")

				if not string.find(animationId, "507768375") and not string.find(animationId, "180435571") then
					if assetId then
						local success, result = pcall(function()
							return MarketplaceService:GetProductInfo(tonumber(assetId)).Name
						end)
						local name = success and result or "Failed to get name"
						found = found .. "\n\nName: " .. name .. "\nAnimation Id: " .. animationId
					else
						found = found .. "\n\nAnimation Id: " .. animationId
					end
				end
			end

			if found ~= "Animations Copied" then
				toClipboard(found)
			else
				notify("Animations", "No animations to copy")
			end
		end

		if args[1] then
			copyAnimId(Players[getPlayer(args[1], speaker)[1]])
		else
			copyAnimId(speaker)
		end
	end)

	addcmd("stopanimations", { "stopanims", "stopanim" }, function(args, speaker)
		local Char = speaker.Character
		local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

		for i, v in next, Hum:GetPlayingAnimationTracks() do
			v:Stop()
		end
	end)

	addcmd("refreshanimations", { "refreshanimation", "refreshanims", "refreshanim" }, function(args, speaker)
		local Char = speaker.Character or speaker.CharacterAdded:Wait()
		local Human = Char and Char:WaitForChild("Humanoid", 15)
		local Animate = Char and Char:WaitForChild("Animate", 15)
		if not Human or not Animate then
			return notify("Refresh Animations", "Failed to get Animate/Humanoid")
		end
		Animate.Disabled = true
		for _, v in ipairs(Human:GetPlayingAnimationTracks()) do
			v:Stop()
		end
		Animate.Disabled = false
	end)

	addcmd("allowcustomanim", { "allowcustomanimations" }, function(args, speaker)
		StarterPlayer.AllowCustomAnimations = true
		execCmd("refreshanimations")
	end)

	addcmd("unallowcustomanim", { "unallowcustomanimations" }, function(args, speaker)
		StarterPlayer.AllowCustomAnimations = false
		execCmd("refreshanimations")
	end)

	addcmd("loopanimation", { "loopanim" }, function(args, speaker)
		local Char = speaker.Character
		local Human = Char and Char.FindFirstChildWhichIsA(Char, "Humanoid")
		for _, v in ipairs(Human.GetPlayingAnimationTracks(Human)) do
			v.Looped = true
		end
	end)

	addcmd("tpposition", { "tppos" }, function(args, speaker)
		if #args < 3 then
			return
		end
		local tpX, tpY, tpZ =
			tonumber((args[1]:gsub(",", ""))), tonumber((args[2]:gsub(",", ""))), tonumber((args[3]:gsub(",", "")))
		local char = speaker.Character
		if char and getRoot(char) then
			getRoot(char).CFrame = CFrame.new(tpX, tpY, tpZ)
		end
	end)

	addcmd("tweentpposition", { "ttppos" }, function(args, speaker)
		if #args < 3 then
			return
		end
		local tpX, tpY, tpZ =
			tonumber((args[1]:gsub(",", ""))), tonumber((args[2]:gsub(",", ""))), tonumber((args[3]:gsub(",", "")))
		local char = speaker.Character
		if char and getRoot(char) then
			TweenService:Create(
				getRoot(speaker.Character),
				TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear),
				{ CFrame = CFrame.new(tpX, tpY, tpZ) }
			):Play()
		end
	end)

	addcmd("offset", {}, function(args, speaker)
		if #args < 3 then
			return
		end
		speaker.Character:TranslateBy(
			Vector3.new(tonumber(args[1]) or 0, tonumber(args[2]) or 0, tonumber(args[3]) or 0)
		)
	end)

	addcmd("tweenoffset", { "toffset" }, function(args, speaker)
		if #args < 3 then
			return
		end
		local tpX, tpY, tpZ = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
		local root = getRoot(speaker.Character)
		local pos = root.Position + Vector3.new(tpX, tpY, tpZ)
		TweenService:Create(root, TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear), { CFrame = CFrame.new(pos) })
			:Play()
		breakVelocity()
	end)

	addcmd("clickteleport", {}, function(args, speaker)
		if speaker ~= Players.LocalPlayer then
			return
		end
		notify("Click TP", "Go to Settings > Keybinds > Add to set up click teleport")
	end)

	addcmd("mouseteleport", { "mousetp" }, function(args, speaker)
		local root = getRoot(speaker.Character)
		local pos = ZYMouse.Hit
		if root and pos then
			root.CFrame = CFrame.new(pos.X, pos.Y + 3, pos.Z, select(4, root.CFrame:components()))
			breakVelocity()
		end
	end)

	addcmd("tptool", { "teleporttool" }, function(args, speaker)
		local TpTool = Instance.new("Tool")
		TpTool.Name = "Teleport Tool"
		TpTool.RequiresHandle = false
		TpTool.Parent = speaker:FindFirstChildOfClass("Backpack")
		TpTool.Activated:Connect(function()
			local root = getRoot(speaker.Character)
			local pos = ZYMouse.Hit
			if not root or not pos then
				return
			end
			root.CFrame = CFrame.new(pos.X, pos.Y + 3, pos.Z, select(4, root.CFrame:components()))
			breakVelocity()
		end)
	end)

	addcmd("thru", {}, function(args, speaker)
		local root = getRoot(speaker.Character)
		local num = tonumber(args[1]) or 5
		local pos = root.CFrame.Position + (root.CFrame.LookVector * num)
		root.CFrame = CFrame.new(pos, pos + root.CFrame.LookVector)
	end)

	addcmd("clickdelete", {}, function(args, speaker)
		if speaker == Players.LocalPlayer then
			notify("Click Delete", "Go to Settings > Keybinds > Add to set up click delete")
		end
	end)

	addcmd("getposition", { "getpos", "notifypos", "notifyposition" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			local char = Players[v].Character
			local pos = char and (getRoot(char) or char:FindFirstChildWhichIsA("BasePart"))
			pos = pos and pos.Position
			if not pos then
				return notify("Getposition Error", "Missing character")
			end
			local roundedPos = math.round(pos.X) .. ", " .. math.round(pos.Y) .. ", " .. math.round(pos.Z)
			notify("Current Position", roundedPos)
		end
	end)

	addcmd("copyposition", { "copypos" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			local char = Players[v].Character
			local pos = char and (getRoot(char) or char:FindFirstChildWhichIsA("BasePart"))
			pos = pos and pos.Position
			if not pos then
				return notify("Getposition Error", "Missing character")
			end
			local roundedPos = math.round(pos.X) .. ", " .. math.round(pos.Y) .. ", " .. math.round(pos.Z)
			toClipboard(roundedPos)
		end
	end)

	addcmd("walktopos", { "walktoposition" }, function(args, speaker)
		if
			speaker.Character:FindFirstChildOfClass("Humanoid")
			and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
		then
			speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
			wait(0.1)
		end
		speaker.Character:FindFirstChildOfClass("Humanoid").WalkToPoint = Vector3.new(args[1], args[2], args[3])
	end)

	addcmd("speed", { "ws", "walkspeed" }, function(args, speaker)
		if args[2] then
			local speed = args[2] or 16
			if isNumber(speed) then
				speaker.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
			end
		else
			local speed = args[1] or 16
			if isNumber(speed) then
				speaker.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
			end
		end
	end)

	addcmd("spoofspeed", { "spoofws", "spoofwalkspeed" }, function(args, speaker)
		if args[1] and isNumber(args[1]) then
			if hookmetamethod then
				local char = speaker.Character
				local setspeed
				local index
				index = hookmetamethod(game, "__index", function(self, key)
					if
						not checkcaller()
						and typeof(self) == "Instance"
						and self:IsA("Humanoid")
						and (key == "WalkSpeed" or key == "walkSpeed")
						and self:IsDescendantOf(char)
					then
						return setspeed or args[1]
					end
					return index(self, key)
				end)
				local newindex
				newindex = hookmetamethod(game, "__newindex", function(self, key, value)
					if
						not checkcaller()
						and typeof(self) == "Instance"
						and self:IsA("Humanoid")
						and (key == "WalkSpeed" or key == "walkSpeed")
						and self:IsDescendantOf(char)
					then
						setspeed = tonumber(value)
					end
					return newindex(self, key, value)
				end)
			else
				notify("Incompatible Exploit", "Your exploit does not support this command (missing hookmetamethod)")
			end
		end
	end)

	addcmd("loopspeed", { "loopws" }, function(args, speaker)
		local speed = args[1] or 16
		if args[2] then
			speed = args[2] or 16
		end
		if isNumber(speed) then
			local Char = speaker.Character or workspace:FindFirstChild(speaker.Name)
			local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
			local function WalkSpeedChange()
				if Char and Human then
					Human.WalkSpeed = speed
				end
			end
			WalkSpeedChange()
			HumanModCons.wsLoop = (HumanModCons.wsLoop and HumanModCons.wsLoop:Disconnect() and false)
				or Human:GetPropertyChangedSignal("WalkSpeed"):Connect(WalkSpeedChange)
			HumanModCons.wsCA = (HumanModCons.wsCA and HumanModCons.wsCA:Disconnect() and false)
				or speaker.CharacterAdded:Connect(function(nChar)
					Char, Human = nChar, nChar:WaitForChild("Humanoid")
					WalkSpeedChange()
					HumanModCons.wsLoop = (HumanModCons.wsLoop and HumanModCons.wsLoop:Disconnect() and false)
						or Human:GetPropertyChangedSignal("WalkSpeed"):Connect(WalkSpeedChange)
				end)
		end
	end)

	addcmd("unloopspeed", { "unloopws" }, function(args, speaker)
		HumanModCons.wsLoop = (HumanModCons.wsLoop and HumanModCons.wsLoop:Disconnect() and false) or nil
		HumanModCons.wsCA = (HumanModCons.wsCA and HumanModCons.wsCA:Disconnect() and false) or nil
	end)

	addcmd("spoofjumppower", { "spoofjp" }, function(args, speaker)
		if args[1] and isNumber(args[1]) then
			if hookmetamethod then
				local char = speaker.Character
				local setpower
				local index
				index = hookmetamethod(game, "__index", function(self, key)
					if
						not checkcaller()
						and typeof(self) == "Instance"
						and self:IsA("Humanoid")
						and (key == "JumpPower" or key == "jumpPower")
						and self:IsDescendantOf(char)
					then
						return setpower or args[1]
					end
					return index(self, key)
				end)
				local newindex
				newindex = hookmetamethod(game, "__newindex", function(self, key, value)
					if
						not checkcaller()
						and typeof(self) == "Instance"
						and self:IsA("Humanoid")
						and (key == "JumpPower" or key == "jumpPower")
						and self:IsDescendantOf(char)
					then
						setpower = tonumber(value)
					end
					return newindex(self, key, value)
				end)
			else
				notify("Incompatible Exploit", "Your exploit does not support this command (missing hookmetamethod)")
			end
		end
	end)

	addcmd("loopjumppower", { "loopjp", "loopjpower" }, function(args, speaker)
		local jpower = args[1] or 50
		if isNumber(jpower) then
			local Char = speaker.Character or workspace:FindFirstChild(speaker.Name)
			local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
			local function JumpPowerChange()
				if Char and Human then
					if speaker.Character:FindFirstChildOfClass("Humanoid").UseJumpPower then
						speaker.Character:FindFirstChildOfClass("Humanoid").JumpPower = jpower
					else
						speaker.Character:FindFirstChildOfClass("Humanoid").JumpHeight = jpower
					end
				end
			end
			JumpPowerChange()
			HumanModCons.jpLoop = (HumanModCons.jpLoop and HumanModCons.jpLoop:Disconnect() and false)
				or Human:GetPropertyChangedSignal("JumpPower"):Connect(JumpPowerChange)
			HumanModCons.jpCA = (HumanModCons.jpCA and HumanModCons.jpCA:Disconnect() and false)
				or speaker.CharacterAdded:Connect(function(nChar)
					Char, Human = nChar, nChar:WaitForChild("Humanoid")
					JumpPowerChange()
					HumanModCons.jpLoop = (HumanModCons.jpLoop and HumanModCons.jpLoop:Disconnect() and false)
						or Human:GetPropertyChangedSignal("JumpPower"):Connect(JumpPowerChange)
				end)
		end
	end)

	addcmd("unloopjumppower", { "unloopjp", "unloopjpower" }, function(args, speaker)
		local Char = speaker.Character or workspace:FindFirstChild(speaker.Name)
		local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
		HumanModCons.jpLoop = (HumanModCons.jpLoop and HumanModCons.jpLoop:Disconnect() and false) or nil
		HumanModCons.jpCA = (HumanModCons.jpCA and HumanModCons.jpCA:Disconnect() and false) or nil
		if Char and Human then
			if speaker.Character:FindFirstChildOfClass("Humanoid").UseJumpPower then
				speaker.Character:FindFirstChildOfClass("Humanoid").JumpPower = 50
			else
				speaker.Character:FindFirstChildOfClass("Humanoid").JumpHeight = 50
			end
		end
	end)

	addcmd("tools", { "gears" }, function(args, speaker)
		local function copy(instance)
			for i, c in pairs(instance:GetChildren()) do
				if c:IsA("Tool") or c:IsA("HopperBin") then
					c:Clone().Parent = speaker:FindFirstChildOfClass("Backpack")
				end
				copy(c)
			end
		end
		copy(Lighting)
		local function copy(instance)
			for i, c in pairs(instance:GetChildren()) do
				if c:IsA("Tool") or c:IsA("HopperBin") then
					c:Clone().Parent = speaker:FindFirstChildOfClass("Backpack")
				end
				copy(c)
			end
		end
		copy(ReplicatedStorage)
		notify("Tools", "Copied tools from ReplicatedStorage and Lighting")
	end)

	addcmd("notools", { "rtools", "clrtools", "removetools", "deletetools", "dtools" }, function(args, speaker)
		for i, v in pairs(speaker:FindFirstChildOfClass("Backpack"):GetDescendants()) do
			if v:IsA("Tool") or v:IsA("HopperBin") then
				v:Destroy()
			end
		end
		for i, v in pairs(speaker.Character:GetDescendants()) do
			if v:IsA("Tool") or v:IsA("HopperBin") then
				v:Destroy()
			end
		end
	end)

	addcmd("deleteselectedtool", { "dst" }, function(args, speaker)
		for i, v in pairs(speaker.Character:GetDescendants()) do
			if v:IsA("Tool") or v:IsA("HopperBin") then
				v:Destroy()
			end
		end
	end)

	addcmd("console", {}, function(args, speaker)
		StarterGui:SetCore("DevConsoleVisible", true)
	end)

	addcmd("oldconsole", {}, function(args, speaker)
		-- Thanks wally!!
		notify("Loading", "Hold on a sec")
		local _, str = pcall(function()
			return game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/console.lua", true)
		end)

		local s, e = loadstring(str)
		if typeof(s) ~= "function" then
			return
		end

		local success, message = pcall(s)
		if not success then
			if printconsole then
				printconsole(message)
			elseif printoutput then
				printoutput(message)
			end
		end
		wait(1)
		notify("Console", "Press F9 to open the console")
	end)

	addcmd("explorer", { "dex" }, function(args, speaker)
		notify("Loading", "Hold on a sec")
		loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()
	end)

	addcmd("moondex", { "mdex" }, function(args, speaker)
		notify("Loading", "Hold on a sec")
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
	end)

	addcmd("remotespy", { "rspy", "cobalt", "cspy" }, function(args, speaker)
		notify("Loading", "Hold on a sec")
		-- Full credit to notpoiu, creator of Cobalt
		loadstring(game:HttpGet("https://gitlab.com/upio/cobalt/-/releases/permalink/latest/downloads/Cobalt.luau"))()
	end)

	addcmd("simplespy", { "sspy" }, function(args, speaker)
		notify("Loading", "Hold on a sec")
		-- Full credit to exx, creator of SimpleSpy
		-- also thanks to Amity for fixing
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
	end)

	addcmd("audiologger", { "alogger" }, function(args, speaker)
		notify("Loading", "Hold on a sec")
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/audiologger.lua", true))()
	end)

	local loopgoto = nil
	addcmd("loopgoto", {}, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			loopgoto = nil
			if
				speaker.Character:FindFirstChildOfClass("Humanoid")
				and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
			then
				speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
				wait(0.1)
			end
			loopgoto = Players[v]
			local distance = 3
			if args[2] and isNumber(args[2]) then
				distance = args[2]
			end
			local lDelay = 0
			if args[3] and isNumber(args[3]) then
				lDelay = args[3]
			end
			repeat
				if Players:FindFirstChild(v) then
					if Players[v].Character ~= nil then
						getRoot(speaker.Character).CFrame = getRoot(Players[v].Character).CFrame
							+ Vector3.new(distance, 1, 0)
					end
					wait(lDelay)
				else
					loopgoto = nil
				end
			until loopgoto ~= Players[v]
		end
	end)

	addcmd("unloopgoto", { "noloopgoto" }, function(args, speaker)
		loopgoto = nil
	end)

	addcmd("headsit", {}, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		if headSit then
			headSit:Disconnect()
		end
		for i, v in pairs(players) do
			speaker.Character:FindFirstChildOfClass("Humanoid").Sit = true
			headSit = RunService.Heartbeat:Connect(function()
				if
					Players:FindFirstChild(Players[v].Name)
					and Players[v].Character ~= nil
					and getRoot(Players[v].Character)
					and getRoot(speaker.Character)
					and speaker.Character:FindFirstChildOfClass("Humanoid").Sit == true
				then
					getRoot(speaker.Character).CFrame = getRoot(Players[v].Character).CFrame
						* CFrame.Angles(0, math.rad(0), 0)
						* CFrame.new(0, 1.6, 0.4)
				else
					headSit:Disconnect()
				end
			end)
		end
	end)

	addcmd("chat", { "say" }, function(args, speaker)
		local cString = getstring(1, args)
		chatMessage(cString)
	end)

	spamming = false
	spamspeed = 1
	addcmd("spam", {}, function(args, speaker)
		spamming = true
		local spamstring = getstring(1, args)
		repeat
			wait(spamspeed)
			chatMessage(spamstring)
		until spamming == false
	end)

	addcmd("nospam", { "unspam" }, function(args, speaker)
		spamming = false
	end)

	addcmd("whisper", { "pm" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			task.spawn(function()
				local plrName = Players[v].Name
				local pmstring = getstring(2, args)
				chatMessage("/w " .. plrName .. " " .. pmstring)
			end)
		end
	end)

	pmspamming = {}
	addcmd("pmspam", {}, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			task.spawn(function()
				local plrName = Players[v].Name
				if FindInTable(pmspamming, plrName) then
					return
				end
				table.insert(pmspamming, plrName)
				local pmspamstring = getstring(2, args)
				repeat
					if Players:FindFirstChild(v) then
						wait(spamspeed)
						chatMessage("/w " .. plrName .. " " .. pmspamstring)
					else
						for a, b in pairs(pmspamming) do
							if b == plrName then
								table.remove(pmspamming, a)
							end
						end
					end
				until not FindInTable(pmspamming, plrName)
			end)
		end
	end)

	addcmd("nopmspam", { "unpmspam" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			task.spawn(function()
				for a, b in pairs(pmspamming) do
					if b == Players[v].Name then
						table.remove(pmspamming, a)
					end
				end
			end)
		end
	end)

	addcmd("spamspeed", {}, function(args, speaker)
		local speed = args[1] or 1
		if isNumber(speed) then
			spamspeed = speed
		end
	end)

	addcmd("bubblechat", {}, function(args, speaker)
		if isLegacyChat then
			ChatService.BubbleChatEnabled = true
		else
			TextChatService.BubbleChatConfiguration.Enabled = true
		end
	end)

	addcmd("unbubblechat", { "nobubblechat" }, function(args, speaker)
		if isLegacyChat then
			ChatService.BubbleChatEnabled = false
		else
			TextChatService.BubbleChatConfiguration.Enabled = false
		end
	end)

	addcmd("chatwindow", {}, function(args, speaker)
		TextChatService.ChatWindowConfiguration.Enabled = true
	end)

	addcmd("unchatwindow", { "nochatwindow" }, function(args, speaker)
		TextChatService.ChatWindowConfiguration.Enabled = false
	end)

	addcmd("darkchat", {}, function(args, speaker)
		local BCC = TextChatService:FindFirstChildOfClass("BubbleChatConfiguration")
		local CWC = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
		local CIBC = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
		if BCC then
			BCC.Enabled = true
			BCC.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			BCC.BackgroundTransparency = 0.3
			BCC.TailVisible = true
			BCC.TextColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
		end
		if CWC then
			CWC.Enabled = true
			CWC.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			CWC.BackgroundTransparency = 0.3
			CWC.TextColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
			CWC.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
			CWC.TextStrokeTransparency = 0.5
		end
		if CIBC then
			CIBC.Enabled = true
			CIBC.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			CIBC.BackgroundTransparency = 0.5
			CIBC.PlaceholderColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
			CIBC.TextColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF)
			CIBC.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
			CIBC.TextStrokeTransparency = 0.5
		end
	end)

	addcmd("blockhead", {}, function(args, speaker)
		speaker.Character.Head:FindFirstChildOfClass("SpecialMesh"):Destroy()
	end)

	addcmd("blockhats", {}, function(args, speaker)
		for _, v in pairs(speaker.Character:FindFirstChildOfClass("Humanoid"):GetAccessories()) do
			for i, c in pairs(v:GetDescendants()) do
				if c:IsA("SpecialMesh") then
					c:Destroy()
				end
			end
		end
	end)

	addcmd("blocktool", {}, function(args, speaker)
		for _, v in pairs(speaker.Character:GetChildren()) do
			if v:IsA("Tool") or v:IsA("HopperBin") then
				for i, c in pairs(v:GetDescendants()) do
					if c:IsA("SpecialMesh") then
						c:Destroy()
					end
				end
			end
		end
	end)

	addcmd("creeper", {}, function(args, speaker)
		if r15(speaker) then
			speaker.Character.Head:FindFirstChildOfClass("SpecialMesh"):Destroy()
			speaker.Character.LeftUpperArm:Destroy()
			speaker.Character.RightUpperArm:Destroy()
			speaker.Character:FindFirstChildOfClass("Humanoid"):RemoveAccessories()
		else
			speaker.Character.Head:FindFirstChildOfClass("SpecialMesh"):Destroy()
			speaker.Character["Left Arm"]:Destroy()
			speaker.Character["Right Arm"]:Destroy()
			speaker.Character:FindFirstChildOfClass("Humanoid"):RemoveAccessories()
		end
	end)

	function getTorso(x)
		x = x or Players.LocalPlayer.Character
		return x:FindFirstChild("Torso")
			or x:FindFirstChild("UpperTorso")
			or x:FindFirstChild("LowerTorso")
			or x:FindFirstChild("HumanoidRootPart")
	end

	addcmd("bang", { "rape" }, function(args, speaker)
		execCmd("unbang")
		wait()
		local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
		bangAnim = Instance.new("Animation")
		bangAnim.AnimationId = not r15(speaker) and "rbxassetid://148840371" or "rbxassetid://5918726674"
		bang = humanoid:LoadAnimation(bangAnim)
		bang:Play(0.1, 1, 1)
		bang:AdjustSpeed(args[2] or 3)
		bangDied = humanoid.Died:Connect(function()
			bang:Stop()
			bangAnim:Destroy()
			bangDied:Disconnect()
			bangLoop:Disconnect()
		end)
		if args[1] then
			local players = getPlayer(args[1], speaker)
			for _, v in pairs(players) do
				local bangplr = Players[v].Name
				local bangOffet = CFrame.new(0, 0, 1.1)
				bangLoop = RunService.Stepped:Connect(function()
					pcall(function()
						local otherRoot = getTorso(Players[bangplr].Character)
						getRoot(speaker.Character).CFrame = otherRoot.CFrame * bangOffet
					end)
				end)
				break
			end
		end
	end)

	addcmd("unbang", { "unrape" }, function(args, speaker)
		if bangDied then
			bangDied:Disconnect()
			bang:Stop()
			bangAnim:Destroy()
			bangLoop:Disconnect()
		end
	end)

	addcmd("carpet", {}, function(args, speaker)
		if not r15(speaker) then
			execCmd("uncarpet")
			wait()
			local players = getPlayer(args[1], speaker)
			for i, v in pairs(players) do
				carpetAnim = Instance.new("Animation")
				carpetAnim.AnimationId = "rbxassetid://282574440"
				carpet = speaker.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(carpetAnim)
				carpet:Play(0.1, 1, 1)
				local carpetplr = Players[v].Name
				carpetDied = speaker.Character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
					carpetLoop:Disconnect()
					carpet:Stop()
					carpetAnim:Destroy()
					carpetDied:Disconnect()
				end)
				carpetLoop = RunService.Heartbeat:Connect(function()
					pcall(function()
						getRoot(Players.LocalPlayer.Character).CFrame = getRoot(Players[carpetplr].Character).CFrame
					end)
				end)
			end
		else
			notify("R6 Required", "This command requires the r6 rig type")
		end
	end)

	addcmd("uncarpet", { "nocarpet" }, function(args, speaker)
		if carpetLoop then
			carpetLoop:Disconnect()
			carpetDied:Disconnect()
			carpet:Stop()
			carpetAnim:Destroy()
		end
	end)

	addcmd("friend", {}, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			speaker:RequestFriendship(Players[v])
		end
	end)

	addcmd("unfriend", {}, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			speaker:RevokeFriendship(Players[v])
		end
	end)

	addcmd("bringpart", {}, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v.Name:lower() == getstring(1, args):lower() and v:IsA("BasePart") then
				v.CFrame = getRoot(speaker.Character).CFrame
			end
		end
	end)

	addcmd("bringpartclass", { "bpc" }, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v.ClassName:lower() == getstring(1, args):lower() and v:IsA("BasePart") then
				v.CFrame = getRoot(speaker.Character).CFrame
			end
		end
	end)

	gotopartDelay = 0.1
	addcmd("gotopart", { "topart" }, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v.Name:lower() == getstring(1, args):lower() and v:IsA("BasePart") then
				if
					speaker.Character:FindFirstChildOfClass("Humanoid")
					and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
				then
					speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
					wait(0.1)
				end
				wait(gotopartDelay)
				getRoot(speaker.Character).CFrame = v.CFrame
			end
		end
	end)

	addcmd("tweengotopart", { "tgotopart", "ttopart" }, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v.Name:lower() == getstring(1, args):lower() and v:IsA("BasePart") then
				if
					speaker.Character:FindFirstChildOfClass("Humanoid")
					and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
				then
					speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
					wait(0.1)
				end
				wait(gotopartDelay)
				TweenService:Create(
					getRoot(speaker.Character),
					TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear),
					{ CFrame = v.CFrame }
				):Play()
			end
		end
	end)

	addcmd("gotopartclass", { "gpc" }, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v.ClassName:lower() == getstring(1, args):lower() and v:IsA("BasePart") then
				if
					speaker.Character:FindFirstChildOfClass("Humanoid")
					and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
				then
					speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
					wait(0.1)
				end
				wait(gotopartDelay)
				getRoot(speaker.Character).CFrame = v.CFrame
			end
		end
	end)

	addcmd("tweengotopartclass", { "tgpc" }, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v.ClassName:lower() == getstring(1, args):lower() and v:IsA("BasePart") then
				if
					speaker.Character:FindFirstChildOfClass("Humanoid")
					and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
				then
					speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
					wait(0.1)
				end
				wait(gotopartDelay)
				TweenService:Create(
					getRoot(speaker.Character),
					TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear),
					{ CFrame = v.CFrame }
				):Play()
			end
		end
	end)

	addcmd("gotomodel", { "tomodel" }, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v.Name:lower() == getstring(1, args):lower() and v:IsA("Model") then
				if
					speaker.Character:FindFirstChildOfClass("Humanoid")
					and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
				then
					speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
					wait(0.1)
				end
				wait(gotopartDelay)
				getRoot(speaker.Character).CFrame = v:GetModelCFrame()
			end
		end
	end)

	addcmd("tweengotomodel", { "tgotomodel", "ttomodel" }, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v.Name:lower() == getstring(1, args):lower() and v:IsA("Model") then
				if
					speaker.Character:FindFirstChildOfClass("Humanoid")
					and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
				then
					speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
					wait(0.1)
				end
				wait(gotopartDelay)
				TweenService:Create(
					getRoot(speaker.Character),
					TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear),
					{ CFrame = v:GetModelCFrame() }
				):Play()
			end
		end
	end)

	addcmd("gotopartdelay", {}, function(args, speaker)
		local gtpDelay = args[1] or 0.1
		if isNumber(gtpDelay) then
			gotopartDelay = gtpDelay
		end
	end)

	addcmd("noclickdetectorlimits", { "nocdlimits", "removecdlimits" }, function(args, speaker)
		for i, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("ClickDetector") then
				v.MaxActivationDistance = math.huge
			end
		end
	end)

	addcmd("fireclickdetectors", { "firecd", "firecds" }, function(args, speaker)
		if fireclickdetector then
			if args[1] then
				local name = getstring(1, args):lower()
				for _, descendant in ipairs(workspace:GetDescendants()) do
					if
						descendant:IsA("ClickDetector") and descendant.Name:lower() == name
						or descendant.Parent.Name:lower() == name
					then
						fireclickdetector(descendant)
					end
				end
			else
				for _, descendant in ipairs(workspace:GetDescendants()) do
					if descendant:IsA("ClickDetector") then
						fireclickdetector(descendant)
					end
				end
			end
		else
			notify("Incompatible Exploit", "Your exploit does not support this command (missing fireclickdetector)")
		end
	end)

	addcmd("noproximitypromptlimits", { "nopplimits", "removepplimits" }, function(args, speaker)
		for i, v in pairs(workspace:GetDescendants()) do
			if v:IsA("ProximityPrompt") then
				v.MaxActivationDistance = math.huge
			end
		end
	end)

	addcmd("fireproximityprompts", { "firepp" }, function(args, speaker)
		if fireproximityprompt then
			if args[1] then
				local name = getstring(1, args)
				for _, descendant in ipairs(workspace:GetDescendants()) do
					if
						descendant:IsA("ProximityPrompt") and descendant.Name == name
						or descendant.Parent.Name == name
					then
						fireproximityprompt(descendant)
					end
				end
			else
				for _, descendant in ipairs(workspace:GetDescendants()) do
					if descendant:IsA("ProximityPrompt") then
						fireproximityprompt(descendant)
					end
				end
			end
		else
			notify("Incompatible Exploit", "Your exploit does not support this command (missing fireproximityprompt)")
		end
	end)

	local PromptButtonHoldBegan = nil
	addcmd("instantproximityprompts", { "instantpp" }, function(args, speaker)
		if fireproximityprompt then
			execCmd("uninstantproximityprompts")
			wait(0.1)
			PromptButtonHoldBegan = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
				fireproximityprompt(prompt)
			end)
		else
			notify("Incompatible Exploit", "Your exploit does not support this command (missing fireproximityprompt)")
		end
	end)

	addcmd("uninstantproximityprompts", { "uninstantpp" }, function(args, speaker)
		if PromptButtonHoldBegan ~= nil then
			PromptButtonHoldBegan:Disconnect()
			PromptButtonHoldBegan = nil
		end
	end)

	addcmd("notifyping", { "ping" }, function(args, speaker)
		notify("Ping", math.round(speaker:GetNetworkPing() * 1000) .. "ms")
	end)

	addcmd("grabtools", {}, function(args, speaker)
		local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
		for _, child in ipairs(workspace:GetChildren()) do
			if speaker.Character and child:IsA("BackpackItem") and child:FindFirstChild("Handle") then
				humanoid:EquipTool(child)
			end
		end

		if grabtoolsFunc then
			grabtoolsFunc:Disconnect()
		end

		grabtoolsFunc = workspace.ChildAdded:Connect(function(child)
			if speaker.Character and child:IsA("BackpackItem") and child:FindFirstChild("Handle") then
				humanoid:EquipTool(child)
			end
		end)

		notify("Grabtools", "Picking up any dropped tools")
	end)

	addcmd("nograbtools", { "ungrabtools" }, function(args, speaker)
		if grabtoolsFunc then
			grabtoolsFunc:Disconnect()
		end

		notify("Grabtools", "Grabtools has been disabled")
	end)

	local specifictoolremoval = {}
	addcmd("removespecifictool", {}, function(args, speaker)
		if args[1] and speaker:FindFirstChildOfClass("Backpack") then
			local tool = string.lower(getstring(1, args))
			local RST = RunService.RenderStepped:Connect(function()
				if speaker:FindFirstChildOfClass("Backpack") then
					for i, v in pairs(speaker:FindFirstChildOfClass("Backpack"):GetChildren()) do
						if v.Name:lower() == tool then
							v:Remove()
						end
					end
				end
			end)
			specifictoolremoval[tool] = RST
		end
	end)

	addcmd("unremovespecifictool", {}, function(args, speaker)
		if args[1] then
			local tool = string.lower(getstring(1, args))
			if specifictoolremoval[tool] ~= nil then
				specifictoolremoval[tool]:Disconnect()
				specifictoolremoval[tool] = nil
			end
		end
	end)

	addcmd("clearremovespecifictool", {}, function(args, speaker)
		for obj in pairs(specifictoolremoval) do
			specifictoolremoval[obj]:Disconnect()
			specifictoolremoval[obj] = nil
		end
	end)

	addcmd("light", {}, function(args, speaker)
		local light = Instance.new("PointLight")
		light.Parent = getRoot(speaker.Character)
		light.Range = 30
		if args[1] then
			light.Brightness = args[2]
			light.Range = args[1]
		else
			light.Brightness = 5
		end
	end)

	addcmd("unlight", { "nolight" }, function(args, speaker)
		for i, v in pairs(speaker.Character:GetDescendants()) do
			if v.ClassName == "PointLight" then
				v:Destroy()
			end
		end
	end)

	addcmd("copytools", {}, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			task.spawn(function()
				for i, v in pairs(Players[v]:FindFirstChildOfClass("Backpack"):GetChildren()) do
					if v:IsA("Tool") or v:IsA("HopperBin") then
						v:Clone().Parent = speaker:FindFirstChildOfClass("Backpack")
					end
				end
			end)
		end
	end)

	addcmd("naked", {}, function(args, speaker)
		for i, v in pairs(speaker.Character:GetDescendants()) do
			if v:IsA("Clothing") or v:IsA("ShirtGraphic") then
				v:Destroy()
			end
		end
	end)

	addcmd("noface", { "removeface" }, function(args, speaker)
		for i, v in pairs(speaker.Character:GetDescendants()) do
			if v:IsA("Decal") and v.Name == "face" then
				v:Destroy()
			end
		end
	end)

	addcmd("spawnpoint", { "spawn" }, function(args, speaker)
		spawnpos = getRoot(speaker.Character).CFrame
		spawnpoint = true
		spDelay = tonumber(args[1]) or 0.1
		notify("Spawn Point", "Spawn point created at " .. tostring(spawnpos))
	end)

	addcmd("nospawnpoint", { "nospawn", "removespawnpoint" }, function(args, speaker)
		spawnpoint = false
		notify("Spawn Point", "Removed spawn point")
	end)

	addcmd("flashback", { "diedtp" }, function(args, speaker)
		if lastDeath ~= nil then
			if
				speaker.Character:FindFirstChildOfClass("Humanoid")
				and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
			then
				speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
				wait(0.1)
			end
			getRoot(speaker.Character).CFrame = lastDeath
		end
	end)

	addcmd("hatspin", { "spinhats" }, function(args, speaker)
		execCmd("unhatspin")
		wait(0.5)
		for _, v in pairs(speaker.Character:FindFirstChildOfClass("Humanoid"):GetAccessories()) do
			local keep = Instance.new("BodyPosition")
			keep.Name = randomString()
			keep.Parent = v.Handle
			local spin = Instance.new("BodyAngularVelocity")
			spin.Name = randomString()
			spin.Parent = v.Handle
			v.Handle:FindFirstChildOfClass("Weld"):Destroy()
			if args[1] then
				spin.AngularVelocity = Vector3.new(0, args[1], 0)
				spin.MaxTorque = Vector3.new(0, args[1] * 2, 0)
			else
				spin.AngularVelocity = Vector3.new(0, 100, 0)
				spin.MaxTorque = Vector3.new(0, 200, 0)
			end
			keep.P = 30000
			keep.D = 50
			spinhats = RunService.Stepped:Connect(function()
				pcall(function()
					keep.Position = Players.LocalPlayer.Character.Head.Position
				end)
			end)
		end
	end)

	addcmd("unhatspin", { "unspinhats" }, function(args, speaker)
		if spinhats then
			spinhats:Disconnect()
		end
		for _, v in pairs(speaker.Character:FindFirstChildOfClass("Humanoid"):GetAccessories()) do
			v.Parent = workspace
			for i, c in pairs(v.Handle) do
				if c:IsA("BodyPosition") or c:IsA("BodyAngularVelocity") then
					c:Destroy()
				end
			end
			wait()
			v.Parent = speaker.Character
		end
	end)

	addcmd("clearhats", { "cleanhats" }, function(args, speaker)
		if firetouchinterest then
			local Player = Players.LocalPlayer
			local Character = Player.Character
			local Old = getRoot(Character).CFrame
			local Hats = {}

			for _, child in ipairs(workspace:GetChildren()) do
				if child:IsA("Accessory") then
					table.insert(Hats, child)
				end
			end

			for _, accessory in ipairs(Character:FindFirstChildOfClass("Humanoid"):GetAccessories()) do
				accessory:Destroy()
			end

			for i = 1, #Hats do
				repeat
					RunService.Heartbeat:wait()
				until Hats[i]
				firetouchinterest(Hats[i].Handle, getRoot(Character), 0)
				repeat
					RunService.Heartbeat:wait()
				until Character:FindFirstChildOfClass("Accessory")
				Character:FindFirstChildOfClass("Accessory"):Destroy()
				repeat
					RunService.Heartbeat:wait()
				until not Character:FindFirstChildOfClass("Accessory")
			end

			execCmd("reset")

			Player.CharacterAdded:Wait()

			for i = 1, 20 do
				RunService.Heartbeat:Wait()
				if getRoot(Player.Character) then
					getRoot(Player.Character).Humanoid.RootPart.CFrame = Old
				end
			end
		else
			notify("Incompatible Exploit", "Your exploit does not support this command (missing firetouchinterest)")
		end
	end)

	addcmd("split", {}, function(args, speaker)
		if r15(speaker) then
			speaker.Character.UpperTorso.Waist:Destroy()
		else
			notify("R15 Required", "This command requires the r15 rig type")
		end
	end)

	addcmd("nilchar", {}, function(args, speaker)
		if speaker.Character ~= nil then
			speaker.Character.Parent = nil
		end
	end)

	addcmd("unnilchar", { "nonilchar" }, function(args, speaker)
		if speaker.Character ~= nil then
			speaker.Character.Parent = workspace
		end
	end)

	addcmd("noroot", { "removeroot", "rroot" }, function(args, speaker)
		if speaker.Character ~= nil then
			local char = Players.LocalPlayer.Character
			char.Parent = nil
			char.Humanoid.RootPart:Destroy()
			char.Parent = workspace
		end
	end)

	addcmd("replaceroot", { "replacerootpart" }, function(args, speaker)
		if speaker.Character ~= nil and getRoot(speaker.Character) then
			local Char = speaker.Character
			local OldParent = Char.Parent
			local HRP = Char and getRoot(Char)
			local OldPos = HRP.CFrame
			Char.Parent = game
			local HRP1 = HRP:Clone()
			HRP1.Parent = Char
			HRP = HRP:Destroy()
			HRP1.CFrame = OldPos
			Char.Parent = OldParent
		end
	end)

	addcmd("clearcharappearance", { "clearchar", "clrchar" }, function(args, speaker)
		speaker:ClearCharacterAppearance()
	end)

	addcmd("equiptools", {}, function(args, speaker)
		for i, v in pairs(speaker:FindFirstChildOfClass("Backpack"):GetChildren()) do
			if v:IsA("Tool") or v:IsA("HopperBin") then
				v.Parent = speaker.Character
			end
		end
	end)

	addcmd("unequiptools", {}, function(args, speaker)
		speaker.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
	end)

	local function GetHandleTools(p)
		p = p or Players.LocalPlayer
		local r = {}
		for _, v in ipairs(p.Character and p.Character:GetChildren() or {}) do
			if v.IsA(v, "BackpackItem") and v.FindFirstChild(v, "Handle") then
				r[#r + 1] = v
			end
		end
		for _, v in ipairs(p.Backpack:GetChildren()) do
			if v.IsA(v, "BackpackItem") and v.FindFirstChild(v, "Handle") then
				r[#r + 1] = v
			end
		end
		return r
	end
	addcmd("dupetools", { "clonetools" }, function(args, speaker)
		local LOOP_NUM = tonumber(args[1]) or 1
		local OrigPos = speaker.Character.Humanoid.RootPart.Position
		local Tools, TempPos = {}, Vector3.new(math.random(-2e5, 2e5), 2e5, math.random(-2e5, 2e5))
		for i = 1, LOOP_NUM do
			local Human = speaker.Character:WaitForChild("Humanoid")
			Human.Parent:MoveTo(TempPos)
			wait(0.1)
			Human.RootPart.Anchored = speaker:ClearCharacterAppearance(wait(0.1)) or true
			local t = GetHandleTools(speaker)
			while #t > 0 do
				for _, v in ipairs(t) do
					task.spawn(function()
						for _ = 1, 25 do
							v.Parent = speaker.Character
							v.Handle.Anchored = true
						end
						for _ = 1, 5 do
							v.Parent = workspace
						end
						table.insert(Tools, v.Handle)
					end)
				end
				t = GetHandleTools(speaker)
			end
			wait(0.1)
			speaker.Character = speaker.Character:Destroy()
			speaker.CharacterAdded
				:Wait()
				:WaitForChild("Humanoid").Parent
				:MoveTo(LOOP_NUM == i and OrigPos or TempPos, wait(0.1))
			if i == LOOP_NUM or i % 5 == 0 then
				local HRP = speaker.Character.Humanoid.RootPart
				if type(firetouchinterest) == "function" then
					for _, v in ipairs(Tools) do
						v.Anchored = not firetouchinterest(v, HRP, 1, firetouchinterest(v, HRP, 0)) and false or false
					end
				else
					for _, v in ipairs(Tools) do
						task.spawn(function()
							local x = v.CanCollide
							v.CanCollide = false
							v.Anchored = false
							for _ = 1, 10 do
								v.CFrame = HRP.CFrame
								wait()
							end
							v.CanCollide = x
						end)
					end
				end
				wait(0.1)
				Tools = {}
			end
			TempPos = TempPos + Vector3.new(10, math.random(-5, 5), 0)
		end
	end)

	addcmd("touchinterests", { "touchinterest", "firetouchinterests", "firetouchinterest" }, function(args, speaker)
		local Root = getRoot(speaker.Character) or speaker.Character:FindFirstChildWhichIsA("BasePart")

		if not firetouchinterest then
			notify("Incompatible Exploit", "Your exploit does not support this command (missing firetouchinterest)")
			return
		end

		local function Touch(x)
			x = x.FindFirstAncestorWhichIsA(x, "Part")
			if x then
				return task.spawn(function()
					firetouchinterest(x, Root, 1, wait() and firetouchinterest(x, Root, 0))
				end)
			end
			x.CFrame = Root.CFrame
		end

		if args[1] then
			local name = getstring(1, args):lower()
			print(name .. " -name")
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("TouchTransmitter") and v.Name:lower() == name or v.Parent.Name:lower() == name then
					Touch(v)
				end
			end
		else
			for _, v in ipairs(workspace:GetDescendants()) do
				if v.IsA(v, "TouchTransmitter") then
					Touch(v)
				end
			end
		end
	end)

	addcmd("fullbright", { "fb", "fullbrightness" }, function(args, speaker)
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
		Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	end)

	addcmd("loopfullbright", { "loopfb" }, function(args, speaker)
		if brightLoop then
			brightLoop:Disconnect()
		end
		local function brightFunc()
			Lighting.Brightness = 2
			Lighting.ClockTime = 14
			Lighting.FogEnd = 100000
			Lighting.GlobalShadows = false
			Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
		end

		brightLoop = RunService.RenderStepped:Connect(brightFunc)
	end)

	addcmd("unloopfullbright", { "unloopfb" }, function(args, speaker)
		if brightLoop then
			brightLoop:Disconnect()
		end
	end)

	addcmd("ambient", {}, function(args, speaker)
		Lighting.Ambient = Color3.new(args[1], args[2], args[3])
		Lighting.OutdoorAmbient = Color3.new(args[1], args[2], args[3])
	end)

	addcmd("day", {}, function(args, speaker)
		Lighting.ClockTime = 14
	end)

	addcmd("night", {}, function(args, speaker)
		Lighting.ClockTime = 0
	end)

	addcmd("nofog", {}, function(args, speaker)
		Lighting.FogEnd = 100000
		for i, v in pairs(Lighting:GetDescendants()) do
			if v:IsA("Atmosphere") then
				v:Destroy()
			end
		end
	end)

	addcmd("brightness", {}, function(args, speaker)
		Lighting.Brightness = args[1]
	end)

	addcmd("globalshadows", { "gshadows" }, function(args, speaker)
		Lighting.GlobalShadows = true
	end)

	addcmd("unglobalshadows", { "nogshadows", "ungshadows", "noglobalshadows" }, function(args, speaker)
		Lighting.GlobalShadows = false
	end)

	origsettings = {
		abt = Lighting.Ambient,
		oabt = Lighting.OutdoorAmbient,
		brt = Lighting.Brightness,
		time = Lighting.ClockTime,
		fe = Lighting.FogEnd,
		fs = Lighting.FogStart,
		gs = Lighting.GlobalShadows,
	}

	addcmd("restorelighting", { "rlighting" }, function(args, speaker)
		Lighting.Ambient = origsettings.abt
		Lighting.OutdoorAmbient = origsettings.oabt
		Lighting.Brightness = origsettings.brt
		Lighting.ClockTime = origsettings.time
		Lighting.FogEnd = origsettings.fe
		Lighting.FogStart = origsettings.fs
		Lighting.GlobalShadows = origsettings.gs
	end)

	addcmd("stun", { "platformstand" }, function(args, speaker)
		speaker.Character:FindFirstChildOfClass("Humanoid").PlatformStand = true
	end)

	addcmd("unstun", { "nostun", "unplatformstand", "noplatformstand" }, function(args, speaker)
		speaker.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
	end)

	addcmd("norotate", { "noautorotate" }, function(args, speaker)
		speaker.Character:FindFirstChildOfClass("Humanoid").AutoRotate = false
	end)

	addcmd("unnorotate", { "autorotate" }, function(args, speaker)
		speaker.Character:FindFirstChildOfClass("Humanoid").AutoRotate = true
	end)

	addcmd("enablestate", {}, function(args, speaker)
		local x = args[1]
		if not tonumber(x) then
			local x = Enum.HumanoidStateType[args[1]]
		end
		speaker.Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(x, true)
	end)

	addcmd("disablestate", {}, function(args, speaker)
		local x = args[1]
		if not tonumber(x) then
			local x = Enum.HumanoidStateType[args[1]]
		end
		speaker.Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(x, false)
	end)

	addcmd("drophats", { "drophat" }, function(args, speaker)
		if speaker.Character then
			for _, v in pairs(speaker.Character:FindFirstChildOfClass("Humanoid"):GetAccessories()) do
				v.Parent = workspace
			end
		end
	end)

	addcmd("deletehats", { "nohats", "rhats" }, function(args, speaker)
		for i, v in next, speaker.Character:GetDescendants() do
			if v:IsA("Accessory") then
				for i, p in next, v:GetDescendants() do
					if p:IsA("Weld") then
						p:Destroy()
					end
				end
			end
		end
	end)

	addcmd("droptools", { "droptool" }, function(args, speaker)
		for i, v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") then
				v.Parent = Players.LocalPlayer.Character
			end
		end
		wait()
		for i, v in pairs(Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("Tool") then
				v.Parent = workspace
			end
		end
	end)

	addcmd("droppabletools", {}, function(args, speaker)
		if speaker.Character then
			for _, obj in pairs(speaker.Character:GetChildren()) do
				if obj:IsA("Tool") then
					obj.CanBeDropped = true
				end
			end
		end
		if speaker:FindFirstChildOfClass("Backpack") then
			for _, obj in pairs(speaker:FindFirstChildOfClass("Backpack"):GetChildren()) do
				if obj:IsA("Tool") then
					obj.CanBeDropped = true
				end
			end
		end
	end)

	local currentToolSize = ""
	local currentGripPos = ""
	addcmd("reach", {}, function(args, speaker)
		execCmd("unreach")
		wait()
		for i, v in pairs(speaker.Character:GetDescendants()) do
			if v:IsA("Tool") then
				if args[1] then
					currentToolSize = v.Handle.Size
					currentGripPos = v.GripPos
					local a = Instance.new("SelectionBox")
					a.Name = "SelectionBoxCreated"
					a.Parent = v.Handle
					a.Adornee = v.Handle
					v.Handle.Massless = true
					v.Handle.Size = Vector3.new(0.5, 0.5, args[1])
					v.GripPos = Vector3.new(0, 0, 0)
					speaker.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
				else
					currentToolSize = v.Handle.Size
					currentGripPos = v.GripPos
					local a = Instance.new("SelectionBox")
					a.Name = "SelectionBoxCreated"
					a.Parent = v.Handle
					a.Adornee = v.Handle
					v.Handle.Massless = true
					v.Handle.Size = Vector3.new(0.5, 0.5, 60)
					v.GripPos = Vector3.new(0, 0, 0)
					speaker.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
				end
			end
		end
	end)

	addcmd("boxreach", {}, function(args, speaker)
		execCmd("unreach")
		wait()
		for i, v in pairs(speaker.Character:GetDescendants()) do
			if v:IsA("Tool") then
				local size = tonumber(args[1]) or 60
				currentToolSize = v.Handle.Size
				currentGripPos = v.GripPos
				local a = Instance.new("SelectionBox")
				a.Name = "SelectionBoxCreated"
				a.Parent = v.Handle
				a.Adornee = v.Handle
				v.Handle.Massless = true
				v.Handle.Size = Vector3.new(size, size, size)
				v.GripPos = Vector3.new(0, 0, 0)
				speaker.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
			end
		end
	end)

	addcmd("unreach", { "noreach", "unboxreach" }, function(args, speaker)
		for i, v in pairs(speaker.Character:GetDescendants()) do
			if v:IsA("Tool") then
				v.Handle.Size = currentToolSize
				v.GripPos = currentGripPos
				v.Handle.SelectionBoxCreated:Destroy()
			end
		end
	end)

	addcmd("grippos", {}, function(args, speaker)
		for i, v in pairs(speaker.Character:GetDescendants()) do
			if v:IsA("Tool") then
				v.Parent = speaker:FindFirstChildOfClass("Backpack")
				v.GripPos = Vector3.new(args[1], args[2], args[3])
				v.Parent = speaker.Character
			end
		end
	end)

	addcmd("usetools", {}, function(args, speaker)
		local Backpack = speaker:FindFirstChildOfClass("Backpack")
		local amount = tonumber(args[1]) or 1
		local delay_ = tonumber(args[2]) or false
		for _, v in ipairs(Backpack:GetChildren()) do
			v.Parent = speaker.Character
			task.spawn(function()
				for _ = 1, amount do
					v:Activate()
					if delay_ then
						wait(delay_)
					end
				end
				v.Parent = Backpack
			end)
		end
	end)

	addcmd("logs", {}, function(args, speaker)
		logsEnabled = true
		jLogsEnabled = true
		Toggle.Text = "Enabled"
		Toggle_2.Text = "Enabled"
		logs:TweenPosition(UDim2.new(0, 0, 1, -265), "InOut", "Quart", 0.3, true, nil)
	end)

	addcmd("chatlogs", { "clogs" }, function(args, speaker)
		logsEnabled = true
		join.Visible = false
		chat.Visible = true
		table.remove(shade3, table.find(shade3, selectChat))
		table.remove(shade2, table.find(shade2, selectJoin))
		table.insert(shade2, selectChat)
		table.insert(shade3, selectJoin)
		selectJoin.BackgroundColor3 = currentShade3
		selectChat.BackgroundColor3 = currentShade2
		Toggle.Text = "Enabled"
		logs:TweenPosition(UDim2.new(0, 0, 1, -265), "InOut", "Quart", 0.3, true, nil)
	end)

	addcmd("joinlogs", { "jlogs" }, function(args, speaker)
		jLogsEnabled = true
		chat.Visible = false
		join.Visible = true
		table.remove(shade3, table.find(shade3, selectJoin))
		table.remove(shade2, table.find(shade2, selectChat))
		table.insert(shade2, selectJoin)
		table.insert(shade3, selectChat)
		selectChat.BackgroundColor3 = currentShade3
		selectJoin.BackgroundColor3 = currentShade2
		Toggle_2.Text = "Enabled"
		logs:TweenPosition(UDim2.new(0, 0, 1, -265), "InOut", "Quart", 0.3, true, nil)
	end)

	addcmd("chatlogswebhook", { "logswebhook" }, function(args, speaker)
		if not httprequest then
			return notify("Incompatible Exploit", "Your exploit does not support this command (missing request)")
		end
		logsWebhook = args[1] or nil
		updatesaves()
	end)

	flinging = false
	addcmd("fling", {}, function(args, speaker)
		flinging = false
		for _, child in next, speaker.Character:GetDescendants() do
			if child:IsA("BasePart") then
				child.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
			end
		end
		execCmd("noclip nonotify")
		task.wait(0.1)
		local bambam = Instance.new("BodyAngularVelocity")
		bambam.Name = randomString()
		bambam.Parent = getRoot(speaker.Character)
		bambam.AngularVelocity = Vector3.new(0, 99999, 0)
		bambam.MaxTorque = Vector3.new(0, math.huge, 0)
		bambam.P = math.huge
		for i, v in next, speaker.Character:GetChildren() do
			if v:IsA("BasePart") then
				v.Massless = true
				v.Velocity = Vector3.zero
			end
		end
		flinging = true
		flingDied = speaker.Character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
			execCmd("unfling")
		end)
		repeat
			bambam.AngularVelocity = Vector3.new(0, 99999, 0)
			task.wait(0.2)
			bambam.AngularVelocity = Vector3.new(0, 0, 0)
			task.wait(0.1)
		until flinging == false
	end)

	addcmd("flingme", { "flingmyself", "selffling" }, function(args, speaker)
		local character = speaker.Character
		if not character then
			return
		end

		local root = character:FindFirstChild("HumanoidRootPart")
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if not root or not humanoid then
			return
		end

		local power = tonumber(args and args[1]) or 50

		if power ~= power or power == math.huge or power == -math.huge then
			return notify("Error", "Power must be a valid number")
		end

		if power <= 0 then
			return notify("Error", "Power must be greater than 0")
		end

		local angle = math.random() * math.pi * 2
		local upwardForce = math.random(40, 100) / 100

		local launchDirection = Vector3.new(math.cos(angle), upwardForce, math.sin(angle)).Unit

		local launchVelocity = power * 12
		local spinPower = power * 10

		local function randomSpin()
			return Vector3.new(
				math.random(-spinPower, spinPower),
				math.random(-spinPower, spinPower),
				math.random(-spinPower, spinPower)
			)
		end

		humanoid:ChangeState(Enum.HumanoidStateType.FallingDown)

		root.AssemblyLinearVelocity += launchDirection * launchVelocity
		root.AssemblyAngularVelocity = randomSpin()

		task.spawn(function()
			for _ = 1, 4 do
				RunService.Heartbeat:Wait()

				if not root.Parent then
					return
				end

				root.AssemblyAngularVelocity = randomSpin()
			end
		end)
	end)

	addcmd("unfling", { "nofling" }, function(args, speaker)
		execCmd("clip nonotify")
		if flingDied then
			flingDied:Disconnect()
		end
		flinging = false
		task.wait(0.1)
		local speakerChar = speaker.Character
		if not speakerChar or not getRoot(speakerChar) then
			return
		end
		for _, v in next, speakerChar:GetDescendants() do
			if v:IsA("BasePart") then
				v.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
				v.Massless = false
				v.Velocity = Vector3.zero
			elseif v:IsA("BodyAngularVelocity") then
				v:Destroy()
			end
		end
	end)

	addcmd("togglefling", {}, function(args, speaker)
		if flinging then
			execCmd("unfling")
		else
			execCmd("fling")
		end
	end)

	addcmd("flyfling", {}, function(args, speaker)
		execCmd("unvehiclefly\\unwalkfling")
		task.wait()
		vehicleflyspeed = tonumber(args[1]) or vehicleflyspeed
		execCmd("vehiclefly\\walkfling")
	end)

	addcmd("unflyfling", {}, function(args, speaker)
		execCmd("unvehiclefly\\unwalkfling\\breakvelocity")
	end)

	addcmd("toggleflyfling", {}, function(args, speaker)
		execCmd(flinging and "unflyfling" or "flyfling")
	end)

	walkflinging = false
	addcmd("walkfling", {}, function(args, speaker)
		execCmd("unwalkfling")
		local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
		if humanoid then
			humanoid.Died:Connect(function()
				execCmd("unwalkfling")
			end)
		end

		execCmd("noclip nonotify")
		walkflinging = true
		repeat
			RunService.Heartbeat:Wait()
			local character = speaker.Character
			local root = getRoot(character)
			local vel, movel = nil, 0.1

			while not (character and character.Parent and root and root.Parent) do
				RunService.Heartbeat:Wait()
				character = speaker.Character
				root = getRoot(character)
			end

			vel = root.Velocity
			root.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)

			RunService.RenderStepped:Wait()
			if character and character.Parent and root and root.Parent then
				root.Velocity = vel
			end

			RunService.Stepped:Wait()
			if character and character.Parent and root and root.Parent then
				root.Velocity = vel + Vector3.new(0, movel, 0)
				movel = movel * -1
			end
		until walkflinging == false
	end)

	addcmd("unwalkfling", { "nowalkfling" }, function(args, speaker)
		walkflinging = false
		execCmd("unnoclip nonotify")
	end)

	addcmd("togglewalkfling", {}, function(args, speaker)
		execCmd(walkflinging and "unwalkfling" or "walkfling")
	end)

	addcmd("invisfling", {}, function(args, speaker)
		local ch = speaker.Character
		ch:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead, false)
		local prt = Instance.new("Model")
		prt.Parent = speaker.Character
		local z1 = Instance.new("Part")
		z1.Name = "Torso"
		z1.CanCollide = false
		z1.Anchored = true
		local z2 = Instance.new("Part")
		z2.Name = "Head"
		z2.Parent = prt
		z2.Anchored = true
		z2.CanCollide = false
		local z3 = Instance.new("Humanoid")
		z3.Name = "Humanoid"
		z3.Parent = prt
		z1.Position = Vector3.new(0, 9999, 0)
		speaker.Character = prt
		wait(3)
		speaker.Character = ch
		wait(3)
		local Hum = Instance.new("Humanoid")
		z2:Clone()
		Hum.Parent = speaker.Character
		local root = getRoot(speaker.Character)
		for i, v in pairs(speaker.Character:GetChildren()) do
			if v ~= root and v.Name ~= "Humanoid" then
				v:Destroy()
			end
		end
		root.Transparency = 0
		root.Color = Color3.new(1, 1, 1)
		local invisflingStepped
		invisflingStepped = RunService.Stepped:Connect(function()
			if speaker.Character and getRoot(speaker.Character) then
				getRoot(speaker.Character).CanCollide = false
			else
				invisflingStepped:Disconnect()
			end
		end)
		sFLY()
		workspace.CurrentCamera.CameraSubject = root
		local bambam = Instance.new("BodyThrust")
		bambam.Parent = getRoot(speaker.Character)
		bambam.Force = Vector3.new(99999, 99999 * 10, 99999)
		bambam.Location = getRoot(speaker.Character).Position
	end)

	addcmd("antifling", {}, function(args, speaker)
		if antifling then
			antifling:Disconnect()
			antifling = nil
		end
		antifling = RunService.Stepped:Connect(function()
			for _, player in pairs(Players:GetPlayers()) do
				if player ~= speaker and player.Character then
					for _, v in pairs(player.Character:GetDescendants()) do
						if v:IsA("BasePart") then
							v.CanCollide = false
						end
					end
				end
			end
		end)
	end)

	addcmd("unantifling", {}, function(args, speaker)
		if antifling then
			antifling:Disconnect()
			antifling = nil
		end
	end)

	addcmd("toggleantifling", {}, function(args, speaker)
		execCmd(antifling and "unantifling" or "antifling")
	end)

	function attach(speaker, target)
		if tools(speaker) then
			local char = speaker.Character
			local tchar = target.Character
			local hum = speaker.Character:FindFirstChildOfClass("Humanoid")
			local hrp = getRoot(speaker.Character)
			local hrp2 = getRoot(target.Character)
			hum.Name = "1"
			local newHum = hum:Clone()
			newHum.Parent = char
			newHum.Name = "Humanoid"
			wait()
			hum:Destroy()
			workspace.CurrentCamera.CameraSubject = char
			newHum.DisplayDistanceType = "None"
			local tool = speaker:FindFirstChildOfClass("Backpack"):FindFirstChildOfClass("Tool")
				or speaker.Character:FindFirstChildOfClass("Tool")
			tool.Parent = char
			hrp.CFrame = hrp2.CFrame
				* CFrame.new(0, 0, 0)
				* CFrame.new(math.random(-100, 100) / 200, math.random(-100, 100) / 200, math.random(-100, 100) / 200)
			local n = 0
			repeat
				wait(0.1)
				n = n + 1
				hrp.CFrame = hrp2.CFrame
			until (tool.Parent ~= char or not hrp or not hrp2 or not hrp.Parent or not hrp2.Parent or n > 250) and n > 2
		else
			notify("Tool Required", "You need to have an item in your inventory to use this command")
		end
	end

	function kill(speaker, target, fast)
		if tools(speaker) then
			if target ~= nil then
				local NormPos = getRoot(speaker.Character).CFrame
				if not fast then
					refresh(speaker)
					wait()
					repeat
						wait()
					until speaker.Character ~= nil and getRoot(speaker.Character)
					wait(0.3)
				end
				local hrp = getRoot(speaker.Character)
				attach(speaker, target)
				repeat
					wait()
					hrp.CFrame = CFrame.new(999999, workspace.FallenPartsDestroyHeight + 5, 999999)
				until not getRoot(target.Character) or not getRoot(speaker.Character)
				local char = speaker.CharacterAdded:Wait()
				local humanoid = char:FindFirstChildOfClass("Humanoid") or char.ChildAdded:Wait()
				while not humanoid:IsA("Humanoid") do
					humanoid = char:FindFirstChildOfClass("Humanoid") or char.ChildAdded:Wait()
				end
				humanoid.RootPart.CFrame = NormPos
			end
		else
			notify("Tool Required", "You need to have an item in your inventory to use this command")
		end
	end

	addcmd("handlekill", { "hkill" }, function(args, speaker)
		if not firetouchinterest then
			return notify(
				"Incompatible Exploit",
				"Your exploit does not support this command (missing firetouchinterest)"
			)
		end
		if not speaker.Character then
			return
		end
		local tool = speaker.Character:FindFirstChildWhichIsA("Tool")
		local handle = tool and tool:FindFirstChild("Handle")
		if not handle then
			return notify(
				"Handle Kill",
				'You need to hold a "Tool" that does damage on touch. For example a common Sword tool.'
			)
		end
		local range = tonumber(args[2]) or math.huge
		if range ~= math.huge then
			notify("Handle Kill", ("Started!\nRadius: %s"):format(tostring(range):upper()))
		end

		while task.wait() and speaker.Character and tool.Parent and tool.Parent == speaker.Character do
			for _, plr in next, getPlayer(args[1], speaker) do
				plr = Players[plr]
				if plr ~= speaker and plr.Character then
					local hum = plr.Character:FindFirstChildWhichIsA("Humanoid")
					local root = hum and getRoot(plr.Character)

					if
						root
						and hum.Health > 0
						and hum:GetState() ~= Enum.HumanoidStateType.Dead
						and speaker:DistanceFromCharacter(root.Position) <= range
					then
						firetouchinterest(handle, root, 1)
						firetouchinterest(handle, root, 0)
					end
				end
			end
		end

		notify("Handle Kill", "Stopped!")
	end)

	tpwalkStack = 0
	addcmd("teleportwalk", { "tpwalk" }, function(args, speaker)
		pcall(function()
			tpwalking:Disconnect()
		end)

		local character = speaker.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		local speed = (args[1] and isNumber(args[1])) and tonumber(args[1]) or 1

		if parseBoolean(args[2]) then
			tpwalkStack = tpwalkStack + speed
		end

		tpwalking = RunService.Heartbeat:Connect(function(delta)
			if not (character and humanoid and humanoid.Parent) then
				tpwalking:Disconnect()
				return
			end

			if humanoid.MoveDirection.Magnitude > 0 then
				character:TranslateBy(humanoid.MoveDirection * (speed + tpwalkStack) * delta * 10)
			end
		end)
	end)

	addcmd("unteleportwalk", { "untpwalk" }, function(args, speaker)
		tpwalkStack = 0
		tpwalking:Disconnect()
	end)

	function bring(speaker, target, fast)
		if tools(speaker) then
			if target ~= nil then
				local NormPos = getRoot(speaker.Character).CFrame
				if not fast then
					refresh(speaker)
					wait()
					repeat
						wait()
					until speaker.Character ~= nil and getRoot(speaker.Character)
					wait(0.3)
				end
				local hrp = getRoot(speaker.Character)
				attach(speaker, target)
				repeat
					wait()
					hrp.CFrame = NormPos
				until not getRoot(target.Character) or not getRoot(speaker.Character)
				local char = speaker.CharacterAdded:Wait()
				local humanoid = char:FindFirstChildOfClass("Humanoid") or char.ChildAdded:Wait()
				while not humanoid:IsA("Humanoid") do
					humanoid = char:FindFirstChildOfClass("Humanoid") or char.ChildAdded:Wait()
				end
				humanoid.RootPart.CFrame = NormPos
			end
		else
			notify("Tool Required", "You need to have an item in your inventory to use this command")
		end
	end

	function teleport(speaker, target, target2, fast)
		if tools(speaker) then
			if target ~= nil then
				local NormPos = getRoot(speaker.Character).CFrame
				if not fast then
					refresh(speaker)
					wait()
					repeat
						wait()
					until speaker.Character ~= nil and getRoot(speaker.Character)
					wait(0.3)
				end
				local hrp = getRoot(speaker.Character)
				local hrp2 = getRoot(target2.Character)
				attach(speaker, target)
				repeat
					wait()
					hrp.CFrame = hrp2.CFrame
				until not getRoot(target.Character) or not getRoot(speaker.Character)
				wait(1)
				local char = speaker.CharacterAdded:Wait()
				local humanoid = char:FindFirstChildOfClass("Humanoid") or char.ChildAdded:Wait()
				while not humanoid:IsA("Humanoid") do
					humanoid = char:FindFirstChildOfClass("Humanoid") or char.ChildAdded:Wait()
				end
				humanoid.RootPart.CFrame = NormPos
			end
		else
			notify("Tool Required", "You need to have an item in your inventory to use this command")
		end
	end

	addcmd("spin", {}, function(args, speaker)
		local spinSpeed = 20
		if args[1] and isNumber(args[1]) then
			spinSpeed = args[1]
		end
		for i, v in pairs(getRoot(speaker.Character):GetChildren()) do
			if v.Name == "Spinning" then
				v:Destroy()
			end
		end
		local Spin = Instance.new("BodyAngularVelocity")
		Spin.Name = "Spinning"
		Spin.Parent = getRoot(speaker.Character)
		Spin.MaxTorque = Vector3.new(0, math.huge, 0)
		Spin.AngularVelocity = Vector3.new(0, spinSpeed, 0)
	end)

	addcmd("unspin", {}, function(args, speaker)
		for i, v in pairs(getRoot(speaker.Character):GetChildren()) do
			if v.Name == "Spinning" then
				v:Destroy()
			end
		end
	end)

	xrayEnabled = false
	function xray()
		for _, v in pairs(workspace:GetDescendants()) do
			if
				v:IsA("BasePart")
				and not v.Parent:FindFirstChildWhichIsA("Humanoid")
				and not v.Parent.Parent:FindFirstChildWhichIsA("Humanoid")
			then
				v.LocalTransparencyModifier = xrayEnabled and 0.5 or 0
			end
		end
	end

	addcmd("xray", {}, function(args, speaker)
		xrayEnabled = true
		xray()
	end)

	addcmd("unxray", { "noxray" }, function(args, speaker)
		xrayEnabled = false
		xray()
	end)

	addcmd("togglexray", {}, function(args, speaker)
		xrayEnabled = not xrayEnabled
		xray()
	end)

	addcmd("loopxray", {}, function(args, speaker)
		pcall(function()
			xrayLoop:Disconnect()
		end)
		xrayLoop = RunService.RenderStepped:Connect(function()
			xrayEnabled = true
			xray()
		end)
	end)

	addcmd("unloopxray", {}, function(args, speaker)
		pcall(function()
			xrayLoop:Disconnect()
		end)
		xrayEnabled = false
		xray()
	end)

	local walltpTouch = nil
	addcmd("walltp", {}, function(args, speaker)
		local torso
		if r15(speaker) then
			torso = speaker.Character.UpperTorso
		else
			torso = speaker.Character.Torso
		end
		local function touchedFunc(hit)
			local Root = getRoot(speaker.Character)
			if
				hit:IsA("BasePart")
				and hit.Position.Y > Root.Position.Y - speaker.Character:FindFirstChildOfClass("Humanoid").HipHeight
			then
				local hitP = getRoot(hit.Parent)
				if hitP ~= nil then
					Root.CFrame = hit.CFrame
						* CFrame.new(
							Root.CFrame.lookVector.X,
							hitP.Size.Z / 2 + speaker.Character:FindFirstChildOfClass("Humanoid").HipHeight,
							Root.CFrame.lookVector.Z
						)
				elseif hitP == nil then
					Root.CFrame = hit.CFrame
						* CFrame.new(
							Root.CFrame.lookVector.X,
							hit.Size.Y / 2 + speaker.Character:FindFirstChildOfClass("Humanoid").HipHeight,
							Root.CFrame.lookVector.Z
						)
				end
			end
		end
		walltpTouch = torso.Touched:Connect(touchedFunc)
	end)

	addcmd("unwalltp", { "nowalltp" }, function(args, speaker)
		if walltpTouch then
			walltpTouch:Disconnect()
		end
	end)

	autoclicking = false
	addcmd("autoclick", {}, function(args, speaker)
		if mouse1press and mouse1release then
			execCmd("unautoclick")
			wait()
			local clickDelay = 0.1
			local releaseDelay = 0.1
			if args[1] and isNumber(args[1]) then
				clickDelay = args[1]
			end
			if args[2] and isNumber(args[2]) then
				releaseDelay = args[2]
			end
			autoclicking = true
			cancelAutoClick = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
				if not gameProcessedEvent then
					if
						(input.KeyCode == Enum.KeyCode.Backspace and UserInputService:IsKeyDown(Enum.KeyCode.Equals))
						or (input.KeyCode == Enum.KeyCode.Equals and UserInputService:IsKeyDown(Enum.KeyCode.Backspace))
					then
						autoclicking = false
						cancelAutoClick:Disconnect()
					end
				end
			end)
			notify("Auto Clicker", "Press [backspace] and [=] at the same time to stop")
			repeat
				wait(clickDelay)
				mouse1press()
				wait(releaseDelay)
				mouse1release()
			until autoclicking == false
		else
			notify("Auto Clicker", "Your exploit doesn't have the ability to use the autoclick")
		end
	end)

	addcmd("unautoclick", { "noautoclick" }, function(args, speaker)
		autoclicking = false
		if cancelAutoClick then
			cancelAutoClick:Disconnect()
		end
	end)

	addcmd("mousesensitivity", { "ms" }, function(args, speaker)
		UserInputService.MouseDeltaSensitivity = args[1]
	end)

	local nameBox = nil
	local nbSelection = nil
	addcmd("hovername", {}, function(args, speaker)
		execCmd("unhovername")
		wait()
		nameBox = Instance.new("TextLabel")
		nameBox.Name = randomString()
		nameBox.Parent = ScaledHolder
		nameBox.BackgroundTransparency = 1
		nameBox.Size = UDim2.new(0, 200, 0, 30)
		nameBox.Font = Enum.Font.Code
		nameBox.TextSize = 16
		nameBox.Text = ""
		nameBox.TextColor3 = Color3.new(1, 1, 1)
		nameBox.TextStrokeTransparency = 0
		nameBox.TextXAlignment = Enum.TextXAlignment.Left
		nameBox.ZIndex = 10
		nbSelection = Instance.new("SelectionBox")
		nbSelection.Name = randomString()
		nbSelection.LineThickness = 0.03
		nbSelection.Color3 = Color3.new(1, 1, 1)
		local function updateNameBox()
			local t
			local target = ZYMouse.Target

			if target then
				local humanoid = target.Parent:FindFirstChildOfClass("Humanoid")
					or target.Parent.Parent:FindFirstChildOfClass("Humanoid")
				if humanoid then
					t = humanoid.Parent
				end
			end

			if t ~= nil then
				local x = ZYMouse.X
				local y = ZYMouse.Y
				local xP
				local yP
				if ZYMouse.X > 200 then
					xP = x - 205
					nameBox.TextXAlignment = Enum.TextXAlignment.Right
				else
					xP = x + 25
					nameBox.TextXAlignment = Enum.TextXAlignment.Left
				end
				nameBox.Position = UDim2.new(0, xP, 0, y)
				nameBox.Text = t.Name
				nameBox.Visible = true
				nbSelection.Parent = t
				nbSelection.Adornee = t
			else
				nameBox.Visible = false
				nbSelection.Parent = nil
				nbSelection.Adornee = nil
			end
		end
		nbUpdateFunc = ZYMouse.Move:Connect(updateNameBox)
	end)

	addcmd("unhovername", { "nohovername" }, function(args, speaker)
		if nbUpdateFunc then
			nbUpdateFunc:Disconnect()
			nameBox:Destroy()
			nbSelection:Destroy()
		end
	end)

	addcmd("headsize", {}, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			if Players[v] ~= speaker and Players[v].Character:FindFirstChild("Head") then
				local sizeArg = tonumber(args[2])
				local Size = Vector3.new(sizeArg, sizeArg, sizeArg)
				local Head = Players[v].Character:FindFirstChild("Head")
				if Head:IsA("BasePart") then
					Head.CanCollide = false
					if not args[2] or sizeArg == 1 then
						Head.Size = Vector3.new(2, 1, 1)
					else
						Head.Size = Size
					end
				end
			end
		end
	end)

	addcmd("hitbox", {}, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		local transparency = args[3] and tonumber(args[3]) or 0.4
		for i, v in pairs(players) do
			if Players[v] ~= speaker and getRoot(Players[v].Character) then
				local sizeArg = tonumber(args[2])
				local Size = Vector3.new(sizeArg, sizeArg, sizeArg)
				local Root = getRoot(Players[v].Character)
				if Root:IsA("BasePart") then
					Root.CanCollide = false
					if not args[2] or sizeArg == 1 then
						Root.Size = Vector3.new(2, 1, 1)
						Root.Transparency = transparency
					else
						Root.Size = Size
						Root.Transparency = transparency
					end
				end
			end
		end
	end)

	addcmd("hitboxes", {}, function(args, speaker)
		settings():GetService("RenderSettings").ShowBoundingBoxes = true
	end)

	addcmd("unhitboxes", {}, function(args, speaker)
		settings():GetService("RenderSettings").ShowBoundingBoxes = false
	end)

	addcmd("stareat", { "stare" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			if stareLoop then
				stareLoop:Disconnect()
			end
			if not getRoot(Players.LocalPlayer.Character) and getRoot(Players[v].Character) then
				return
			end
			local function stareFunc()
				if
					Players.LocalPlayer.Character.PrimaryPart
					and Players:FindFirstChild(v)
					and Players[v].Character ~= nil
					and getRoot(Players[v].Character)
				then
					local chrPos = Players.LocalPlayer.Character.PrimaryPart.Position
					local tPos = getRoot(Players[v].Character).Position
					local modTPos = Vector3.new(tPos.X, chrPos.Y, tPos.Z)
					local newCF = CFrame.new(chrPos, modTPos)
					Players.LocalPlayer.Character:SetPrimaryPartCFrame(newCF)
				elseif not Players:FindFirstChild(v) then
					stareLoop:Disconnect()
				end
			end

			stareLoop = RunService.RenderStepped:Connect(stareFunc)
		end
	end)

	addcmd("unstareat", { "unstare", "nostare", "nostareat" }, function(args, speaker)
		if stareLoop then
			stareLoop:Disconnect()
		end
	end)

	RolewatchData = { Group = 0, Role = "", Leave = false }
	RolewatchConnection = Players.PlayerAdded:Connect(function(player)
		if RolewatchData.Group == 0 then
			return
		end
		if player:IsInGroup(RolewatchData.Group) then
			if tostring(player:GetRoleInGroup(RolewatchData.Group)):lower() == RolewatchData.Role:lower() then
				if RolewatchData.Leave == true then
					Players.LocalPlayer:Kick(
						'\n\nRolewatch\nPlayer "'
							.. tostring(player.Name)
							.. '" has joined with the Role "'
							.. RolewatchData.Role
							.. '"\n'
					)
				else
					notify(
						"Rolewatch",
						'Player "'
							.. tostring(player.Name)
							.. '" has joined with the Role "'
							.. RolewatchData.Role
							.. '"'
					)
				end
			end
		end
	end)

	addcmd("rolewatch", {}, function(args, speaker)
		local groupId = tonumber(args[1] or 0)
		local roleName = args[2] and tostring(getstring(2, args))
		if groupId and roleName then
			RolewatchData.Group = groupId
			RolewatchData.Role = roleName
			notify("Rolewatch", 'Watching Group ID "' .. tostring(groupId) .. '" for Role "' .. roleName .. '"')
		end
	end)

	addcmd("rolewatchstop", {}, function(args, speaker)
		RolewatchData.Group = 0
		RolewatchData.Role = ""
		RolewatchData.Leave = false
		notify("Rolewatch", "Disabled")
	end)

	addcmd("rolewatchleave", { "unrolewatch" }, function(args, speaker)
		RolewatchData.Leave = not RolewatchData.Leave
		notify("Rolewatch", RolewatchData.Leave and "Leave has been Enabled" or "Leave has been Disabled")
	end)

	staffRoles = {
		"mod",
		"admin",
		"staff",
		"dev",
		"founder",
		"owner",
		"supervis",
		"manager",
		"management",
		"executive",
		"president",
		"chairman",
		"chairwoman",
		"chairperson",
		"director",
	}

	getStaffRole = function(player)
		local playerRole = player:GetRoleInGroup(game.CreatorId)
		local result = { Role = playerRole, Staff = false }
		if player:IsInGroup(1200769) then
			result.Role = "Roblox Employee"
			result.Staff = true
		end
		for _, role in pairs(staffRoles) do
			if string.find(string.lower(playerRole), role) then
				result.Staff = true
			end
		end
		return result
	end

	addcmd("staffwatch", {}, function(args, speaker)
		if staffwatchjoin then
			staffwatchjoin:Disconnect()
		end
		if game.CreatorType == Enum.CreatorType.Group then
			local found = {}
			staffwatchjoin = Players.PlayerAdded:Connect(function(player)
				local result = getStaffRole(player)
				if result.Staff then
					notify("Staffwatch", formatUsername(player) .. " is a " .. result.Role)
				end
			end)
			for _, player in pairs(Players:GetPlayers()) do
				local result = getStaffRole(player)
				if result.Staff then
					table.insert(found, formatUsername(player) .. " is a " .. result.Role)
				end
			end
			if #found > 0 then
				notify("Staffwatch", table.concat(found, ",\n"))
			else
				notify("Staffwatch", "Enabled")
			end
		else
			notify("Staffwatch", "Game is not owned by a Group")
		end
	end)

	addcmd("unstaffwatch", {}, function(args, speaker)
		if staffwatchjoin then
			staffwatchjoin:Disconnect()
		end
		notify("Staffwatch", "Disabled")
	end)

	local function playerGroups()
		local players = Players:GetPlayers()
		local graph = {}
		local seen = {}
		local groups = {}

		for _, p in ipairs(players) do
			graph[p] = {}
		end

		for i = 1, #players do
			for j = i + 1, #players do
				local p1 = players[i]
				local p2 = players[j]

				local success, result = pcall(function()
					return p1:IsFriendsWithAsync(p2.UserId)
				end)

				if success and result then
					table.insert(graph[p1], p2)
					table.insert(graph[p2], p1)
				end
			end
		end

		local function dfs(player, group)
			seen[player] = true
			table.insert(group, player)

			for _, possible in ipairs(graph[player]) do
				if not seen[possible] then
					dfs(possible, group)
				end
			end
		end

		for _, p in ipairs(players) do
			if not seen[p] then
				local group = {}
				dfs(p, group)
				table.insert(groups, group)
			end
		end

		return groups
	end

	addcmd("findfriendgroups", {}, function(args, speaker)
		notify("Checking Players", "This might take a while (slow function)")

		local groups = playerGroups()
		local playerList = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList)

		local result = ""
		local index = 1
		local found = 0

		for _, group in ipairs(groups) do
			if #group == 1 then
				continue
			end
			local names = {}
			for _, player in ipairs(group) do
				table.insert(names, playerList and player.DisplayName or player.Name)
			end
			result = result .. index .. ". " .. table.concat(names, ", ") .. "\n"
			index = index + 1
			found = found + 1
		end

		createPopup("Friend Groups", found == 0 and "None" or result)
	end)

	addcmd("removeterrain", { "rterrain", "noterrain" }, function(args, speaker)
		workspace:FindFirstChildOfClass("Terrain"):Clear()
	end)

	addcmd("clearnilinstances", { "nonilinstances", "cni" }, function(args, speaker)
		if getnilinstances then
			for i, v in pairs(getnilinstances()) do
				v:Destroy()
			end
		else
			notify("Incompatible Exploit", "Your exploit does not support this command (missing getnilinstances)")
		end
	end)

	addcmd("destroyheight", { "dh" }, function(args, speaker)
		local dh = args[1] or -500
		if isNumber(dh) then
			workspace.FallenPartsDestroyHeight = dh
		end
	end)

	OrgDestroyHeight = workspace.FallenPartsDestroyHeight
	addcmd("antivoid", {}, function(args, speaker)
		execCmd("unantivoid nonotify")
		task.wait()
		antivoidloop = RunService.Stepped:Connect(function()
			local root = getRoot(speaker.Character)
			if root and root.Position.Y <= OrgDestroyHeight + 25 then
				root.Velocity = root.Velocity + Vector3.new(0, 250, 0)
			end
		end)
		if args[1] ~= "nonotify" then
			notify("antivoid", "Enabled")
		end
	end)

	addcmd("unantivoid", { "noantivoid" }, function(args, speaker)
		pcall(function()
			antivoidloop:Disconnect()
		end)
		antivoidloop = nil
		if args[1] ~= "nonotify" then
			notify("antivoid", "Disabled")
		end
	end)

	antivoidWasEnabled = false
	addcmd("fakeout", {}, function(args, speaker)
		local root = getRoot(speaker.Character)
		local oldpos = root.CFrame
		if antivoidloop then
			execCmd("unantivoid nonotify")
			antivoidWasEnabled = true
		end
		workspace.FallenPartsDestroyHeight = -math.huge
		root.CFrame = CFrame.new(Vector3.new(0, OrgDestroyHeight - 25, 0))
		task.wait(1)
		root.CFrame = oldpos
		workspace.FallenPartsDestroyHeight = OrgDestroyHeight
		if antivoidWasEnabled then
			execCmd("antivoid nonotify")
			antivoidWasEnabled = false
		end
	end)

	addcmd("trip", {}, function(args, speaker)
		local humanoid = speaker.Character and speaker.Character:FindFirstChildWhichIsA("Humanoid")
		local root = speaker.Character and getRoot(speaker.Character)
		if humanoid and root then
			humanoid:ChangeState(Enum.HumanoidStateType.FallingDown)
			root.Velocity = root.CFrame.LookVector * 30
		end
	end)

	addcmd("removeads", { "adblock" }, function(args, speaker)
		while wait() do
			pcall(function()
				for i, v in pairs(workspace:GetDescendants()) do
					if v:IsA("PackageLink") then
						if v.Parent:FindFirstChild("ADpart") then
							v.Parent:Destroy()
						end
						if v.Parent:FindFirstChild("AdGuiAdornee") then
							v.Parent.Parent:Destroy()
						end
					end
				end
			end)
		end
	end)

	addcmd("scare", { "spook" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		local oldpos = nil

		for _, v in pairs(players) do
			local root = speaker.Character and getRoot(speaker.Character)
			local target = Players[v]
			local targetRoot = target and target.Character and getRoot(target.Character)

			if root and targetRoot and target ~= speaker then
				oldpos = root.CFrame
				root.CFrame = targetRoot.CFrame + targetRoot.CFrame.lookVector * 2
				root.CFrame = CFrame.new(root.Position, targetRoot.Position)
				task.wait(0.5)
				root.CFrame = oldpos
			end
		end
	end)

	addcmd("alignmentkeys", {}, function(args, speaker)
		alignmentKeys = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then
				return
			end
			if input.KeyCode == Enum.KeyCode.Comma then
				workspace.CurrentCamera:PanUnits(-1)
			end
			if input.KeyCode == Enum.KeyCode.Period then
				workspace.CurrentCamera:PanUnits(1)
			end
		end)
		alignmentKeysEmotes = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu)
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
	end)

	addcmd("unalignmentkeys", { "noalignmentkeys" }, function(args, speaker)
		if type(alignmentKeysEmotes) == "boolean" then
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, alignmentKeysEmotes)
		end
		alignmentKeys:Disconnect()
	end)

	addcmd("ctrllock", {}, function(args, speaker)
		local mouseLockController = speaker.PlayerScripts
			:WaitForChild("PlayerModule")
			:WaitForChild("CameraModule")
			:WaitForChild("MouseLockController")
		local boundKeys = mouseLockController:FindFirstChild("BoundKeys")

		if boundKeys then
			boundKeys.Value = "LeftControl"
		else
			boundKeys = Instance.new("StringValue")
			boundKeys.Name = "BoundKeys"
			boundKeys.Value = "LeftControl"
			boundKeys.Parent = mouseLockController
		end
	end)

	addcmd("unctrllock", {}, function(args, speaker)
		local mouseLockController = speaker.PlayerScripts
			:WaitForChild("PlayerModule")
			:WaitForChild("CameraModule")
			:WaitForChild("MouseLockController")
		local boundKeys = mouseLockController:FindFirstChild("BoundKeys")

		if boundKeys then
			boundKeys.Value = "LeftShift"
		else
			boundKeys = Instance.new("StringValue")
			boundKeys.Name = "BoundKeys"
			boundKeys.Value = "LeftShift"
			boundKeys.Parent = mouseLockController
		end
	end)

	addcmd("listento", {}, function(args, speaker)
		execCmd("unlistento")
		if not args[1] then
			return
		end

		local player = Players:FindFirstChild(getPlayer(args[1], speaker)[1])
		local root = player and player.Character and getRoot(player.Character)

		if root then
			SoundService:SetListener(Enum.ListenerType.ObjectPosition, root)
			listentoChar = player.CharacterAdded:Connect(function()
				repeat
					task.wait()
				until Players[player.Name].Character ~= nil and getRoot(Players[player.Name].Character)
				SoundService:SetListener(Enum.ListenerType.ObjectPosition, getRoot(Players[player.Name].Character))
			end)
		end
	end)

	addcmd("unlistento", {}, function(args, speaker)
		SoundService:SetListener(Enum.ListenerType.Camera)
		listentoChar:Disconnect()
	end)

	addcmd("jerk", {}, function(args, speaker)
		local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
		local backpack = speaker:FindFirstChildWhichIsA("Backpack")
		if not humanoid or not backpack then
			return
		end

		local tool = Instance.new("Tool")
		tool.Name = "Jerk Off"
		tool.ToolTip =
			'in the stripped club. straight up "jorking it" . and by "it" , haha, well. let\'s justr say. My peanits.'
		tool.RequiresHandle = false
		tool.Parent = backpack

		local jorkin = false
		local track = nil

		local function stopTomfoolery()
			jorkin = false
			if track then
				track:Stop()
				track = nil
			end
		end

		tool.Equipped:Connect(function()
			jorkin = true
		end)
		tool.Unequipped:Connect(stopTomfoolery)
		humanoid.Died:Connect(stopTomfoolery)

		while task.wait() do
			if not jorkin then
				continue
			end

			local isR15 = r15(speaker)
			if not track then
				local anim = Instance.new("Animation")
				anim.AnimationId = not isR15 and "rbxassetid://72042024" or "rbxassetid://698251653"
				track = humanoid:LoadAnimation(anim)
			end

			track:Play()
			track:AdjustSpeed(isR15 and 0.7 or 0.65)
			track.TimePosition = 0.6
			task.wait(0.1)
			while track and track.TimePosition < (not isR15 and 0.65 or 0.7) do
				task.wait(0.1)
			end
			if track then
				track:Stop()
				track = nil
			end
		end
	end)

	addcmd("guiscale", {}, function(args, speaker)
		if args[1] and isNumber(args[1]) then
			local scale = tonumber(args[1])
			if scale % 1 == 0 then
				scale = scale / 100
			end
			-- me when i divide and it explodes
			if scale == 0.01 then
				scale = 1
			end
			if scale == 0.02 then
				scale = 2
			end

			if scale >= 0.4 and scale <= 2 then
				guiScale = scale
			end
		else
			guiScale = defaultGuiScale
		end

		Scale.Scale = math.max(Holder.AbsoluteSize.X / 1920, guiScale)
		updatesaves()
	end)

	addcmd("muteallvoices", { "muteallvcs" }, function(args, speaker)
		Services.VoiceChatInternal:SubscribePauseAll(true)
	end)

	addcmd("unmuteallvoices", { "unmuteallvcs" }, function(args, speaker)
		Services.VoiceChatInternal:SubscribePauseAll(false)
	end)

	addcmd("mutevc", {}, function(args, speaker)
		for _, plr in getPlayer(args[1], speaker) do
			if Players[plr] == speaker then
				continue
			end
			Services.VoiceChatInternal:SubscribePause(Players[plr].UserId, true)
		end
	end)

	addcmd("unmutevc", {}, function(args, speaker)
		for _, plr in getPlayer(args[1], speaker) do
			if Players[plr] == speaker then
				continue
			end
			Services.VoiceChatInternal:SubscribePause(Players[plr].UserId, false)
		end
	end)

	addcmd("phonebook", { "call" }, function(args, speaker)
		local success, canInvite = pcall(function()
			return SocialService:CanSendCallInviteAsync(speaker)
		end)
		if success and canInvite then
			SocialService:PromptPhoneBook(speaker, "")
		else
			notify("Phonebook", "It seems you're not able to call anyone. Sorry!")
		end
	end)

	local freezingua = nil
	frozenParts = {}
	addcmd("freezeunanchored", { "freezeua" }, function(args, speaker)
		local badnames = {
			"Head",
			"UpperTorso",
			"LowerTorso",
			"RightUpperArm",
			"LeftUpperArm",
			"RightLowerArm",
			"LeftLowerArm",
			"RightHand",
			"LeftHand",
			"RightUpperLeg",
			"LeftUpperLeg",
			"RightLowerLeg",
			"LeftLowerLeg",
			"RightFoot",
			"LeftFoot",
			"Torso",
			"Right Arm",
			"Left Arm",
			"Right Leg",
			"Left Leg",
			"HumanoidRootPart",
		}
		local function FREEZENOOB(v)
			if v:IsA("BasePart" or "UnionOperation") and v.Anchored == false then
				local BADD = false
				for i = 1, #badnames do
					if v.Name == badnames[i] then
						BADD = true
					end
				end
				if speaker.Character and v:IsDescendantOf(speaker.Character) then
					BADD = true
				end
				if BADD == false then
					for i, c in pairs(v:GetChildren()) do
						if c:IsA("BodyPosition") or c:IsA("BodyGyro") then
							c:Destroy()
						end
					end
					local bodypos = Instance.new("BodyPosition")
					bodypos.Parent = v
					bodypos.Position = v.Position
					bodypos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					local bodygyro = Instance.new("BodyGyro")
					bodygyro.Parent = v
					bodygyro.CFrame = v.CFrame
					bodygyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
					if not table.find(frozenParts, v) then
						table.insert(frozenParts, v)
					end
				end
			end
		end
		for i, v in pairs(workspace:GetDescendants()) do
			FREEZENOOB(v)
		end
		freezingua = workspace.DescendantAdded:Connect(FREEZENOOB)
	end)

	addcmd("thawunanchored", { "thawua", "unfreezeunanchored", "unfreezeua" }, function(args, speaker)
		if freezingua then
			freezingua:Disconnect()
		end
		for i, v in pairs(frozenParts) do
			for i, c in pairs(v:GetChildren()) do
				if c:IsA("BodyPosition") or c:IsA("BodyGyro") then
					c:Destroy()
				end
			end
		end
		frozenParts = {}
	end)

	addcmd("tpunanchored", { "tpua" }, function(args, speaker)
		local players = getPlayer(args[1], speaker)
		for i, v in pairs(players) do
			local Forces = {}
			for _, part in pairs(workspace:GetDescendants()) do
				if
					Players[v].Character:FindFirstChild("Head")
					and part:IsA("BasePart" or "UnionOperation" or "Model")
					and part.Anchored == false
					and not part:IsDescendantOf(speaker.Character)
					and part.Name == "Torso" == false
					and part.Name == "Head" == false
					and part.Name == "Right Arm" == false
					and part.Name == "Left Arm" == false
					and part.Name == "Right Leg" == false
					and part.Name == "Left Leg" == false
					and part.Name == "HumanoidRootPart" == false
				then
					for i, c in pairs(part:GetChildren()) do
						if c:IsA("BodyPosition") or c:IsA("BodyGyro") then
							c:Destroy()
						end
					end
					local ForceInstance = Instance.new("BodyPosition")
					ForceInstance.Parent = part
					ForceInstance.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					table.insert(Forces, ForceInstance)
					if not table.find(frozenParts, part) then
						table.insert(frozenParts, part)
					end
				end
			end
			for i, c in pairs(Forces) do
				c.Position = Players[v].Character.Head.Position
			end
		end
	end)

	keycodeMap = {
		["0"] = 0x30,
		["1"] = 0x31,
		["2"] = 0x32,
		["3"] = 0x33,
		["4"] = 0x34,
		["5"] = 0x35,
		["6"] = 0x36,
		["7"] = 0x37,
		["8"] = 0x38,
		["9"] = 0x39,
		["a"] = 0x41,
		["b"] = 0x42,
		["c"] = 0x43,
		["d"] = 0x44,
		["e"] = 0x45,
		["f"] = 0x46,
		["g"] = 0x47,
		["h"] = 0x48,
		["i"] = 0x49,
		["j"] = 0x4A,
		["k"] = 0x4B,
		["l"] = 0x4C,
		["m"] = 0x4D,
		["n"] = 0x4E,
		["o"] = 0x4F,
		["p"] = 0x50,
		["q"] = 0x51,
		["r"] = 0x52,
		["s"] = 0x53,
		["t"] = 0x54,
		["u"] = 0x55,
		["v"] = 0x56,
		["w"] = 0x57,
		["x"] = 0x58,
		["y"] = 0x59,
		["z"] = 0x5A,
		["enter"] = 0x0D,
		["shift"] = 0x10,
		["ctrl"] = 0x11,
		["alt"] = 0x12,
		["pause"] = 0x13,
		["capslock"] = 0x14,
		["spacebar"] = 0x20,
		["space"] = 0x20,
		["pageup"] = 0x21,
		["pagedown"] = 0x22,
		["end"] = 0x23,
		["home"] = 0x24,
		["left"] = 0x25,
		["up"] = 0x26,
		["right"] = 0x27,
		["down"] = 0x28,
		["insert"] = 0x2D,
		["delete"] = 0x2E,
		["f1"] = 0x70,
		["f2"] = 0x71,
		["f3"] = 0x72,
		["f4"] = 0x73,
		["f5"] = 0x74,
		["f6"] = 0x75,
		["f7"] = 0x76,
		["f8"] = 0x77,
		["f9"] = 0x78,
		["f10"] = 0x79,
		["f11"] = 0x7A,
		["f12"] = 0x7B,
	}
	autoKeyPressing = false
	cancelAutoKeyPress = nil

	addcmd("autokeypress", { "keypress" }, function(args, speaker)
		if keypress and keyrelease and args[1] then
			local code = keycodeMap[args[1]:lower()]
			if not code then
				notify("Auto Key Press", "Invalid key")
				return
			end
			execCmd("unautokeypress")
			wait()
			local clickDelay = 0.1
			local releaseDelay = 0.1
			if args[2] and isNumber(args[2]) then
				clickDelay = args[2]
			end
			if args[3] and isNumber(args[3]) then
				releaseDelay = args[3]
			end
			autoKeyPressing = true
			cancelAutoKeyPress = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
				if not gameProcessedEvent then
					if
						(input.KeyCode == Enum.KeyCode.Backspace and UserInputService:IsKeyDown(Enum.KeyCode.Equals))
						or (input.KeyCode == Enum.KeyCode.Equals and UserInputService:IsKeyDown(Enum.KeyCode.Backspace))
					then
						autoKeyPressing = false
						cancelAutoKeyPress:Disconnect()
					end
				end
			end)
			notify("Auto Key Press", "Press [backspace] and [=] at the same time to stop")
			repeat
				wait(clickDelay)
				keypress(code)
				wait(releaseDelay)
				keyrelease(code)
			until autoKeyPressing == false
			if cancelAutoKeyPress then
				cancelAutoKeyPress:Disconnect()
				keyrelease(code)
			end
		else
			notify("Auto Key Press", "Your exploit doesn't have the ability to use auto key press")
		end
	end)

	addcmd("unautokeypress", { "noautokeypress", "unkeypress", "nokeypress" }, function(args, speaker)
		autoKeyPressing = false
		if cancelAutoKeyPress then
			cancelAutoKeyPress:Disconnect()
		end
	end)

	addcmd("addplugin", { "plugin" }, function(args, speaker)
		addPlugin(getstring(1, args))
	end)

	addcmd("removeplugin", { "deleteplugin" }, function(args, speaker)
		deletePlugin(getstring(1, args))
	end)

	addcmd("reloadplugin", {}, function(args, speaker)
		local pluginName = getstring(1, args)
		deletePlugin(pluginName)
		wait(1)
		addPlugin(pluginName)
	end)

	addcmd("addallplugins", { "loadallplugins" }, function(args, speaker)
		if not listfiles or not isfolder then
			notify("Incompatible Exploit", "Your exploit does not support this command (missing listfiles/isfolder)")
			return
		end

		for _, filePath in ipairs(listfiles("")) do
			local fileName = filePath:match("([^/\\]+%.zy)$")

			if
				fileName
				and fileName:lower() ~= "zy_fe.zy"
				and not isfolder(fileName)
				and not table.find(PluginsTable, fileName)
			then
				addPlugin(fileName)
			end
		end
	end)

	addcmd("removecmd", { "deletecmd" }, function(args, speaker)
		removecmd(args[1])
	end)

	addcmd("debug", {}, function(args, speaker)
		local opt = parseBoolean(args[1], true)
		_G.ZY_DEBUG = opt
		notify("debug", tostring(opt), 1)
	end)

	return env
end
