return function(env)
ESPenabled = false
CHMSenabled = false

function round(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function ESP(plr, logic)
	task.spawn(function()
		for i, v in pairs(COREGUI:GetChildren()) do
			if v.Name == plr.Name .. "_ESP" then
				v:Destroy()
			end
		end
		wait()
		if
			plr.Character
			and plr.Name ~= Players.LocalPlayer.Name
			and not COREGUI:FindFirstChild(plr.Name .. "_ESP")
		then
			local ESPholder = Instance.new("Folder")
			ESPholder.Name = plr.Name .. "_ESP"
			ESPholder.Parent = COREGUI
			repeat
				wait(1)
			until plr.Character and getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
			for b, n in pairs(plr.Character:GetChildren()) do
				if n:IsA("BasePart") then
					local a = Instance.new("BoxHandleAdornment")
					a.Name = plr.Name
					a.Parent = ESPholder
					a.Adornee = n
					a.AlwaysOnTop = true
					a.ZIndex = 10
					a.Size = n.Size
					a.Transparency = espTransparency
					if logic == true then
						a.Color = BrickColor.new(
							plr.TeamColor == Players.LocalPlayer.TeamColor and "Bright green" or "Bright red"
						)
					else
						a.Color = plr.TeamColor
					end
				end
			end
			if plr.Character and plr.Character:FindFirstChild("Head") then
				local BillboardGui = Instance.new("BillboardGui")
				local TextLabel = Instance.new("TextLabel")
				BillboardGui.Adornee = plr.Character.Head
				BillboardGui.Name = plr.Name
				BillboardGui.Parent = ESPholder
				BillboardGui.Size = UDim2.new(0, 100, 0, 150)
				BillboardGui.StudsOffset = Vector3.new(0, 1, 0)
				BillboardGui.AlwaysOnTop = true
				TextLabel.Parent = BillboardGui
				TextLabel.BackgroundTransparency = 1
				TextLabel.Position = UDim2.new(0, 0, 0, -50)
				TextLabel.Size = UDim2.new(0, 100, 0, 100)
				TextLabel.Font = Enum.Font.SourceSansSemibold
				TextLabel.TextSize = 20
				TextLabel.TextColor3 = Color3.new(1, 1, 1)
				TextLabel.TextStrokeTransparency = 0
				TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
				TextLabel.Text = "Name: " .. plr.Name
				TextLabel.ZIndex = 10
				local espLoopFunc
				local teamChange
				local addedFunc
				addedFunc = plr.CharacterAdded:Connect(function()
					if ESPenabled then
						espLoopFunc:Disconnect()
						teamChange:Disconnect()
						ESPholder:Destroy()
						repeat
							wait(1)
						until getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
						ESP(plr, logic)
						addedFunc:Disconnect()
					else
						teamChange:Disconnect()
						addedFunc:Disconnect()
					end
				end)
				teamChange = plr:GetPropertyChangedSignal("TeamColor"):Connect(function()
					if ESPenabled then
						espLoopFunc:Disconnect()
						addedFunc:Disconnect()
						ESPholder:Destroy()
						repeat
							wait(1)
						until getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
						ESP(plr, logic)
						teamChange:Disconnect()
					else
						teamChange:Disconnect()
					end
				end)
				local function espLoop()
					if COREGUI:FindFirstChild(plr.Name .. "_ESP") then
						if
							plr.Character
							and getRoot(plr.Character)
							and plr.Character:FindFirstChildOfClass("Humanoid")
							and Players.LocalPlayer.Character
							and getRoot(Players.LocalPlayer.Character)
							and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
						then
							local pos = math.floor(
								(getRoot(Players.LocalPlayer.Character).Position - getRoot(plr.Character).Position).magnitude
							)
							TextLabel.Text = "Name: "
								.. plr.Name
								.. " | Health: "
								.. round(plr.Character:FindFirstChildOfClass("Humanoid").Health, 1)
								.. " | Studs: "
								.. pos
						end
					else
						teamChange:Disconnect()
						addedFunc:Disconnect()
						espLoopFunc:Disconnect()
					end
				end
				espLoopFunc = RunService.RenderStepped:Connect(espLoop)
			end
		end
	end)
end

function CHMS(plr)
	task.spawn(function()
		for i, v in pairs(COREGUI:GetChildren()) do
			if v.Name == plr.Name .. "_CHMS" then
				v:Destroy()
			end
		end
		wait()
		if
			plr.Character
			and plr.Name ~= Players.LocalPlayer.Name
			and not COREGUI:FindFirstChild(plr.Name .. "_CHMS")
		then
			local ESPholder = Instance.new("Folder")
			ESPholder.Name = plr.Name .. "_CHMS"
			ESPholder.Parent = COREGUI
			repeat
				wait(1)
			until plr.Character and getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
			for b, n in pairs(plr.Character:GetChildren()) do
				if n:IsA("BasePart") then
					local a = Instance.new("BoxHandleAdornment")
					a.Name = plr.Name
					a.Parent = ESPholder
					a.Adornee = n
					a.AlwaysOnTop = true
					a.ZIndex = 10
					a.Size = n.Size
					a.Transparency = espTransparency
					a.Color = plr.TeamColor
				end
			end
			local addedFunc
			local teamChange
			local CHMSremoved
			addedFunc = plr.CharacterAdded:Connect(function()
				if CHMSenabled then
					ESPholder:Destroy()
					teamChange:Disconnect()
					repeat
						wait(1)
					until getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
					CHMS(plr)
					addedFunc:Disconnect()
				else
					teamChange:Disconnect()
					addedFunc:Disconnect()
				end
			end)
			teamChange = plr:GetPropertyChangedSignal("TeamColor"):Connect(function()
				if CHMSenabled then
					ESPholder:Destroy()
					addedFunc:Disconnect()
					repeat
						wait(1)
					until getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
					CHMS(plr)
					teamChange:Disconnect()
				else
					teamChange:Disconnect()
				end
			end)
			CHMSremoved = ESPholder.AncestryChanged:Connect(function()
				teamChange:Disconnect()
				addedFunc:Disconnect()
				CHMSremoved:Disconnect()
			end)
		end
	end)
end

function Locate(plr)
	task.spawn(function()
		for i, v in pairs(COREGUI:GetChildren()) do
			if v.Name == plr.Name .. "_LC" then
				v:Destroy()
			end
		end
		wait()
		if plr.Character and plr.Name ~= Players.LocalPlayer.Name and not COREGUI:FindFirstChild(plr.Name .. "_LC") then
			local ESPholder = Instance.new("Folder")
			ESPholder.Name = plr.Name .. "_LC"
			ESPholder.Parent = COREGUI
			repeat
				wait(1)
			until plr.Character and getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
			for b, n in pairs(plr.Character:GetChildren()) do
				if n:IsA("BasePart") then
					local a = Instance.new("BoxHandleAdornment")
					a.Name = plr.Name
					a.Parent = ESPholder
					a.Adornee = n
					a.AlwaysOnTop = true
					a.ZIndex = 10
					a.Size = n.Size
					a.Transparency = espTransparency
					a.Color = plr.TeamColor
				end
			end
			if plr.Character and plr.Character:FindFirstChild("Head") then
				local BillboardGui = Instance.new("BillboardGui")
				local TextLabel = Instance.new("TextLabel")
				BillboardGui.Adornee = plr.Character.Head
				BillboardGui.Name = plr.Name
				BillboardGui.Parent = ESPholder
				BillboardGui.Size = UDim2.new(0, 100, 0, 150)
				BillboardGui.StudsOffset = Vector3.new(0, 1, 0)
				BillboardGui.AlwaysOnTop = true
				TextLabel.Parent = BillboardGui
				TextLabel.BackgroundTransparency = 1
				TextLabel.Position = UDim2.new(0, 0, 0, -50)
				TextLabel.Size = UDim2.new(0, 100, 0, 100)
				TextLabel.Font = Enum.Font.SourceSansSemibold
				TextLabel.TextSize = 20
				TextLabel.TextColor3 = Color3.new(1, 1, 1)
				TextLabel.TextStrokeTransparency = 0
				TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
				TextLabel.Text = "Name: " .. plr.Name
				TextLabel.ZIndex = 10
				local lcLoopFunc
				local addedFunc
				local teamChange
				addedFunc = plr.CharacterAdded:Connect(function()
					if ESPholder ~= nil and ESPholder.Parent ~= nil then
						lcLoopFunc:Disconnect()
						teamChange:Disconnect()
						ESPholder:Destroy()
						repeat
							wait(1)
						until getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
						Locate(plr)
						addedFunc:Disconnect()
					else
						teamChange:Disconnect()
						addedFunc:Disconnect()
					end
				end)
				teamChange = plr:GetPropertyChangedSignal("TeamColor"):Connect(function()
					if ESPholder ~= nil and ESPholder.Parent ~= nil then
						lcLoopFunc:Disconnect()
						addedFunc:Disconnect()
						ESPholder:Destroy()
						repeat
							wait(1)
						until getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
						Locate(plr)
						teamChange:Disconnect()
					else
						teamChange:Disconnect()
					end
				end)
				local function lcLoop()
					if COREGUI:FindFirstChild(plr.Name .. "_LC") then
						if
							plr.Character
							and getRoot(plr.Character)
							and plr.Character:FindFirstChildOfClass("Humanoid")
							and Players.LocalPlayer.Character
							and getRoot(Players.LocalPlayer.Character)
							and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
						then
							local pos = math.floor(
								(getRoot(Players.LocalPlayer.Character).Position - getRoot(plr.Character).Position).magnitude
							)
							TextLabel.Text = "Name: "
								.. plr.Name
								.. " | Health: "
								.. round(plr.Character:FindFirstChildOfClass("Humanoid").Health, 1)
								.. " | Studs: "
								.. pos
						end
					else
						teamChange:Disconnect()
						addedFunc:Disconnect()
						lcLoopFunc:Disconnect()
					end
				end
				lcLoopFunc = RunService.RenderStepped:Connect(lcLoop)
			end
		end
	end)
end

local bindsGUI = KeybindEditor
local awaitingInput = false
local keySelected = false

function refreshbinds()
	if Holder_2 then
		Holder_2:ClearAllChildren()
		Holder_2.CanvasSize = UDim2.new(0, 0, 0, 10)
		for i = 1, #binds do
			local YSize = 25
			local Position = ((i * YSize) - YSize)
			local newbind = Example_2:Clone()
			newbind.Parent = Holder_2
			newbind.Visible = true
			newbind.Position = UDim2.new(0, 0, 0, Position + 5)
			table.insert(shade2, newbind)
			table.insert(shade2, newbind.Text)
			table.insert(text1, newbind.Text)
			table.insert(shade3, newbind.Text.Delete)
			table.insert(text2, newbind.Text.Delete)
			local input = tostring(binds[i].KEY)
			local key
			if input == "RightClick" or input == "LeftClick" then
				key = input
			else
				key = input:sub(14)
			end
			if binds[i].TOGGLE then
				newbind.Text.Text = key .. " > " .. binds[i].COMMAND .. " / " .. binds[i].TOGGLE
			else
				newbind.Text.Text = key
					.. " > "
					.. binds[i].COMMAND
					.. "  "
					.. (binds[i].ISKEYUP and "(keyup)" or "(keydown)")
			end
			Holder_2.CanvasSize = UDim2.new(0, 0, 0, Position + 30)
			newbind.Text.Delete.MouseButton1Click:Connect(function()
				unkeybind(binds[i].COMMAND, binds[i].KEY)
			end)
		end
	end
end

refreshbinds()

toggleOn = {}

function unkeybind(cmd, key)
	for i = #binds, 1, -1 do
		if binds[i].COMMAND == cmd and binds[i].KEY == key then
			toggleOn[binds[i]] = nil
			table.remove(binds, i)
		end
	end
	refreshbinds()
	updatesaves()
	if key == "RightClick" or key == "LeftClick" then
		notify("Keybinds Updated", "Unbinded " .. key .. " from " .. cmd)
	else
		notify("Keybinds Updated", "Unbinded " .. key:sub(14) .. " from " .. cmd)
	end
end

PositionsFrame.Delete.MouseButton1Click:Connect(function()
	execCmd("cpos")
end)

function refreshwaypoints()
	if #WayPoints > 0 or #pWayPoints > 0 then
		PositionsHint:Destroy()
	end
	if Holder_4 then
		Holder_4:ClearAllChildren()
		Holder_4.CanvasSize = UDim2.new(0, 0, 0, 10)
		local YSize = 25
		local num = 1
		for i = 1, #WayPoints do
			local Position = ((num * YSize) - YSize)
			local newpoint = Example_4:Clone()
			newpoint.Parent = Holder_4
			newpoint.Visible = true
			newpoint.Position = UDim2.new(0, 0, 0, Position + 5)
			newpoint.Text.Text = WayPoints[i].NAME
			table.insert(shade2, newpoint)
			table.insert(shade2, newpoint.Text)
			table.insert(text1, newpoint.Text)
			table.insert(shade3, newpoint.Text.Delete)
			table.insert(text2, newpoint.Text.Delete)
			table.insert(shade3, newpoint.Text.TP)
			table.insert(text2, newpoint.Text.TP)
			Holder_4.CanvasSize = UDim2.new(0, 0, 0, Position + 30)
			newpoint.Text.Delete.MouseButton1Click:Connect(function()
				execCmd("dpos " .. WayPoints[i].NAME)
			end)
			newpoint.Text.TP.MouseButton1Click:Connect(function()
				execCmd("loadpos " .. WayPoints[i].NAME)
			end)
			num = num + 1
		end
		for i = 1, #pWayPoints do
			local Position = ((num * YSize) - YSize)
			local newpoint = Example_4:Clone()
			newpoint.Parent = Holder_4
			newpoint.Visible = true
			newpoint.Position = UDim2.new(0, 0, 0, Position + 5)
			newpoint.Text.Text = pWayPoints[i].NAME
			table.insert(shade2, newpoint)
			table.insert(shade2, newpoint.Text)
			table.insert(text1, newpoint.Text)
			table.insert(shade3, newpoint.Text.Delete)
			table.insert(text2, newpoint.Text.Delete)
			table.insert(shade3, newpoint.Text.TP)
			table.insert(text2, newpoint.Text.TP)
			Holder_4.CanvasSize = UDim2.new(0, 0, 0, Position + 30)
			newpoint.Text.Delete.MouseButton1Click:Connect(function()
				execCmd("dpos " .. pWayPoints[i].NAME)
			end)
			newpoint.Text.TP.MouseButton1Click:Connect(function()
				execCmd("loadpos " .. pWayPoints[i].NAME)
			end)
			num = num + 1
		end
	end
end

refreshwaypoints()

function refreshaliases()
	if #aliases > 0 then
		AliasHint:Destroy()
	end
	if Holder_3 then
		Holder_3:ClearAllChildren()
		Holder_3.CanvasSize = UDim2.new(0, 0, 0, 10)
		for i = 1, #aliases do
			local YSize = 25
			local Position = ((i * YSize) - YSize)
			local newalias = Example_3:Clone()
			newalias.Parent = Holder_3
			newalias.Visible = true
			newalias.Position = UDim2.new(0, 0, 0, Position + 5)
			newalias.Text.Text = aliases[i].CMD .. " > " .. aliases[i].ALIAS
			table.insert(shade2, newalias)
			table.insert(shade2, newalias.Text)
			table.insert(text1, newalias.Text)
			table.insert(shade3, newalias.Text.Delete)
			table.insert(text2, newalias.Text.Delete)
			Holder_3.CanvasSize = UDim2.new(0, 0, 0, Position + 30)
			newalias.Text.Delete.MouseButton1Click:Connect(function()
				execCmd("removealias " .. aliases[i].ALIAS)
			end)
		end
	end
end

local bindChosenKeyUp = false

BindTo.MouseButton1Click:Connect(function()
	awaitingInput = true
	BindTo.Text = "Press something"
end)

BindTriggerSelect.MouseButton1Click:Connect(function()
	bindChosenKeyUp = not bindChosenKeyUp
	BindTriggerSelect.Text = bindChosenKeyUp and "KeyUp" or "KeyDown"
end)

newToggle = false
Cmdbar_3.Parent.Visible = false
On_2.MouseButton1Click:Connect(function()
	if newToggle == false then
		newToggle = true
		On_2.BackgroundTransparency = 0
		Cmdbar_3.Parent.Visible = true
		BindTriggerSelect.Visible = false
	else
		newToggle = false
		On_2.BackgroundTransparency = 1
		Cmdbar_3.Parent.Visible = false
		BindTriggerSelect.Visible = true
	end
end)

Add_2.MouseButton1Click:Connect(function()
	if keySelected then
		if string.find(Cmdbar_2.Text, "\\\\") or string.find(Cmdbar_3.Text, "\\\\") then
			notify("Keybind Error", "Only use one backslash to keybind multiple commands into one keybind or command")
		else
			if newToggle and Cmdbar_3.Text ~= "" and Cmdbar_2.text ~= "" then
				addbind(Cmdbar_2.Text, keyPressed, false, Cmdbar_3.Text)
			elseif not newToggle and Cmdbar_2.text ~= "" then
				addbind(Cmdbar_2.Text, keyPressed, bindChosenKeyUp)
			else
				return
			end
			refreshbinds()
			updatesaves()
			if keyPressed == "RightClick" or keyPressed == "LeftClick" then
				notify(
					"Keybinds Updated",
					"Binded " .. keyPressed .. " to " .. Cmdbar_2.Text .. (newToggle and " / " .. Cmdbar_3.Text or "")
				)
			else
				notify(
					"Keybinds Updated",
					"Binded "
						.. keyPressed:sub(14)
						.. " to "
						.. Cmdbar_2.Text
						.. (newToggle and " / " .. Cmdbar_3.Text or "")
				)
			end
		end
	end
end)

Exit_2.MouseButton1Click:Connect(function()
	Cmdbar_2.Text = "Command"
	Cmdbar_3.Text = "Command 2"
	BindTo.Text = "Click to bind"
	bindChosenKeyUp = false
	BindTriggerSelect.Text = "KeyDown"
	keySelected = false
	KeybindEditor:TweenPosition(UDim2.new(0.5, -180, 0, -500), "InOut", "Quart", 0.5, true, nil)
end)


	return env
end
