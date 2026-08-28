return function(env)
	function onInputBegan(input, gameProcessed)
		if awaitingInput then
			if input.UserInputType == Enum.UserInputType.Keyboard then
				keyPressed = tostring(input.KeyCode)
				BindTo.Text = keyPressed:sub(14)
			elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
				keyPressed = "LeftClick"
				BindTo.Text = "LeftClick"
			elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
				keyPressed = "RightClick"
				BindTo.Text = "RightClick"
			end
			awaitingInput = false
			keySelected = true
		end
		if not gameProcessed and #binds > 0 then
			for i, v in pairs(binds) do
				if not v.ISKEYUP then
					if
						(
							input.UserInputType == Enum.UserInputType.Keyboard
							and v.KEY:lower() == tostring(input.KeyCode):lower()
						)
						or (input.UserInputType == Enum.UserInputType.MouseButton1 and v.KEY:lower() == "leftclick")
						or (input.UserInputType == Enum.UserInputType.MouseButton2 and v.KEY:lower() == "rightclick")
					then
						if v.TOGGLE then
							local isOn = toggleOn[v] == true
							toggleOn[v] = not isOn
							if isOn then
								execCmd(v.TOGGLE, Players.LocalPlayer)
							else
								execCmd(v.COMMAND, Players.LocalPlayer)
							end
						else
							execCmd(v.COMMAND, Players.LocalPlayer)
						end
					end
				end
			end
		end
	end

	function onInputEnded(input, gameProcessed)
		if not gameProcessed and #binds > 0 then
			for i, v in pairs(binds) do
				if v.ISKEYUP then
					if
						(
							input.UserInputType == Enum.UserInputType.Keyboard
							and v.KEY:lower() == tostring(input.KeyCode):lower()
						)
						or (input.UserInputType == Enum.UserInputType.MouseButton1 and v.KEY:lower() == "leftclick")
						or (input.UserInputType == Enum.UserInputType.MouseButton2 and v.KEY:lower() == "rightclick")
					then
						execCmd(v.COMMAND, Players.LocalPlayer)
					end
				end
			end
		end
	end

	UserInputService.InputBegan:Connect(onInputBegan)
	UserInputService.InputEnded:Connect(onInputEnded)

	ClickTP.Select.MouseButton1Click:Connect(function()
		if keySelected then
			addbind("clicktp", keyPressed, bindChosenKeyUp)
			refreshbinds()
			updatesaves()
			if keyPressed == "RightClick" or keyPressed == "LeftClick" then
				notify("Keybinds Updated", "Binded " .. keyPressed .. " to click tp")
			else
				notify("Keybinds Updated", "Binded " .. keyPressed:sub(14) .. " to click tp")
			end
		end
	end)

	ClickDelete.Select.MouseButton1Click:Connect(function()
		if keySelected then
			addbind("clickdel", keyPressed, bindChosenKeyUp)
			refreshbinds()
			updatesaves()
			if keyPressed == "RightClick" or keyPressed == "LeftClick" then
				notify("Keybinds Updated", "Binded " .. keyPressed .. " to click delete")
			else
				notify("Keybinds Updated", "Binded " .. keyPressed:sub(14) .. " to click delete")
			end
		end
	end)

	local function clicktpFunc()
		pcall(function()
			local character = Players.LocalPlayer.Character
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.SeatPart then
				humanoid.Sit = false
				task.wait(0.1)
			end

			local hipHeight = humanoid and humanoid.HipHeight > 0 and (humanoid.HipHeight + 1)
			local rootPart = getRoot(character)
			local rootPartPosition = rootPart.Position
			local hitPosition = ZYMouse.Hit.Position
			local newCFrame = CFrame.new(
				hitPosition,
				Vector3.new(rootPartPosition.X, hitPosition.Y, rootPartPosition.Z)
			) * CFrame.Angles(0, math.pi, 0)

			rootPart.CFrame = newCFrame + Vector3.new(0, hipHeight or 4, 0)
			breakVelocity()
		end)
	end

	ZYMouse.Button1Down:Connect(function()
		for i, v in pairs(binds) do
			if v.COMMAND == "clicktp" then
				local input = v.KEY
				if
					(input == "RightClick" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2))
					or (input == "LeftClick" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1))
					or UserInputService:IsKeyDown(Enum.KeyCode[input:sub(14)])
				then
					if Players.LocalPlayer.Character then
						clicktpFunc()
					end
				end
			elseif v.COMMAND == "clickdel" then
				local input = v.KEY
				if
					(input == "RightClick" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2))
					or (input == "LeftClick" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1))
					or UserInputService:IsKeyDown(Enum.KeyCode[input:sub(14)])
				then
					pcall(function()
						ZYMouse.Target:Destroy()
					end)
				end
			end
		end
	end)

	PluginsGUI = PluginEditor.background

	function addPlugin(name)
		if name:lower() == "plugin file name" or name:lower() == "zy_fe.zy" or name == "zy_fe" then
			notify("Plugin Error", "Please enter a valid plugin")
		else
			local file
			local fileName
			if name:sub(-3) == ".zy" then
				pcall(function()
					file = readfile(name)
				end)
				fileName = name
			else
				pcall(function()
					file = readfile(name .. ".zy")
				end)
				fileName = name .. ".zy"
			end
			if file then
				if not FindInTable(PluginsTable, fileName) then
					table.insert(PluginsTable, fileName)
					LoadPlugin(fileName)
					refreshplugins()
					pcall(eventEditor.Refresh)
				else
					notify("Plugin Error", "This plugin is already added")
				end
			else
				notify("Plugin Error", 'Cannot locate file "' .. fileName .. '". Is the file in the correct folder?')
			end
		end
	end

	function deletePlugin(name)
		local pName = name .. ".zy"
		if name:sub(-3) == ".zy" then
			pName = name
		end
		for i = #cmds, 1, -1 do
			if cmds[i].PLUGIN == pName then
				table.remove(cmds, i)
			end
		end
		for i, v in pairs(CMDsF:GetChildren()) do
			if v.Name == "PLUGIN_" .. pName then
				v:Destroy()
			end
		end
		for i, v in pairs(PluginsTable) do
			if v == pName then
				table.remove(PluginsTable, i)
				notify("Removed Plugin", pName .. " was removed")
			end
		end
		IndexContents("", true)
		refreshplugins()
	end

	function refreshplugins(dontSave)
		if #PluginsTable > 0 then
			PluginsHint:Destroy()
		end
		if Holder_5 then
			Holder_5:ClearAllChildren()
			Holder_5.CanvasSize = UDim2.new(0, 0, 0, 10)
			for i, v in pairs(PluginsTable) do
				local pName = v
				local YSize = 25
				local Position = ((i * YSize) - YSize)
				local newplugin = Example_5:Clone()
				newplugin.Parent = Holder_5
				newplugin.Visible = true
				newplugin.Position = UDim2.new(0, 0, 0, Position + 5)
				newplugin.Text.Text = pName
				table.insert(shade2, newplugin)
				table.insert(shade2, newplugin.Text)
				table.insert(text1, newplugin.Text)
				table.insert(shade3, newplugin.Text.Delete)
				table.insert(text2, newplugin.Text.Delete)
				Holder_5.CanvasSize = UDim2.new(0, 0, 0, Position + 30)
				newplugin.Text.Delete.MouseButton1Click:Connect(function()
					deletePlugin(pName)
				end)
			end
			if not dontSave then
				updatesaves()
			end
		end
	end

	local PluginCache
	function LoadPlugin(val, startup)
		local plugin

		function CatchedPluginLoad()
			plugin = loadfile(val)()
		end

		function handlePluginError(plerror)
			notify("Plugin Error", 'An error occurred with the plugin, "' .. val .. '" and it could not be loaded')
			if FindInTable(PluginsTable, val) then
				for i, v in pairs(PluginsTable) do
					if v == val then
						table.remove(PluginsTable, i)
					end
				end
			end
			updatesaves()

			print("Original Error: " .. tostring(plerror))
			print("Plugin Error, stack traceback: " .. tostring(debug.traceback()))

			plugin = nil

			return false
		end

		xpcall(CatchedPluginLoad, handlePluginError)

		if plugin ~= nil then
			if not startup then
				local pName = plugin["PluginName"] or "Unknown"
				local pDesc = plugin["PluginDescription"] or "No description"
				notify("Loaded Plugin", "Name: " .. pName .. "\n" .. "Description: " .. pDesc)
			end
			addcmdtext("", val)
			addcmdtext(string.upper("--" .. (plugin["PluginName"] or "UNKNOWN")), val, plugin["PluginDescription"])
			if plugin["Commands"] then
				for i, v in pairs(plugin["Commands"]) do
					local cmdExt = ""
					local cmdName = i
					local function handleNames()
						cmdName = i
						if findCmd(cmdName .. cmdExt) then
							if isNumber(cmdExt) then
								cmdExt = cmdExt + 1
							else
								cmdExt = 1
							end
							handleNames()
						else
							cmdName = cmdName .. cmdExt
						end
					end
					handleNames()
					addcmd(cmdName, v["Aliases"], v["Function"], val)
					if v["ListName"] then
						local newName = v.ListName
						local cmdNames = { i, unpack(v.Aliases) }
						for i, v in pairs(cmdNames) do
							newName = newName:gsub(v, v .. cmdExt)
						end
						addcmdtext(newName, val, v["Description"])
					else
						addcmdtext(cmdName, val, v["Description"])
					end
				end
			end
			IndexContents("", true)
		elseif plugin == nil then
			plugin = nil
		end
	end

	function FindPlugins()
		if PluginsTable ~= nil and type(PluginsTable) == "table" then
			for i, v in pairs(PluginsTable) do
				LoadPlugin(v, true)
			end
			refreshplugins(true)
		end
	end

	AddPlugin.MouseButton1Click:Connect(function()
		addPlugin(PluginsGUI.FileName.Text)
	end)

	Exit_3.MouseButton1Click:Connect(function()
		PluginEditor:TweenPosition(UDim2.new(0.5, -180, 0, -500), "InOut", "Quart", 0.5, true, nil)
		FileName.Text = "Plugin File Name"
	end)

	Add_3.MouseButton1Click:Connect(function()
		PluginEditor:TweenPosition(UDim2.new(0.5, -180, 0, 310), "InOut", "Quart", 0.5, true, nil)
	end)

	Plugins.MouseButton1Click:Connect(function()
		if writefileExploit() then
			PluginsFrame:TweenPosition(UDim2.new(0, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
			task.wait(0.5)
			SettingsHolder.Visible = false
		else
			notify("Incompatible Exploit", "Your exploit is unable to use plugins (missing read/writefile)")
		end
	end)

	Close_4.MouseButton1Click:Connect(function()
		SettingsHolder.Visible = true
		PluginsFrame:TweenPosition(UDim2.new(0, 0, 0, 175), "InOut", "Quart", 0.5, true, nil)
	end)

	local TeleportCheck = false
	Players.LocalPlayer.OnTeleport:Connect(function(State)
		if KeepInfYield and not TeleportCheck and queueteleport then
			TeleportCheck = true
			queueteleport(
				"loadstring(game:HttpGet('https://cdn.jsdelivr.net/gh/zero-yield/zero-yield@refs/heads/builds/source.min.luau'))()"
			)
		end
	end)

	return env
end
