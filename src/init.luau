if ZY_LOADED and not _G.ZY_DEBUG then
	return
end

pcall(function()
	getgenv().ZY_LOADED = true
end)
if not game:IsLoaded() then
	game.Loaded:Wait()
end

local env = {}

require("./core/api")(env)
require("./core/services")(env)
require("./ui/ui")(env)
require("./core/utils")(env)
require("./ui/event_editor")(env)
require("./ui/themes")(env)
require("./core/player")(env)
require("./features/systems")(env)
require("./features/plugins")(env)
require("./ui/command_bar")(env)
require("./features/commands")(env)

-- Mobile quick capture button
if IsOnMobile then
	local QuickCapture = Instance.new("TextButton")
	local UICorner = Instance.new("UICorner")
	QuickCapture.Name = randomString()
	QuickCapture.Parent = PARENT
	QuickCapture.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	QuickCapture.BackgroundTransparency = 0.14
	QuickCapture.Position = UDim2.new(0.489, 0, 0, 0)
	QuickCapture.Size = UDim2.new(0, 32, 0, 33)
	QuickCapture.Font = Enum.Font.SourceSansBold
	QuickCapture.Text = "ZY"
	QuickCapture.TextColor3 = Color3.fromRGB(255, 255, 255)
	QuickCapture.TextSize = 20
	QuickCapture.TextWrapped = true
	QuickCapture.ZIndex = 10
	QuickCapture.Draggable = true
	UICorner.Name = randomString()
	UICorner.CornerRadius = UDim.new(0.5, 0)
	UICorner.Parent = QuickCapture
	QuickCapture.MouseButton1Click:Connect(function()
		Cmdbar:CaptureFocus()
		maximizeHolder()
	end)
	table.insert(shade1, QuickCapture)
	table.insert(text1, QuickCapture)
end

-- GUI scale setup
pcall(function()
	Scale.Scale = math.max(Holder.AbsoluteSize.X / 1920, guiScale)
end)
Scale.Parent = ScaledHolder
ScaledHolder.Size = UDim2.fromScale(1 / Scale.Scale, 1 / Scale.Scale)
Scale:GetPropertyChangedSignal("Scale"):Connect(function()
	ScaledHolder.Size = UDim2.fromScale(1 / Scale.Scale, 1 / Scale.Scale)
	for _, v in ScaledHolder:GetDescendants() do
		if v:IsA("GuiObject") and v.Visible then
			v.Visible = false
			v.Visible = true
		end
	end
end)

-- Apply saved theme colors
updateColors(currentShade1, shade1)
updateColors(currentShade2, shade2)
updateColors(currentShade3, shade3)
updateColors(currentText1, text1)
updateColors(currentText2, text2)
updateColors(currentScroll, scroll)

-- Load plugins
if PluginsTable ~= nil then
	FindPlugins()
end

-- Event registration
eventEditor.RegisterEvent("OnExecute")
eventEditor.RegisterEvent("OnSpawn", {
	{ Type = "Player", Name = "Player Filter ($1)" },
})
eventEditor.RegisterEvent("OnDied", {
	{ Type = "Player", Name = "Player Filter ($1)" },
})
eventEditor.RegisterEvent("OnDamage", {
	{ Type = "Player", Name = "Player Filter ($1)" },
	{ Type = "Number", Name = "Below Health ($2)" },
})
eventEditor.RegisterEvent("OnKilled", {
	{ Type = "Player", Name = "Victim Player ($1)" },
	{ Type = "Player", Name = "Killer Player ($2)", Default = 1 },
})
eventEditor.RegisterEvent("OnJoin", {
	{ Type = "Player", Name = "Player Filter ($1)", Default = 1 },
})
eventEditor.RegisterEvent("OnLeave", {
	{ Type = "Player", Name = "Player Filter ($1)", Default = 1 },
})
eventEditor.RegisterEvent("OnChatted", {
	{ Type = "Player", Name = "Player Filter ($1)", Default = 1 },
	{ Type = "String", Name = "Message Filter ($2)" },
})

-- Hook character events
function hookCharEvents(plr, instant)
	task.spawn(function()
		local char = plr.Character
		if not char then
			return
		end

		local humanoid = char:WaitForChild("Humanoid", 10)
		if not humanoid then
			return
		end

		local oldHealth = humanoid.Health
		humanoid.HealthChanged:Connect(function(health)
			local change = math.abs(oldHealth - health)
			if oldHealth > health then
				eventEditor.FireEvent("OnDamage", plr.Name, tonumber(health))
			end
			oldHealth = health
		end)

		humanoid.Died:Connect(function()
			eventEditor.FireEvent("OnDied", plr.Name)

			local killedBy = humanoid:FindFirstChild("creator")
			if killedBy and killedBy.Value and killedBy.Value.Parent then
				eventEditor.FireEvent("OnKilled", plr.Name, killedBy.Name)
			end
		end)
	end)
end

-- Player added handler
Players.PlayerAdded:Connect(function(plr)
	eventEditor.FireEvent("OnJoin", plr.Name)
	if isLegacyChat then
		plr.Chatted:Connect(function(msg)
			eventEditor.FireEvent("OnChatted", tostring(plr), msg)
		end)
	end
	plr.CharacterAdded:Connect(function()
		eventEditor.FireEvent("OnSpawn", tostring(plr))
		hookCharEvents(plr)
	end)
	JoinLog(plr)
	if isLegacyChat then
		ChatLog(plr)
	end
	if ESPenabled then
		repeat
			wait(1)
		until plr.Character and getRoot(plr.Character)
		ESP(plr)
	end
	if CHMSenabled then
		repeat
			wait(1)
		until plr.Character and getRoot(plr.Character)
		CHMS(plr)
	end
end)

-- TextChatService integration
if not isLegacyChat then
	TextChatService.MessageReceived:Connect(function(message)
		if message.TextSource and message.Status ~= Enum.TextChatMessageStatus.InvalidTextChannelPermissions then
			local player = Players:GetPlayerByUserId(message.TextSource.UserId)
			if not player then
				return
			end

			if logsEnabled == true then
				CreateLabel(player.Name, message.Text)
			end
			if player.UserId == Players.LocalPlayer.UserId then
				do_exec(message.Text, Players.LocalPlayer)
			end
			eventEditor.FireEvent("OnChatted", player.Name, message.Text)
			sendChatWebhook(player, message.Text)
		end
	end)
end

-- Hook existing players
for _, plr in pairs(Players:GetPlayers()) do
	pcall(function()
		plr.CharacterAdded:Connect(function()
			eventEditor.FireEvent("OnSpawn", tostring(plr))
			hookCharEvents(plr)
		end)
		hookCharEvents(plr)
	end)
end

-- Spawn commands & event data restore
if spawnCmds and #spawnCmds > 0 then
	for i, v in pairs(spawnCmds) do
		eventEditor.AddCmd("OnSpawn", { v.COMMAND or "", { 0 }, v.DELAY or 0 })
	end
	updatesaves()
end

if loadedEventData then
	eventEditor.LoadData(loadedEventData)
end
eventEditor.Refresh()

eventEditor.FireEvent("OnExecute")

-- Alias loading
if aliases and #aliases > 0 then
	local cmdMap = {}
	for i, v in pairs(cmds) do
		cmdMap[v.NAME:lower()] = v
		for _, alias in pairs(v.ALIAS) do
			cmdMap[alias:lower()] = v
		end
	end
	for i = 1, #aliases do
		local cmd = string.lower(aliases[i].CMD)
		local alias = string.lower(aliases[i].ALIAS)
		if cmdMap[cmd] then
			customAlias[alias] = cmdMap[cmd]
		end
	end
	refreshaliases()
end

-- Mouse tooltip & capture
ZYMouse.Move:Connect(checkTT)

CaptureService.CaptureBegan:Connect(function()
	PARENT.Enabled = false
end)

CaptureService.CaptureEnded:Connect(function()
	task.delay(0.1, function()
		PARENT.Enabled = true
	end)
end)

-- Version check & announcement
task.spawn(function()
	local success, latestVersionInfo = pcall(function()
		local versionJson = game:HttpGet("https://cdn.jsdelivr.net/gh/zero-yield/zero-yield@refs/heads/master/version")
		return HttpService:JSONDecode(versionJson)
	end)

	if success then
		if currentVersion ~= latestVersionInfo.Version then
			notify("Outdated", "Get the new version at https://github.com/zero-yield/zero-yield")
		end

		if latestVersionInfo.Announcement and latestVersionInfo.Announcement ~= "" then
			local AnnGUI = Instance.new("Frame")
			local background = Instance.new("Frame")
			local TextBox = Instance.new("TextLabel")
			local shadow = Instance.new("Frame")
			local PopupText = Instance.new("TextLabel")
			local Exit = Instance.new("TextButton")
			local ExitImage = Instance.new("ImageLabel")

			AnnGUI.Name = randomString()
			AnnGUI.Parent = ScaledHolder
			AnnGUI.Active = true
			AnnGUI.BackgroundTransparency = 1
			AnnGUI.Position = UDim2.new(0.5, -180, 0, -500)
			AnnGUI.Size = UDim2.new(0, 360, 0, 20)
			AnnGUI.ZIndex = 10

			background.Name = "background"
			background.Parent = AnnGUI
			background.Active = true
			background.BackgroundColor3 = currentShade1
			background.BorderSizePixel = 0
			background.Position = UDim2.new(0, 0, 0, 20)
			background.Size = UDim2.new(0, 360, 0, 150)
			background.ZIndex = 10

			TextBox.Parent = background
			TextBox.BackgroundTransparency = 1
			TextBox.Position = UDim2.new(0, 5, 0, 5)
			TextBox.Size = UDim2.new(0, 350, 0, 140)
			TextBox.Font = Enum.Font.SourceSans
			TextBox.TextSize = 18
			TextBox.TextWrapped = true
			TextBox.Text = latestVersionInfo.Announcement
			TextBox.TextColor3 = currentText1
			TextBox.TextXAlignment = Enum.TextXAlignment.Left
			TextBox.TextYAlignment = Enum.TextYAlignment.Top
			TextBox.ZIndex = 10

			shadow.Name = "shadow"
			shadow.Parent = AnnGUI
			shadow.BackgroundColor3 = currentShade2
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
			PopupText.Text = "Server Announcement"
			PopupText.TextColor3 = currentText1
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

			task.wait(1)
			AnnGUI:TweenPosition(UDim2.new(0.5, -180, 0, 150), "InOut", "Quart", 0.5, true, nil)

			Exit.MouseButton1Click:Connect(function()
				AnnGUI:TweenPosition(UDim2.new(0.5, -180, 0, -500), "InOut", "Quart", 0.5, true, nil)
				task.wait(0.6)
				AnnGUI:Destroy()
			end)
		end
	end
end)

-- Intro animation & finalize
task.spawn(function()
	task.wait()
	pcall(function()
		Credits:TweenPosition(UDim2.new(0, 0, 0.9, 0), "Out", "Quart", 0.2)
		Logo:TweenSizeAndPosition(UDim2.new(0, 175, 0, 175), UDim2.new(0, 37, 0, 45), "Out", "Quart", 0.3)
		task.wait(1)
		local OutInfo = TweenInfo.new(1.6809, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
		TweenService:Create(Logo, OutInfo, { ImageTransparency = 1 }):Play()
		TweenService:Create(IntroBackground, OutInfo, { BackgroundTransparency = 1 }):Play()
		Credits:TweenPosition(UDim2.new(0, 0, 0.9, 30), "Out", "Quart", 0.2)
		task.wait(0.2)
	end)
	Logo:Destroy()
	Credits:Destroy()
	IntroBackground:Destroy()
	minimizeHolder()
end)
