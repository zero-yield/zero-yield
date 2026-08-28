return function(env)
	eventEditor = (function()
		local events = {}

		local function registerEvent(name, sets)
			events[name] = {
				commands = {},
				sets = sets or {},
			}
		end

		local onEdited = nil

		local function fireEvent(name, ...)
			local args = { ... }
			local event = events[name]
			if event then
				for i, cmd in pairs(event.commands) do
					local metCondition = true
					for idx, set in pairs(event.sets) do
						local argVal = args[idx]
						local cmdSet = cmd[2][idx]
						local condType = set.Type
						if condType == "Player" then
							if cmdSet == 0 then
								metCondition = metCondition and (tostring(Players.LocalPlayer) == argVal)
							elseif cmdSet ~= 1 then
								metCondition = metCondition
									and table.find(getPlayer(cmdSet, Players.LocalPlayer), argVal)
							end
						elseif condType == "String" then
							if cmdSet ~= 0 then
								metCondition = metCondition and string.find(argVal:lower(), cmdSet:lower())
							end
						elseif condType == "Number" then
							if cmdSet ~= 0 then
								metCondition = metCondition and tonumber(argVal) <= tonumber(cmdSet)
							end
						end
						if not metCondition then
							break
						end
					end

					if metCondition then
						pcall(task.spawn(function()
							local cmdStr = cmd[1]
							for count, arg in pairs(args) do
								cmdStr = cmdStr:gsub("%$" .. count, arg)
							end
							if cmdStr:lower():match("plugin") then
								return
							end
							task.wait(cmd[3] or 0)
							execCmd(cmdStr)
						end))
					end
				end
			end
		end

		local main = create({
			{
				1,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "EventEditor",
					Position = UDim2.new(0.5, -175, 0, -500),
					Size = UDim2.new(0, 350, 0, 20),
					ZIndex = 10,
				},
			},
			{
				2,
				"Frame",
				{
					BackgroundColor3 = currentShade2,
					BorderSizePixel = 0,
					Name = "TopBar",
					Parent = { 1 },
					Size = UDim2.new(1, 0, 0, 20),
					ZIndex = 10,
				},
			},
			{
				3,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Title",
					Parent = { 2 },
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 0.95, 0),
					Text = "Event Editor",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextXAlignment = Enum.TextXAlignment.Center,
					ZIndex = 10,
				},
			},
			{
				4,
				"TextButton",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Close",
					Parent = { 2 },
					Position = UDim2.new(1, -20, 0, 0),
					Size = UDim2.new(0, 20, 0, 20),
					Text = "",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					ZIndex = 10,
				},
			},
			{
				5,
				"ImageLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Image = getcustomasset("zeroyield/assets/close.png"),
					Parent = { 4 },
					Position = UDim2.new(0, 5, 0, 5),
					Size = UDim2.new(0, 10, 0, 10),
					ZIndex = 10,
				},
			},
			{
				6,
				"Frame",
				{
					BackgroundColor3 = currentShade1,
					BorderSizePixel = 0,
					Name = "Content",
					Parent = { 1 },
					Position = UDim2.new(0, 0, 0, 20),
					Size = UDim2.new(1, 0, 0, 202),
					ZIndex = 10,
				},
			},
			{
				7,
				"ScrollingFrame",
				{
					BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945),
					BorderSizePixel = 0,
					BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					CanvasSize = UDim2.new(0, 0, 0, 100),
					Name = "List",
					Parent = { 6 },
					Position = UDim2.new(0, 5, 0, 5),
					ScrollBarImageColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052),
					ScrollBarThickness = 8,
					Size = UDim2.new(1, -10, 1, -10),
					TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					ZIndex = 10,
				},
			},
			{
				8,
				"Frame",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Name = "Holder",
					Parent = { 7 },
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 10,
				},
			},
			{ 9, "UIListLayout", { Parent = { 8 }, SortOrder = 2 } },
			{
				10,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.new(0.3137255012989, 0.3137255012989, 0.3137255012989),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Name = "Settings",
					Parent = { 6 },
					Position = UDim2.new(1, 0, 0, 0),
					Size = UDim2.new(0, 150, 1, 0),
					ZIndex = 10,
				},
			},
			{
				11,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833),
					Name = "Slider",
					Parent = { 10 },
					Position = UDim2.new(0, -150, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 10,
				},
			},
			{
				12,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.23529413342476, 0.23529413342476, 0.23529413342476),
					BorderColor3 = Color3.new(0.3137255012989, 0.3137255012989, 0.3137255012989),
					BorderSizePixel = 0,
					Name = "Line",
					Parent = { 11 },
					Size = UDim2.new(0, 1, 1, 0),
					ZIndex = 10,
				},
			},
			{
				13,
				"ScrollingFrame",
				{
					BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945),
					BorderSizePixel = 0,
					BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					CanvasSize = UDim2.new(0, 0, 0, 100),
					Name = "List",
					Parent = { 11 },
					Position = UDim2.new(0, 0, 0, 25),
					ScrollBarImageColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052),
					ScrollBarThickness = 8,
					Size = UDim2.new(1, 0, 1, -25),
					TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					ZIndex = 10,
				},
			},
			{
				14,
				"Frame",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Name = "Holder",
					Parent = { 13 },
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 10,
				},
			},
			{ 15, "UIListLayout", { Parent = { 14 }, SortOrder = 2 } },
			{
				16,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Title",
					Parent = { 11 },
					Size = UDim2.new(1, 0, 0, 20),
					Text = "Event Settings",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					ZIndex = 10,
				},
			},
			{
				17,
				"TextButton",
				{
					BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833),
					BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945),
					Font = 3,
					Name = "Close",
					BorderSizePixel = 0,
					Parent = { 11 },
					Position = UDim2.new(1, -20, 0, 0),
					Size = UDim2.new(0, 20, 0, 20),
					Text = "<",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 18,
					ZIndex = 10,
				},
			},
			{ 18, "Folder", { Name = "Templates", Parent = { 10 } } },
			{
				19,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.19607844948769, 0.19607844948769, 0.19607844948769),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945),
					Name = "Players",
					Parent = { 18 },
					Position = UDim2.new(0, 0, 0, 25),
					Size = UDim2.new(1, 0, 0, 86),
					Visible = false,
					ZIndex = 10,
				},
			},
			{
				20,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Title",
					Parent = { 19 },
					Size = UDim2.new(1, 0, 0, 20),
					Text = "Choose Players",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					ZIndex = 10,
				},
			},
			{
				21,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Font = 3,
					Name = "Any",
					Parent = { 19 },
					Position = UDim2.new(0, 5, 0, 42),
					Size = UDim2.new(1, -10, 0, 20),
					Text = "Any Player",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				22,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052),
					BorderSizePixel = 0,
					Name = "Button",
					Parent = { 21 },
					Position = UDim2.new(1, -20, 0, 0),
					Size = UDim2.new(0, 20, 0, 20),
					ZIndex = 10,
				},
			},
			{
				23,
				"TextButton",
				{
					BackgroundColor3 = Color3.new(0.58823531866074, 0.58823531866074, 0.59215688705444),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Font = 3,
					Name = "On",
					Parent = { 22 },
					Position = UDim2.new(0, 2, 0, 2),
					Size = UDim2.new(0, 16, 0, 16),
					Text = "",
					TextColor3 = Color3.new(0, 0, 0),
					TextSize = 14,
					ZIndex = 10,
				},
			},
			{
				24,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Font = 3,
					Name = "Me",
					Parent = { 19 },
					Position = UDim2.new(0, 5, 0, 20),
					Size = UDim2.new(1, -10, 0, 20),
					Text = "Me Only",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				25,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052),
					BorderSizePixel = 0,
					Name = "Button",
					Parent = { 24 },
					Position = UDim2.new(1, -20, 0, 0),
					Size = UDim2.new(0, 20, 0, 20),
					ZIndex = 10,
				},
			},
			{
				26,
				"TextButton",
				{
					BackgroundColor3 = Color3.new(0.58823531866074, 0.58823531866074, 0.59215688705444),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Font = 3,
					Name = "On",
					Parent = { 25 },
					Position = UDim2.new(0, 2, 0, 2),
					Size = UDim2.new(0, 16, 0, 16),
					Text = "",
					TextColor3 = Color3.new(0, 0, 0),
					TextSize = 14,
					ZIndex = 10,
				},
			},
			{
				27,
				"TextBox",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945),
					BorderSizePixel = 0,
					ClearTextOnFocus = false,
					Font = 3,
					Name = "Custom",
					Parent = { 19 },
					PlaceholderColor3 = Color3.new(0.47058826684952, 0.47058826684952, 0.47058826684952),
					PlaceholderText = "Custom Player Set",
					Position = UDim2.new(0, 5, 0, 64),
					Size = UDim2.new(1, -35, 0, 20),
					Text = "",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				28,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052),
					BorderSizePixel = 0,
					Name = "CustomButton",
					Parent = { 19 },
					Position = UDim2.new(1, -25, 0, 64),
					Size = UDim2.new(0, 20, 0, 20),
					ZIndex = 10,
				},
			},
			{
				29,
				"TextButton",
				{
					BackgroundColor3 = Color3.new(0.58823531866074, 0.58823531866074, 0.59215688705444),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Font = 3,
					Name = "On",
					Parent = { 28 },
					Position = UDim2.new(0, 2, 0, 2),
					Size = UDim2.new(0, 16, 0, 16),
					Text = "",
					TextColor3 = Color3.new(0, 0, 0),
					TextSize = 14,
					ZIndex = 10,
				},
			},
			{
				30,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.19607844948769, 0.19607844948769, 0.19607844948769),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945),
					Name = "Strings",
					Parent = { 18 },
					Position = UDim2.new(0, 0, 0, 25),
					Size = UDim2.new(1, 0, 0, 64),
					Visible = false,
					ZIndex = 10,
				},
			},
			{
				31,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Title",
					Parent = { 30 },
					Size = UDim2.new(1, 0, 0, 20),
					Text = "Choose String",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					ZIndex = 10,
				},
			},
			{
				32,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Font = 3,
					Name = "Any",
					Parent = { 30 },
					Position = UDim2.new(0, 5, 0, 20),
					Size = UDim2.new(1, -10, 0, 20),
					Text = "Any String",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				33,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052),
					BorderSizePixel = 0,
					Name = "Button",
					Parent = { 32 },
					Position = UDim2.new(1, -20, 0, 0),
					Size = UDim2.new(0, 20, 0, 20),
					ZIndex = 10,
				},
			},
			{
				34,
				"TextButton",
				{
					BackgroundColor3 = Color3.new(0.58823531866074, 0.58823531866074, 0.59215688705444),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Font = 3,
					Name = "On",
					Parent = { 33 },
					Position = UDim2.new(0, 2, 0, 2),
					Size = UDim2.new(0, 16, 0, 16),
					Text = "",
					TextColor3 = Color3.new(0, 0, 0),
					TextSize = 14,
					ZIndex = 10,
				},
			},
			{
				54,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.19607844948769, 0.19607844948769, 0.19607844948769),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945),
					Name = "Numbers",
					Parent = { 18 },
					Position = UDim2.new(0, 0, 0, 25),
					Size = UDim2.new(1, 0, 0, 64),
					Visible = false,
					ZIndex = 10,
				},
			},
			{
				55,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Title",
					Parent = { 54 },
					Size = UDim2.new(1, 0, 0, 20),
					Text = "Choose String",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					ZIndex = 10,
				},
			},
			{
				56,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Font = 3,
					Name = "Any",
					Parent = { 54 },
					Position = UDim2.new(0, 5, 0, 20),
					Size = UDim2.new(1, -10, 0, 20),
					Text = "Any Number",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				57,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052),
					BorderSizePixel = 0,
					Name = "Button",
					Parent = { 56 },
					Position = UDim2.new(1, -20, 0, 0),
					Size = UDim2.new(0, 20, 0, 20),
					ZIndex = 10,
				},
			},
			{
				58,
				"TextButton",
				{
					BackgroundColor3 = Color3.new(0.58823531866074, 0.58823531866074, 0.59215688705444),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Font = 3,
					Name = "On",
					Parent = { 57 },
					Position = UDim2.new(0, 2, 0, 2),
					Size = UDim2.new(0, 16, 0, 16),
					Text = "",
					TextColor3 = Color3.new(0, 0, 0),
					TextSize = 14,
					ZIndex = 10,
				},
			},
			{
				59,
				"TextBox",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945),
					BorderSizePixel = 0,
					ClearTextOnFocus = false,
					Font = 3,
					Name = "Custom",
					Parent = { 54 },
					PlaceholderColor3 = Color3.new(0.47058826684952, 0.47058826684952, 0.47058826684952),
					PlaceholderText = "Number",
					Position = UDim2.new(0, 5, 0, 42),
					Size = UDim2.new(1, -35, 0, 20),
					Text = "",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				60,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052),
					BorderSizePixel = 0,
					Name = "CustomButton",
					Parent = { 54 },
					Position = UDim2.new(1, -25, 0, 42),
					Size = UDim2.new(0, 20, 0, 20),
					ZIndex = 10,
				},
			},
			{
				61,
				"TextButton",
				{
					BackgroundColor3 = Color3.new(0.58823531866074, 0.58823531866074, 0.59215688705444),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Font = 3,
					Name = "On",
					Parent = { 60 },
					Position = UDim2.new(0, 2, 0, 2),
					Size = UDim2.new(0, 16, 0, 16),
					Text = "",
					TextColor3 = Color3.new(0, 0, 0),
					TextSize = 14,
					ZIndex = 10,
				},
			},
			{
				35,
				"TextBox",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945),
					BorderSizePixel = 0,
					ClearTextOnFocus = false,
					Font = 3,
					Name = "Custom",
					Parent = { 30 },
					PlaceholderColor3 = Color3.new(0.47058826684952, 0.47058826684952, 0.47058826684952),
					PlaceholderText = "Match String",
					Position = UDim2.new(0, 5, 0, 42),
					Size = UDim2.new(1, -35, 0, 20),
					Text = "",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				36,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052),
					BorderSizePixel = 0,
					Name = "CustomButton",
					Parent = { 30 },
					Position = UDim2.new(1, -25, 0, 42),
					Size = UDim2.new(0, 20, 0, 20),
					ZIndex = 10,
				},
			},
			{
				37,
				"TextButton",
				{
					BackgroundColor3 = Color3.new(0.58823531866074, 0.58823531866074, 0.59215688705444),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Font = 3,
					Name = "On",
					Parent = { 36 },
					Position = UDim2.new(0, 2, 0, 2),
					Size = UDim2.new(0, 16, 0, 16),
					Text = "",
					TextColor3 = Color3.new(0, 0, 0),
					TextSize = 14,
					ZIndex = 10,
				},
			},
			{
				38,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.19607844948769, 0.19607844948769, 0.19607844948769),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945),
					Name = "DelayEditor",
					Parent = { 18 },
					Position = UDim2.new(0, 0, 0, 25),
					Size = UDim2.new(1, 0, 0, 24),
					Visible = false,
					ZIndex = 10,
				},
			},
			{
				39,
				"TextBox",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945),
					BorderSizePixel = 0,
					Font = 3,
					Name = "Secs",
					Parent = { 38 },
					PlaceholderColor3 = Color3.new(0.47058826684952, 0.47058826684952, 0.47058826684952),
					Position = UDim2.new(0, 60, 0, 2),
					Size = UDim2.new(1, -65, 0, 20),
					Text = "",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				40,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Font = 3,
					Name = "Label",
					Parent = { 39 },
					Position = UDim2.new(0, -55, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "Delay (s):",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				41,
				"Frame",
				{
					BackgroundColor3 = currentShade1,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Name = "EventTemplate",
					Parent = { 6 },
					Size = UDim2.new(1, 0, 0, 20),
					Visible = false,
					ZIndex = 10,
				},
			},
			{
				42,
				"TextButton",
				{
					BackgroundColor3 = currentText1,
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Expand",
					Parent = { 41 },
					Size = UDim2.new(0, 20, 0, 20),
					Text = ">",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 18,
					ZIndex = 10,
				},
			},
			{
				43,
				"TextLabel",
				{
					BackgroundColor3 = currentText1,
					BackgroundTransparency = 1,
					Font = 3,
					Name = "EventName",
					Parent = { 41 },
					Position = UDim2.new(0, 25, 0, 0),
					Size = UDim2.new(1, -25, 0, 20),
					Text = "OnSpawn",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				44,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.19607844948769, 0.19607844948769, 0.19607844948769),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					Name = "Cmds",
					Parent = { 41 },
					Position = UDim2.new(0, 0, 0, 20),
					Size = UDim2.new(1, 0, 1, -20),
					ZIndex = 10,
				},
			},
			{
				45,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833),
					BorderColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					Name = "Add",
					Parent = { 44 },
					Position = UDim2.new(0, 0, 1, -20),
					Size = UDim2.new(1, 0, 0, 20),
					ZIndex = 10,
				},
			},
			{
				46,
				"TextBox",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					ClearTextOnFocus = false,
					Font = 3,
					Parent = { 45 },
					PlaceholderColor3 = Color3.new(0.7843137383461, 0.7843137383461, 0.7843137383461),
					PlaceholderText = "Add new command",
					Position = UDim2.new(0, 5, 0, 0),
					Size = UDim2.new(1, -10, 1, 0),
					Text = "",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				47,
				"Frame",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Name = "Holder",
					Parent = { 44 },
					Size = UDim2.new(1, 0, 1, -20),
					ZIndex = 10,
				},
			},
			{ 48, "UIListLayout", { Parent = { 47 }, SortOrder = 2 } },
			{
				49,
				"Frame",
				{
					BackgroundColor3 = currentShade1,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Name = "CmdTemplate",
					Parent = { 6 },
					Size = UDim2.new(1, 0, 0, 20),
					Visible = false,
					ZIndex = 10,
				},
			},
			{
				50,
				"TextBox",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					ClearTextOnFocus = false,
					Font = 3,
					Parent = { 49 },
					PlaceholderColor3 = Color3.new(1, 1, 1),
					Position = UDim2.new(0, 5, 0, 0),
					Size = UDim2.new(1, -45, 0, 20),
					Text = "a\\b\\c\\d",
					TextColor3 = currentText1,
					TextSize = 14,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				51,
				"TextButton",
				{
					BackgroundColor3 = currentShade1,
					BorderSizePixel = 0,
					Font = 3,
					Name = "Delete",
					Parent = { 49 },
					Position = UDim2.new(1, -20, 0, 0),
					Size = UDim2.new(0, 20, 0, 20),
					Text = "X",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 18,
					ZIndex = 10,
				},
			},
			{
				52,
				"TextButton",
				{
					BackgroundColor3 = currentShade1,
					BorderSizePixel = 0,
					Font = 3,
					Name = "Settings",
					Parent = { 49 },
					Position = UDim2.new(1, -40, 0, 0),
					Size = UDim2.new(0, 20, 0, 20),
					Text = "",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 18,
					ZIndex = 10,
				},
			},
			{
				53,
				"ImageLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Image = getcustomasset("zeroyield/assets/settings.png"),
					Parent = { 52 },
					Position = UDim2.new(0, 2, 0, 2),
					Size = UDim2.new(0, 16, 0, 16),
					ZIndex = 10,
				},
			},
		})
		main.Name = randomString()
		local mainFrame = main:WaitForChild("Content")
		local eventList = mainFrame:WaitForChild("List")
		local eventListHolder = eventList:WaitForChild("Holder")
		local cmdTemplate = mainFrame:WaitForChild("CmdTemplate")
		local eventTemplate = mainFrame:WaitForChild("EventTemplate")
		local settingsFrame = mainFrame:WaitForChild("Settings"):WaitForChild("Slider")
		local settingsTemplates = mainFrame.Settings:WaitForChild("Templates")
		local settingsList = settingsFrame:WaitForChild("List"):WaitForChild("Holder")
		table.insert(shade2, main.TopBar)
		table.insert(shade1, mainFrame)
		table.insert(shade2, eventTemplate)
		table.insert(text1, eventTemplate.EventName)
		table.insert(shade1, eventTemplate.Cmds.Add)
		table.insert(shade1, cmdTemplate)
		table.insert(text1, cmdTemplate.TextBox)
		table.insert(shade2, cmdTemplate.Delete)
		table.insert(shade2, cmdTemplate.Settings)
		table.insert(scroll, mainFrame.List)
		table.insert(shade1, settingsFrame)
		table.insert(shade2, settingsFrame.Line)
		table.insert(shade2, settingsFrame.Close)
		table.insert(scroll, settingsFrame.List)
		table.insert(shade2, settingsTemplates.DelayEditor.Secs)
		table.insert(text1, settingsTemplates.DelayEditor.Secs)
		table.insert(text1, settingsTemplates.DelayEditor.Secs.Label)
		table.insert(text1, settingsTemplates.Players.Title)
		table.insert(shade3, settingsTemplates.Players.CustomButton)
		table.insert(shade2, settingsTemplates.Players.Custom)
		table.insert(text1, settingsTemplates.Players.Custom)
		table.insert(shade3, settingsTemplates.Players.Any.Button)
		table.insert(shade3, settingsTemplates.Players.Me.Button)
		table.insert(text1, settingsTemplates.Players.Any)
		table.insert(text1, settingsTemplates.Players.Me)
		table.insert(text1, settingsTemplates.Strings.Title)
		table.insert(text1, settingsTemplates.Strings.Any)
		table.insert(shade3, settingsTemplates.Strings.Any.Button)
		table.insert(shade3, settingsTemplates.Strings.CustomButton)
		table.insert(text1, settingsTemplates.Strings.Custom)
		table.insert(shade2, settingsTemplates.Strings.Custom)
		table.insert(text1, settingsTemplates.Players.Me)
		table.insert(text1, settingsTemplates.Numbers.Title)
		table.insert(text1, settingsTemplates.Numbers.Any)
		table.insert(shade3, settingsTemplates.Numbers.Any.Button)
		table.insert(shade3, settingsTemplates.Numbers.CustomButton)
		table.insert(text1, settingsTemplates.Numbers.Custom)
		table.insert(shade2, settingsTemplates.Numbers.Custom)

		local tweenInf = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

		local currentlyEditingCmd = nil

		settingsFrame:WaitForChild("Close").MouseButton1Click:Connect(function()
			settingsFrame:TweenPosition(
				UDim2.new(0, -150, 0, 0),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Quart,
				0.25,
				true
			)
		end)

		local function resizeList()
			local size = 0

			for i, v in pairs(eventListHolder:GetChildren()) do
				if v.Name == "EventTemplate" then
					size = size + 20
					if v.Expand.Rotation == 90 then
						size = size + 20 * (1 + (#events[v.EventName:GetAttribute("RawName")].commands or 0))
					end
				end
			end

			TweenService:Create(eventList, tweenInf, { CanvasSize = UDim2.new(0, 0, 0, size) }):Play()

			if size > eventList.AbsoluteSize.Y then
				eventListHolder.Size = UDim2.new(1, -8, 1, 0)
			else
				eventListHolder.Size = UDim2.new(1, 0, 1, 0)
			end
		end

		local function resizeSettingsList()
			local size = 0

			for i, v in pairs(settingsList:GetChildren()) do
				if v:IsA("Frame") then
					size = size + v.AbsoluteSize.Y
				end
			end

			settingsList.Parent.CanvasSize = UDim2.new(0, 0, 0, size)

			if size > settingsList.Parent.AbsoluteSize.Y then
				settingsList.Size = UDim2.new(1, -8, 1, 0)
			else
				settingsList.Size = UDim2.new(1, 0, 1, 0)
			end
		end

		local function setupCheckbox(button, callback)
			local enabled = button.On.BackgroundTransparency == 0

			local function update()
				button.On.BackgroundTransparency = (enabled and 0 or 1)
			end

			button.On.MouseButton1Click:Connect(function()
				enabled = not enabled
				update()
				if callback then
					callback(enabled)
				end
			end)

			return {
				Toggle = function(nocall)
					enabled = not enabled
					update()
					if not nocall and callback then
						callback(enabled)
					end
				end,
				Enable = function(nocall)
					if enabled then
						return
					end
					enabled = true
					update()
					if not nocall and callback then
						callback(enabled)
					end
				end,
				Disable = function(nocall)
					if not enabled then
						return
					end
					enabled = false
					update()
					if not nocall and callback then
						callback(enabled)
					end
				end,
				IsEnabled = function()
					return enabled
				end,
			}
		end

		local function openSettingsEditor(event, cmd)
			currentlyEditingCmd = cmd

			for i, v in pairs(settingsList:GetChildren()) do
				if v:IsA("Frame") then
					v:Destroy()
				end
			end

			local delayEditor = settingsTemplates.DelayEditor:Clone()
			delayEditor.Secs.FocusLost:Connect(function()
				cmd[3] = tonumber(delayEditor.Secs.Text) or 0
				delayEditor.Secs.Text = cmd[3]
				if onEdited then
					onEdited()
				end
			end)
			delayEditor.Secs.Text = cmd[3]
			delayEditor.Visible = true
			table.insert(shade2, delayEditor.Secs)
			table.insert(text1, delayEditor.Secs)
			table.insert(text1, delayEditor.Secs.Label)
			delayEditor.Parent = settingsList

			for i, v in pairs(event.sets) do
				if v.Type == "Player" then
					local template = settingsTemplates.Players:Clone()
					template.Title.Text = v.Name or "Player"

					local me, any, custom

					me = setupCheckbox(template.Me.Button, function(on)
						if not on then
							return
						end
						any.Disable()
						custom.Disable()
						cmd[2][i] = 0
						if onEdited then
							onEdited()
						end
					end)

					any = setupCheckbox(template.Any.Button, function(on)
						if not on then
							return
						end
						me.Disable()
						custom.Disable()
						cmd[2][i] = 1
						if onEdited then
							onEdited()
						end
					end)

					local customTextBox = template.Custom
					custom = setupCheckbox(template.CustomButton, function(on)
						if not on then
							return
						end
						me.Disable()
						any.Disable()
						cmd[2][i] = customTextBox.Text
						if onEdited then
							onEdited()
						end
					end)

					ViewportTextBox.convert(customTextBox)
					customTextBox.FocusLost:Connect(function()
						if custom:IsEnabled() then
							cmd[2][i] = customTextBox.Text
							if onEdited then
								onEdited()
							end
						end
					end)

					local cVal = cmd[2][i]
					if cVal == 0 then
						me:Enable()
					elseif cVal == 1 then
						any:Enable()
					else
						custom:Enable()
						customTextBox.Text = cVal
					end

					template.Visible = true
					table.insert(text1, template.Title)
					table.insert(shade3, template.CustomButton)
					table.insert(shade3, template.Any.Button)
					table.insert(shade3, template.Me.Button)
					table.insert(text1, template.Any)
					table.insert(text1, template.Me)
					template.Parent = settingsList
				elseif v.Type == "String" then
					local template = settingsTemplates.Strings:Clone()
					template.Title.Text = v.Name or "String"

					local any, custom

					any = setupCheckbox(template.Any.Button, function(on)
						if not on then
							return
						end
						custom.Disable()
						cmd[2][i] = 0
						if onEdited then
							onEdited()
						end
					end)

					local customTextBox = template.Custom
					custom = setupCheckbox(template.CustomButton, function(on)
						if not on then
							return
						end
						any.Disable()
						cmd[2][i] = customTextBox.Text
						if onEdited then
							onEdited()
						end
					end)

					ViewportTextBox.convert(customTextBox)
					customTextBox.FocusLost:Connect(function()
						if custom:IsEnabled() then
							cmd[2][i] = customTextBox.Text
							if onEdited then
								onEdited()
							end
						end
					end)

					local cVal = cmd[2][i]
					if cVal == 0 then
						any:Enable()
					else
						custom:Enable()
						customTextBox.Text = cVal
					end

					template.Visible = true
					table.insert(text1, template.Title)
					table.insert(text1, template.Any)
					table.insert(shade3, template.Any.Button)
					table.insert(shade3, template.CustomButton)
					template.Parent = settingsList
				elseif v.Type == "Number" then
					local template = settingsTemplates.Numbers:Clone()
					template.Title.Text = v.Name or "Number"

					local any, custom

					any = setupCheckbox(template.Any.Button, function(on)
						if not on then
							return
						end
						custom.Disable()
						cmd[2][i] = 0
						if onEdited then
							onEdited()
						end
					end)

					local customTextBox = template.Custom
					custom = setupCheckbox(template.CustomButton, function(on)
						if not on then
							return
						end
						any.Disable()
						cmd[2][i] = customTextBox.Text
						if onEdited then
							onEdited()
						end
					end)

					ViewportTextBox.convert(customTextBox)
					customTextBox.FocusLost:Connect(function()
						cmd[2][i] = tonumber(customTextBox.Text) or 0
						customTextBox.Text = cmd[2][i]
						if custom:IsEnabled() then
							if onEdited then
								onEdited()
							end
						end
					end)

					local cVal = cmd[2][i]
					if cVal == 0 then
						any:Enable()
					else
						custom:Enable()
						customTextBox.Text = cVal
					end

					template.Visible = true
					table.insert(text1, template.Title)
					table.insert(text1, template.Any)
					table.insert(shade3, template.Any.Button)
					table.insert(shade3, template.CustomButton)
					template.Parent = settingsList
				end
			end
			resizeSettingsList()
			settingsFrame:TweenPosition(
				UDim2.new(0, 0, 0, 0),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Quart,
				0.25,
				true
			)
		end

		local function defaultSettings(ev)
			local res = {}

			for i, v in pairs(ev.sets) do
				if v.Type == "Player" or v.Type == "String" or v.Type == "Number" then
					res[#res + 1] = v.Default or 0
				end
			end

			return res
		end

		local function refreshList()
			for i, v in pairs(eventListHolder:GetChildren()) do
				if v:IsA("Frame") then
					v:Destroy()
				end
			end

			for name, event in pairs(events) do
				local eventF = eventTemplate:Clone()
				eventF.EventName.Text = name
				eventF.Visible = true
				eventF.EventName:SetAttribute("RawName", name)
				table.insert(shade2, eventF)
				table.insert(text1, eventF.EventName)
				table.insert(shade1, eventF.Cmds.Add)

				local expanded = false
				eventF.Expand.MouseButton1Down:Connect(function()
					expanded = not expanded
					eventF:TweenSize(
						UDim2.new(1, 0, 0, 20 + (expanded and 20 * #eventF.Cmds.Holder:GetChildren() or 0)),
						Enum.EasingDirection.Out,
						Enum.EasingStyle.Quart,
						0.25,
						true
					)
					eventF.Expand.Rotation = expanded and 90 or 0
					resizeList()
				end)

				local function refreshCommands()
					for i, v in pairs(eventF.Cmds.Holder:GetChildren()) do
						if v.Name == "CmdTemplate" then
							v:Destroy()
						end
					end

					eventF.EventName.Text = name .. (#event.commands > 0 and " (" .. #event.commands .. ")" or "")

					for i, cmd in pairs(event.commands) do
						local cmdF = cmdTemplate:Clone()
						local cmdTextBox = cmdF.TextBox
						ViewportTextBox.convert(cmdTextBox)
						cmdTextBox.Text = cmd[1]
						cmdF.Visible = true
						table.insert(shade1, cmdF)
						table.insert(shade2, cmdF.Delete)
						table.insert(shade2, cmdF.Settings)

						cmdTextBox.FocusLost:Connect(function()
							event.commands[i] = { cmdTextBox.Text, cmd[2], cmd[3] }
							if onEdited then
								onEdited()
							end
						end)

						cmdF.Settings.MouseButton1Click:Connect(function()
							openSettingsEditor(event, cmd)
						end)

						cmdF.Delete.MouseButton1Click:Connect(function()
							table.remove(event.commands, i)
							refreshCommands()
							resizeList()

							if currentlyEditingCmd == cmd then
								settingsFrame:TweenPosition(
									UDim2.new(0, -150, 0, 0),
									Enum.EasingDirection.Out,
									Enum.EasingStyle.Quart,
									0.25,
									true
								)
							end
							if onEdited then
								onEdited()
							end
						end)

						cmdF.Parent = eventF.Cmds.Holder
					end

					eventF:TweenSize(
						UDim2.new(1, 0, 0, 20 + (expanded and 20 * #eventF.Cmds.Holder:GetChildren() or 0)),
						Enum.EasingDirection.Out,
						Enum.EasingStyle.Quart,
						0.25,
						true
					)
				end

				local newBox = eventF.Cmds.Add.TextBox
				ViewportTextBox.convert(newBox)
				newBox.FocusLost:Connect(function(enter)
					if enter then
						event.commands[#event.commands + 1] = { newBox.Text, defaultSettings(event), 0 }
						newBox.Text = ""

						refreshCommands()
						resizeList()
						if onEdited then
							onEdited()
						end
					end
				end)

				--eventF:GetPropertyChangedSignal("AbsoluteSize"):Connect(resizeList)

				eventF.Parent = eventListHolder

				refreshCommands()
			end

			resizeList()
		end

		local function saveData()
			local result = {}
			for i, v in pairs(events) do
				result[i] = v.commands
			end
			return HttpService:JSONEncode(result)
		end

		local function loadData(str)
			local data = HttpService:JSONDecode(str)
			for i, v in pairs(data) do
				if events[i] then
					events[i].commands = v
				end
			end
		end

		local function addCmd(event, data)
			table.insert(events[event].commands, data)
		end

		local function setOnEdited(f)
			if type(f) == "function" then
				onEdited = f
			end
		end

		main.TopBar.Close.MouseButton1Click:Connect(function()
			main:TweenPosition(UDim2.new(0.5, -175, 0, -500), "InOut", "Quart", 0.5, true, nil)
		end)
		dragGUI(main)
		main.Parent = ScaledHolder

		return {
			RegisterEvent = registerEvent,
			FireEvent = fireEvent,
			Refresh = refreshList,
			SaveData = saveData,
			LoadData = loadData,
			AddCmd = addCmd,
			Frame = main,
			SetOnEdited = setOnEdited,
		}
	end)()

	reference = (function()
		local main = create({
			{
				1,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945),
					BorderSizePixel = 0,
					Name = "Main",
					Position = UDim2.new(0.5, -250, 0, -500),
					Size = UDim2.new(0, 500, 0, 20),
					ZIndex = 10,
				},
			},
			{
				2,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BorderSizePixel = 0,
					Name = "TopBar",
					Parent = { 1 },
					Size = UDim2.new(1, 0, 0, 20),
					ZIndex = 10,
				},
			},
			{
				3,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Title",
					Parent = { 2 },
					Size = UDim2.new(1, 0, 0.94999998807907, 0),
					Text = "Reference",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					ZIndex = 10,
				},
			},
			{
				4,
				"TextButton",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Close",
					Parent = { 2 },
					Position = UDim2.new(1, -20, 0, 0),
					Size = UDim2.new(0, 20, 0, 20),
					Text = "",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					ZIndex = 10,
				},
			},
			{
				5,
				"ImageLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Image = getcustomasset("zeroyield/assets/close.png"),
					Parent = { 4 },
					Position = UDim2.new(0, 5, 0, 5),
					Size = UDim2.new(0, 10, 0, 10),
					ZIndex = 10,
				},
			},
			{
				6,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833),
					BorderSizePixel = 0,
					Name = "Content",
					Parent = { 1 },
					Position = UDim2.new(0, 0, 0, 20),
					Size = UDim2.new(1, 0, 0, 300),
					ZIndex = 10,
				},
			},
			{
				7,
				"ScrollingFrame",
				{
					BackgroundColor3 = Color3.new(0.14117647707462, 0.14117647707462, 0.14509804546833),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945),
					BorderSizePixel = 0,
					BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					CanvasSize = UDim2.new(0, 0, 0, 1313),
					Name = "List",
					Parent = { 6 },
					ScrollBarImageColor3 = Color3.new(0.30588236451149, 0.30588236451149, 0.3098039329052),
					ScrollBarThickness = 8,
					Size = UDim2.new(1, 0, 1, 0),
					TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					VerticalScrollBarInset = 2,
					ZIndex = 10,
				},
			},
			{ 8, "UIListLayout", { Parent = { 7 }, SortOrder = 2 } },
			{
				9,
				"Frame",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Name = "Section",
					Parent = { 7 },
					Size = UDim2.new(1, 0, 0, 429),
					ZIndex = 10,
				},
			},
			{
				10,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Header",
					Parent = { 9 },
					Position = UDim2.new(0, 8, 0, 5),
					Size = UDim2.new(1, -8, 0, 20),
					Text = "Special Player Cases",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 20,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				11,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Text",
					Parent = { 9 },
					Position = UDim2.new(0, 8, 0, 25),
					Size = UDim2.new(1, -8, 0, 20),
					Text = "These keywords can be used to quickly select groups of players in commands:",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				12,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BorderSizePixel = 0,
					Name = "Line",
					Parent = { 9 },
					Position = UDim2.new(0, 10, 1, -1),
					Size = UDim2.new(1, -20, 0, 1),
					ZIndex = 10,
				},
			},
			{
				13,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Cases",
					Parent = { 9 },
					Position = UDim2.new(0, 8, 0, 55),
					Size = UDim2.new(1, -16, 0, 342),
					ZIndex = 10,
				},
			},
			{ 14, "UIListLayout", { Parent = { 13 }, SortOrder = 2 } },
			{
				15,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = -4,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				16,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 15 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "all",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				17,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 15 },
					Position = UDim2.new(0, 15, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- includes everyone",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				18,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = -3,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				19,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 18 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "others",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				20,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 18 },
					Position = UDim2.new(0, 37, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- includes everyone except you",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				21,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = -2,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				22,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 21 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "me",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				23,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 21 },
					Position = UDim2.new(0, 19, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- includes your player only",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				24,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				25,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 24 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "#[number]",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				26,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 24 },
					Position = UDim2.new(0, 59, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- gets a specified amount of random players",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				27,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				28,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 27 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "random",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				29,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 27 },
					Position = UDim2.new(0, 44, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- affects a random player",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				30,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				31,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 30 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "%[team name]",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				32,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 30 },
					Position = UDim2.new(0, 78, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- includes everyone on a given team",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				33,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				34,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 33 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "allies / team",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				35,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 33 },
					Position = UDim2.new(0, 63, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- players who are on your team",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				36,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				37,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 36 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "enemies / nonteam",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				38,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 36 },
					Position = UDim2.new(0, 101, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- players who are not on your team",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				39,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				40,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 39 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "friends",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				41,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 39 },
					Position = UDim2.new(0, 40, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- anyone who is friends with you",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				42,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				43,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 42 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "nonfriends",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				44,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 42 },
					Position = UDim2.new(0, 61, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- anyone who is not friends with you",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				45,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				46,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 45 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "guests",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				47,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 45 },
					Position = UDim2.new(0, 36, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- guest players (obsolete)",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				48,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				49,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 48 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "bacons",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				50,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 48 },
					Position = UDim2.new(0, 40, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = '- anyone with the "bacon" or pal hair',
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				51,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				52,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 51 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "age[number]",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				53,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 51 },
					Position = UDim2.new(0, 71, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- includes anyone below or at the given age",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				54,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				55,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 54 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "rad[number]",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				56,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 54 },
					Position = UDim2.new(0, 70, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- includes anyone within the given radius",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				57,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				58,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 57 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "nearest",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				59,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 57 },
					Position = UDim2.new(0, 43, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- gets the closest player to you",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				60,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				61,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 60 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "farthest",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				62,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 60 },
					Position = UDim2.new(0, 46, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- gets the farthest player from you",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				63,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				64,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 63 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "group[ID]",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				65,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 63 },
					Position = UDim2.new(0, 55, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- gets players who are in a certain group",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				66,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				67,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 66 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "alive",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				68,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 66 },
					Position = UDim2.new(0, 27, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- gets players who are alive",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				69,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				70,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 69 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "dead",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				71,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 69 },
					Position = UDim2.new(0, 29, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- gets players who are dead",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				72,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = -1,
					Name = "Case",
					Parent = { 13 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, 0, 0, 18),
					ZIndex = 10,
				},
			},
			{
				73,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "CaseName",
					Parent = { 72 },
					Size = UDim2.new(1, 0, 1, 0),
					Text = "@username",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				74,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "CaseDesc",
					Parent = { 72 },
					Position = UDim2.new(0, 66, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Text = "- searches for players by username only (ignores displaynames)",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				75,
				"Frame",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Name = "Section",
					Parent = { 7 },
					Size = UDim2.new(1, 0, 0, 180),
					ZIndex = 10,
				},
			},
			{
				76,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Header",
					Parent = { 75 },
					Position = UDim2.new(0, 8, 0, 5),
					Size = UDim2.new(1, -8, 0, 20),
					Text = "Various Operators",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 20,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				77,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BorderSizePixel = 0,
					Name = "Line",
					Parent = { 75 },
					Position = UDim2.new(0, 10, 1, -1),
					Size = UDim2.new(1, -20, 0, 1),
					ZIndex = 10,
				},
			},
			{
				78,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Text",
					Parent = { 75 },
					Position = UDim2.new(0, 8, 0, 30),
					Size = UDim2.new(1, -8, 0, 16),
					Text = "Use commas to separate multiple expressions:",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					TextYAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				79,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Text",
					Parent = { 75 },
					Position = UDim2.new(0, 8, 0, 75),
					Size = UDim2.new(1, -8, 0, 16),
					Text = "Use - to exclude, and + to include players in your expression:",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					TextYAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				80,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Text",
					Parent = { 75 },
					Position = UDim2.new(0, 8, 0, 91),
					Size = UDim2.new(1, -8, 0, 16),
					Text = ";locate %blue-friends (gets players in blue team who aren't your friends)",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					TextYAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				81,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Text",
					Parent = { 75 },
					Position = UDim2.new(0, 8, 0, 46),
					Size = UDim2.new(1, -8, 0, 16),
					Text = ";locate noob,noob2,bob",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					TextYAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				82,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Text",
					Parent = { 75 },
					Position = UDim2.new(0, 8, 0, 120),
					Size = UDim2.new(1, -8, 0, 16),
					Text = "Put ! before a command to run it with the last arguments it was ran with:",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					TextYAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				83,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Text",
					Parent = { 75 },
					Position = UDim2.new(0, 8, 0, 136),
					Size = UDim2.new(1, -8, 0, 32),
					Text = "After running ;offset 0 100 0,  you can run !offset anytime to repeat that command with the same arguments that were used to run it last time",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					TextYAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				84,
				"Frame",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Name = "Section",
					Parent = { 7 },
					Size = UDim2.new(1, 0, 0, 154),
					ZIndex = 10,
				},
			},
			{
				85,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Header",
					Parent = { 84 },
					Position = UDim2.new(0, 8, 0, 5),
					Size = UDim2.new(1, -8, 0, 20),
					Text = "Command Looping",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 20,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				86,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Text",
					Parent = { 84 },
					Position = UDim2.new(0, 8, 0, 30),
					Size = UDim2.new(1, -8, 0, 20),
					Text = "Form: [How many times it loops]^[delay (optional)]^[command]",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 15,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				87,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BorderSizePixel = 0,
					Name = "Line",
					Parent = { 84 },
					Position = UDim2.new(0, 10, 1, -1),
					Size = UDim2.new(1, -20, 0, 1),
					ZIndex = 10,
				},
			},
			{
				88,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Text",
					Parent = { 84 },
					Position = UDim2.new(0, 8, 0, 50),
					Size = UDim2.new(1, -8, 0, 20),
					Text = "Use the 'breakloops' command to stop all running loops.",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 15,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				89,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Text",
					Parent = { 84 },
					Position = UDim2.new(0, 8, 0, 80),
					Size = UDim2.new(1, -8, 0, 16),
					Text = "Examples:",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					TextYAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				90,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Text",
					Parent = { 84 },
					Position = UDim2.new(0, 8, 0, 98),
					Size = UDim2.new(1, -8, 0, 42),
					Text = ";5^btools - gives you 5 sets of btools\n;10^3^drophats - drops your hats every 3 seconds 10 times\n;inf^0.1^animspeed 100 - infinitely loops your animation speed to 100",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					TextYAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				91,
				"Frame",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Name = "Section",
					Parent = { 7 },
					Size = UDim2.new(1, 0, 0, 120),
					ZIndex = 10,
				},
			},
			{
				92,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Header",
					Parent = { 91 },
					Position = UDim2.new(0, 8, 0, 5),
					Size = UDim2.new(1, -8, 0, 20),
					Text = "Execute Multiple Commands at Once",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 20,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				93,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Text",
					Parent = { 91 },
					Position = UDim2.new(0, 8, 0, 30),
					Size = UDim2.new(1, -8, 0, 20),
					Text = 'You can execute multiple commands at once using "\\"',
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				94,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BorderSizePixel = 0,
					Name = "Line",
					Parent = { 91 },
					Position = UDim2.new(0, 10, 1, -1),
					Size = UDim2.new(1, -20, 0, 1),
					ZIndex = 10,
				},
			},
			{
				95,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Text",
					Parent = { 91 },
					Position = UDim2.new(0, 8, 0, 60),
					Size = UDim2.new(1, -8, 0, 16),
					Text = "Examples:",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					TextYAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				96,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Text",
					Parent = { 91 },
					Position = UDim2.new(0, 8, 0, 78),
					Size = UDim2.new(1, -8, 0, 32),
					Text = ";drophats\\respawn - drops your hats and respawns you\n;enable inventory\\enable playerlist\\refresh - enables those coregui items and refreshes you",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					TextYAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				97,
				"Frame",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Name = "Section",
					Parent = { 7 },
					Size = UDim2.new(1, 0, 0, 75),
					ZIndex = 10,
				},
			},
			{
				98,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Header",
					Parent = { 97 },
					Position = UDim2.new(0, 8, 0, 5),
					Size = UDim2.new(1, -8, 0, 20),
					Text = "Browse Command History",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 20,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				99,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Text",
					Parent = { 97 },
					Position = UDim2.new(0, 8, 0, 30),
					Size = UDim2.new(1, -8, 0, 32),
					Text = "While focused on the command bar, you can use the up and down arrow keys to browse recently used commands",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				100,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BorderSizePixel = 0,
					Name = "Line",
					Parent = { 97 },
					Position = UDim2.new(0, 10, 1, -1),
					Size = UDim2.new(1, -20, 0, 1),
					ZIndex = 10,
				},
			},
			{
				101,
				"Frame",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Name = "Section",
					Parent = { 7 },
					Size = UDim2.new(1, 0, 0, 75),
					ZIndex = 10,
				},
			},
			{
				102,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Header",
					Parent = { 101 },
					Position = UDim2.new(0, 8, 0, 5),
					Size = UDim2.new(1, -8, 0, 20),
					Text = "Autocomplete in the Command Bar",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 20,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				103,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Text",
					Parent = { 101 },
					Position = UDim2.new(0, 8, 0, 30),
					Size = UDim2.new(1, -8, 0, 32),
					Text = "While focused on the command bar, you can use the tab key to insert the top suggested command into the command bar.",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				104,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BorderSizePixel = 0,
					Name = "Line",
					Parent = { 101 },
					Position = UDim2.new(0, 10, 1, -1),
					Size = UDim2.new(1, -20, 0, 1),
					ZIndex = 10,
				},
			},
			{
				105,
				"Frame",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Name = "Section",
					Parent = { 7 },
					Size = UDim2.new(1, 0, 0, 175),
					ZIndex = 10,
				},
			},
			{
				106,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Header",
					Parent = { 105 },
					Position = UDim2.new(0, 8, 0, 5),
					Size = UDim2.new(1, -8, 0, 20),
					Text = "Using Event Binds",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 20,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				107,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Text",
					Parent = { 105 },
					Position = UDim2.new(0, 8, 0, 30),
					Size = UDim2.new(1, -8, 0, 32),
					Text = "Use event binds to set up commands that get executed when certain events happen. You can edit the conditions for an event command to run (such as which player triggers it).",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				108,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BorderSizePixel = 0,
					Name = "Line",
					Parent = { 105 },
					Position = UDim2.new(0, 10, 1, -1),
					Size = UDim2.new(1, -20, 0, 1),
					ZIndex = 10,
				},
			},
			{
				109,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Text",
					Parent = { 105 },
					Position = UDim2.new(0, 8, 0, 70),
					Size = UDim2.new(1, -8, 0, 48),
					Text = "Some events may send arguments; you can use them in your event command by using $ followed by the argument number ($1, $2, etc). You can find out the order and types of these arguments by looking at the settings of the event command.",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				110,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Text",
					Parent = { 105 },
					Position = UDim2.new(0, 8, 0, 130),
					Size = UDim2.new(1, -8, 0, 16),
					Text = "Example:",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					TextYAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				111,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Text",
					Parent = { 105 },
					Position = UDim2.new(0, 8, 0, 148),
					Size = UDim2.new(1, -8, 0, 16),
					Text = "Setting up 'goto $1' on the OnChatted event will teleport you to any player that chats.",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					TextYAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				112,
				"Frame",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Name = "Section",
					Parent = { 7 },
					Size = UDim2.new(1, 0, 0, 105),
					ZIndex = 10,
				},
			},
			{
				113,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 4,
					Name = "Header",
					Parent = { 112 },
					Position = UDim2.new(0, 8, 0, 5),
					Size = UDim2.new(1, -8, 0, 20),
					Text = "Get Further Help",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 20,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				114,
				"TextLabel",
				{
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					Font = 3,
					Name = "Text",
					Parent = { 112 },
					Position = UDim2.new(0, 8, 0, 30),
					Size = UDim2.new(1, -8, 0, 32),
					Text = "You can join the Discord server to get support with Zero Yield, and read up on more documentation such as the Plugin API.",
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = 0,
					ZIndex = 10,
				},
			},
			{
				115,
				"Frame",
				{
					BackgroundColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					BorderSizePixel = 0,
					Name = "Line",
					Parent = { 112 },
					Position = UDim2.new(0, 10, 1, -1),
					Size = UDim2.new(1, -20, 0, 1),
					Visible = false,
					ZIndex = 10,
				},
			},
			{
				116,
				"TextButton",
				{
					BackgroundColor3 = Color3.new(0.48627451062202, 0.61960786581039, 0.85098040103912),
					BorderColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					Font = 4,
					Name = "InviteButton",
					Parent = { 112 },
					Position = UDim2.new(0, 5, 0, 75),
					Size = UDim2.new(1, -10, 0, 25),
					Text = "Copy Discord Invite Link (https://discord.gg/sc5tfyEUqD)",
					TextColor3 = Color3.new(0.1803921610117, 0.1803921610117, 0.1843137294054),
					TextSize = 16,
					ZIndex = 10,
				},
			},
		})
		for i, v in pairs(main.Content.List:GetDescendants()) do
			if v:IsA("TextLabel") then
				table.insert(text1, v)
			end
		end
		table.insert(scroll, main.Content.List)
		table.insert(shade1, main.Content)
		table.insert(shade2, main.TopBar)
		main.Name = randomString()
		main.TopBar.Close.MouseButton1Click:Connect(function()
			main:TweenPosition(UDim2.new(0.5, -250, 0, -500), "InOut", "Quart", 0.5, true, nil)
		end)
		local inviteButton = main:FindFirstChild("InviteButton", true)
		local lastPress = nil
		inviteButton.MouseButton1Click:Connect(function()
			if everyClipboard then
				toClipboard("https://discord.gg/sc5tfyEUqD")
				inviteButton.Text = "Copied"
			else
				inviteButton.Text = "No Clipboard Function, type out the link"
			end
			local pressTime = os.clock()
			lastPress = pressTime
			task.wait(2)
			if lastPress ~= pressTime then
				return
			end
			inviteButton.Text = "Copy Discord Invite Link (https://discord.gg/sc5tfyEUqD)"
		end)
		dragGUI(main)
		main.Parent = ScaledHolder

		ReferenceButton.MouseButton1Click:Connect(function()
			main:TweenPosition(UDim2.new(0.5, -250, 0.5, -150), "InOut", "Quart", 0.5, true, nil)
		end)
	end)()

	currentShade1 = Color3.fromRGB(36, 36, 37)
	currentShade2 = Color3.fromRGB(46, 46, 47)
	currentShade3 = Color3.fromRGB(78, 78, 79)
	currentText1 = Color3.new(1, 1, 1)
	currentText2 = Color3.new(0, 0, 0)
	currentScroll = Color3.fromRGB(78, 78, 79)

	defaultGuiScale = IsOnMobile and 0.9 or 1
	defaultsettings = {
		prefix = ";",
		StayOpen = false,
		guiScale = defaultGuiScale,
		espTransparency = 0.3,
		keepZY = true,
		logsEnabled = false,
		jLogsEnabled = false,
		aliases = {},
		binds = {},
		WayPoints = {},
		PluginsTable = {},
		currentShade1 = { currentShade1.R, currentShade1.G, currentShade1.B },
		currentShade2 = { currentShade2.R, currentShade2.G, currentShade2.B },
		currentShade3 = { currentShade3.R, currentShade3.G, currentShade3.B },
		currentText1 = { currentText1.R, currentText1.G, currentText1.B },
		currentText2 = { currentText2.R, currentText2.G, currentText2.B },
		currentScroll = { currentScroll.R, currentScroll.G, currentScroll.B },
		eventBinds = eventEditor.SaveData(),
	}

	defaults = HttpService:JSONEncode(defaultsettings)
	nosaves = false
	useFactorySettings = function()
		prefix = ";"
		StayOpen = false
		guiScale = defaultGuiScale
		KeepInfYield = true
		espTransparency = 0.3
		logsEnabled = false
		jLogsEnabled = false
		logsWebhook = nil
		aliases = {}
		binds = {}
		WayPoints = {}
		PluginsTable = {}
	end

	return env
end
