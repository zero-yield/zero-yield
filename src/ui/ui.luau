return function(env)
	ScaledHolder = Instance.new("Frame")
	Scale = Instance.new("UIScale")
	Holder = Instance.new("Frame")
	Title = Instance.new("TextLabel")
	Dark = Instance.new("Frame")
	Cmdbar = Instance.new("TextBox")
	CMDsF = Instance.new("ScrollingFrame")
	cmdListLayout = Instance.new("UIListLayout")
	SettingsButton = Instance.new("ImageButton")
	ColorsButton = Instance.new("ImageButton")
	Settings = Instance.new("Frame")
	Prefix = Instance.new("TextLabel")
	PrefixBox = Instance.new("TextBox")
	Keybinds = Instance.new("TextLabel")
	StayOpen = Instance.new("TextLabel")
	Button = Instance.new("Frame")
	On = Instance.new("TextButton")
	Positions = Instance.new("TextLabel")
	EventBind = Instance.new("TextLabel")
	Plugins = Instance.new("TextLabel")
	Example = Instance.new("TextButton")
	Notification = Instance.new("Frame")
	Title_2 = Instance.new("TextLabel")
	Text_2 = Instance.new("TextLabel")
	CloseButton = Instance.new("TextButton")
	CloseImage = Instance.new("ImageLabel")
	PinButton = Instance.new("TextButton")
	PinImage = Instance.new("ImageLabel")
	Tooltip = Instance.new("Frame")
	Title_3 = Instance.new("TextLabel")
	Description = Instance.new("TextLabel")
	IntroBackground = Instance.new("Frame")
	Logo = Instance.new("ImageLabel")
	Credits = Instance.new("TextBox")
	KeybindsFrame = Instance.new("Frame")
	Close = Instance.new("TextButton")
	Add = Instance.new("TextButton")
	Delete = Instance.new("TextButton")
	Holder_2 = Instance.new("ScrollingFrame")
	Example_2 = Instance.new("Frame")
	Text_3 = Instance.new("TextLabel")
	Delete_2 = Instance.new("TextButton")
	KeybindEditor = Instance.new("Frame")
	background_2 = Instance.new("Frame")
	Dark_3 = Instance.new("Frame")
	Directions = Instance.new("TextLabel")
	BindTo = Instance.new("TextButton")
	TriggerLabel = Instance.new("TextLabel")
	BindTriggerSelect = Instance.new("TextButton")
	Add_2 = Instance.new("TextButton")
	Toggles = Instance.new("ScrollingFrame")
	ClickTP = Instance.new("TextLabel")
	Select = Instance.new("TextButton")
	ClickDelete = Instance.new("TextLabel")
	Select_2 = Instance.new("TextButton")
	Cmdbar_2 = Instance.new("TextBox")
	Cmdbar_3 = Instance.new("TextBox")
	CreateToggle = Instance.new("TextLabel")
	Button_2 = Instance.new("Frame")
	On_2 = Instance.new("TextButton")
	shadow_2 = Instance.new("Frame")
	PopupText_2 = Instance.new("TextLabel")
	Exit_2 = Instance.new("TextButton")
	ExitImage_2 = Instance.new("ImageLabel")
	PositionsFrame = Instance.new("Frame")
	Close_3 = Instance.new("TextButton")
	Delete_5 = Instance.new("TextButton")
	Part = Instance.new("TextButton")
	Holder_4 = Instance.new("ScrollingFrame")
	Example_4 = Instance.new("Frame")
	Text_5 = Instance.new("TextLabel")
	Delete_6 = Instance.new("TextButton")
	TP = Instance.new("TextButton")
	AliasesFrame = Instance.new("Frame")
	Close_2 = Instance.new("TextButton")
	Delete_3 = Instance.new("TextButton")
	Holder_3 = Instance.new("ScrollingFrame")
	Example_3 = Instance.new("Frame")
	Text_4 = Instance.new("TextLabel")
	Delete_4 = Instance.new("TextButton")
	Aliases = Instance.new("TextLabel")
	PluginsFrame = Instance.new("Frame")
	Close_4 = Instance.new("TextButton")
	Add_3 = Instance.new("TextButton")
	Holder_5 = Instance.new("ScrollingFrame")
	Example_5 = Instance.new("Frame")
	Text_6 = Instance.new("TextLabel")
	Delete_7 = Instance.new("TextButton")
	PluginEditor = Instance.new("Frame")
	background_3 = Instance.new("Frame")
	Dark_2 = Instance.new("Frame")
	Img = Instance.new("ImageButton")
	AddPlugin = Instance.new("TextButton")
	FileName = Instance.new("TextBox")
	About = Instance.new("TextLabel")
	Directions_2 = Instance.new("TextLabel")
	shadow_3 = Instance.new("Frame")
	PopupText_3 = Instance.new("TextLabel")
	Exit_3 = Instance.new("TextButton")
	ExitImage_3 = Instance.new("ImageLabel")
	AliasHint = Instance.new("TextLabel")
	PluginsHint = Instance.new("TextLabel")
	PositionsHint = Instance.new("TextLabel")
	ToPartFrame = Instance.new("Frame")
	background_4 = Instance.new("Frame")
	ChoosePart = Instance.new("TextButton")
	CopyPath = Instance.new("TextButton")
	Directions_3 = Instance.new("TextLabel")
	Path = Instance.new("TextLabel")
	shadow_4 = Instance.new("Frame")
	PopupText_5 = Instance.new("TextLabel")
	Exit_4 = Instance.new("TextButton")
	ExitImage_5 = Instance.new("ImageLabel")
	logs = Instance.new("Frame")
	shadow = Instance.new("Frame")
	Hide = Instance.new("TextButton")
	ImageLabel = Instance.new("ImageLabel")
	PopupText = Instance.new("TextLabel")
	Exit = Instance.new("TextButton")
	ImageLabel_2 = Instance.new("ImageLabel")
	background = Instance.new("Frame")
	chat = Instance.new("Frame")
	Clear = Instance.new("TextButton")
	SaveChatlogs = Instance.new("TextButton")
	Toggle = Instance.new("TextButton")
	scroll_2 = Instance.new("ScrollingFrame")
	join = Instance.new("Frame")
	Toggle_2 = Instance.new("TextButton")
	Clear_2 = Instance.new("TextButton")
	scroll_3 = Instance.new("ScrollingFrame")
	listlayout = Instance.new("UIListLayout")
	listlayout.Parent = scroll_3
	selectChat = Instance.new("TextButton")
	selectJoin = Instance.new("TextButton")

	function randomString()
		local length = math.random(10, 20)
		local array = {}
		for i = 1, length do
			array[i] = string.char(math.random(32, 126))
		end
		return table.concat(array)
	end

	PARENT = nil
	MAX_DISPLAY_ORDER = 1.7976931348623157e308
	if gethui then
		local Main = Instance.new("ScreenGui")
		Main.Name = randomString()
		Main.ResetOnSpawn = false
		Main.DisplayOrder = MAX_DISPLAY_ORDER
		Main.Parent = gethui()
		PARENT = Main
	elseif (not is_sirhurt_closure) and syn_protect_gui then
		local Main = Instance.new("ScreenGui")
		Main.Name = randomString()
		Main.ResetOnSpawn = false
		Main.DisplayOrder = MAX_DISPLAY_ORDER
		syn_protect_gui(Main)
		Main.Parent = COREGUI
		PARENT = Main
	elseif COREGUI:FindFirstChild("RobloxGui") then
		PARENT = COREGUI.RobloxGui
	else
		local Main = Instance.new("ScreenGui")
		Main.Name = randomString()
		Main.ResetOnSpawn = false
		Main.DisplayOrder = MAX_DISPLAY_ORDER
		Main.Parent = COREGUI
		PARENT = Main
	end

	shade1 = {}
	shade2 = {}
	shade3 = {}
	text1 = {}
	text2 = {}
	scroll = {}

	ScaledHolder.Name = randomString()
	ScaledHolder.Size = UDim2.fromScale(1, 1)
	ScaledHolder.BackgroundTransparency = 1
	ScaledHolder.Parent = PARENT
	Scale.Name = randomString()

	Holder.Name = randomString()
	Holder.Parent = ScaledHolder
	Holder.Active = true
	Holder.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Holder.BorderSizePixel = 0
	Holder.Position = UDim2.new(1, -250, 1, -220)
	Holder.Size = UDim2.new(0, 250, 0, 220)
	Holder.ZIndex = 10
	table.insert(shade2, Holder)

	Title.Name = "Title"
	Title.Parent = Holder
	Title.Active = true
	Title.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	Title.BorderSizePixel = 0
	Title.Size = UDim2.new(0, 250, 0, 20)
	Title.Font = Enum.Font.SourceSans
	Title.TextSize = 18
	Title.Text = "Zero Yield FE v" .. currentVersion

	do
		local emoji = ({
			["01 01"] = "🎆",
			["02 14"] = "💝",
			["03 17"] = "☘️",
			[(function(Year)
				local A = math.floor(Year / 100)
				local B = math.floor((13 + 8 * A) / 25)
				local C = (15 - B + A - math.floor(A / 4)) % 30
				local D = (4 + A - math.floor(A / 4)) % 7
				local E = (19 * (Year % 19) + C) % 30
				local F = (2 * (Year % 4) + 4 * (Year % 7) + 6 * E + D) % 7
				local G = (22 + E + F)
				if E == 29 and F == 6 then
					return "04 19"
				elseif E == 28 and F == 6 then
					return "04 18"
				elseif 31 < G then
					return ("04 %02d"):format(G - 31)
				end
				return ("03 %02d"):format(G)
			end)(tonumber(os.date("%Y")))] = "🥚",
			["10 31"] = "🎃",
			["12 25"] = "🎄",
		})[os.date("%m %d")]
		if emoji then
			Title.Text = ("%s %s %s"):format(emoji, Title.Text, emoji)
		end
	end

	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.ZIndex = 10
	table.insert(shade1, Title)
	table.insert(text1, Title)

	Dark.Name = "Dark"
	Dark.Parent = Holder
	Dark.Active = true
	Dark.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	Dark.BorderSizePixel = 0
	Dark.Position = UDim2.new(0, 0, 0, 45)
	Dark.Size = UDim2.new(0, 250, 0, 175)
	Dark.ZIndex = 10
	table.insert(shade1, Dark)

	Cmdbar.Name = "Cmdbar"
	Cmdbar.Parent = Holder
	Cmdbar.BackgroundTransparency = 1
	Cmdbar.BorderSizePixel = 0
	Cmdbar.Position = UDim2.new(0, 5, 0, 20)
	Cmdbar.Size = UDim2.new(0, 240, 0, 25)
	Cmdbar.Font = Enum.Font.SourceSans
	Cmdbar.TextSize = 18
	Cmdbar.TextXAlignment = Enum.TextXAlignment.Left
	Cmdbar.TextColor3 = Color3.new(1, 1, 1)
	Cmdbar.Text = ""
	Cmdbar.ZIndex = 10
	Cmdbar.PlaceholderText = "Command Bar"

	CMDsF.Name = "CMDs"
	CMDsF.Parent = Holder
	CMDsF.BackgroundTransparency = 1
	CMDsF.BorderSizePixel = 0
	CMDsF.Position = UDim2.new(0, 5, 0, 45)
	CMDsF.Size = UDim2.new(0, 245, 0, 175)
	CMDsF.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)
	CMDsF.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	CMDsF.CanvasSize = UDim2.new(0, 0, 0, 0)
	CMDsF.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	CMDsF.ScrollBarThickness = 8
	CMDsF.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	CMDsF.VerticalScrollBarInset = "Always"
	CMDsF.ZIndex = 10
	table.insert(scroll, CMDsF)

	cmdListLayout.Parent = CMDsF

	SettingsButton.Name = "SettingsButton"
	SettingsButton.Parent = Holder
	SettingsButton.BackgroundTransparency = 1
	SettingsButton.Position = UDim2.new(0, 230, 0, 0)
	SettingsButton.Size = UDim2.new(0, 20, 0, 20)
	SettingsButton.Image = getcustomasset("zeroyield/assets/settings.png")
	SettingsButton.ZIndex = 10

	ReferenceButton = Instance.new("ImageButton")
	ReferenceButton.Name = "ReferenceButton"
	ReferenceButton.Parent = Holder
	ReferenceButton.BackgroundTransparency = 1
	ReferenceButton.Position = UDim2.new(0, 212, 0, 2)
	ReferenceButton.Size = UDim2.new(0, 16, 0, 16)
	ReferenceButton.Image = getcustomasset("zeroyield/assets/reference.png")
	ReferenceButton.ZIndex = 10

	Settings.Name = "Settings"
	Settings.Parent = Holder
	Settings.Active = true
	Settings.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	Settings.BorderSizePixel = 0
	Settings.Position = UDim2.new(0, 0, 0, 220)
	Settings.Size = UDim2.new(0, 250, 0, 175)
	Settings.ZIndex = 10
	table.insert(shade1, Settings)

	SettingsHolder = Instance.new("ScrollingFrame")
	SettingsHolder.Name = "Holder"
	SettingsHolder.Parent = Settings
	SettingsHolder.BackgroundTransparency = 1
	SettingsHolder.BorderSizePixel = 0
	SettingsHolder.Size = UDim2.new(1, 0, 1, 0)
	SettingsHolder.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)
	SettingsHolder.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	SettingsHolder.CanvasSize = UDim2.new(0, 0, 0, 235)
	SettingsHolder.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	SettingsHolder.ScrollBarThickness = 8
	SettingsHolder.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	SettingsHolder.VerticalScrollBarInset = "Always"
	SettingsHolder.ZIndex = 10
	table.insert(scroll, SettingsHolder)

	Prefix.Name = "Prefix"
	Prefix.Parent = SettingsHolder
	Prefix.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Prefix.BorderSizePixel = 0
	Prefix.BackgroundTransparency = 1
	Prefix.Position = UDim2.new(0, 5, 0, 5)
	Prefix.Size = UDim2.new(1, -10, 0, 20)
	Prefix.Font = Enum.Font.SourceSans
	Prefix.TextSize = 14
	Prefix.Text = "Prefix"
	Prefix.TextColor3 = Color3.new(1, 1, 1)
	Prefix.TextXAlignment = Enum.TextXAlignment.Left
	Prefix.ZIndex = 10
	table.insert(shade2, Prefix)
	table.insert(text1, Prefix)

	PrefixBox.Name = "PrefixBox"
	PrefixBox.Parent = Prefix
	PrefixBox.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	PrefixBox.BorderSizePixel = 0
	PrefixBox.Position = UDim2.new(1, -20, 0, 0)
	PrefixBox.Size = UDim2.new(0, 20, 0, 20)
	PrefixBox.Font = Enum.Font.SourceSansBold
	PrefixBox.TextSize = 14
	PrefixBox.Text = ""
	PrefixBox.TextColor3 = Color3.new(0, 0, 0)
	PrefixBox.ZIndex = 10
	table.insert(shade3, PrefixBox)
	table.insert(text2, PrefixBox)

	function makeSettingsButton(name, iconID, off)
		local button = Instance.new("TextButton")
		button.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
		button.BorderSizePixel = 0
		button.Position = UDim2.new(0, 0, 0, 0)
		button.Size = UDim2.new(1, 0, 0, 25)
		button.Text = ""
		button.ZIndex = 10
		local icon = Instance.new("ImageLabel")
		icon.Name = "Icon"
		icon.Parent = button
		icon.Position = UDim2.new(0, 5, 0, 5)
		icon.Size = UDim2.new(0, 16, 0, 16)
		icon.BackgroundTransparency = 1
		icon.Image = iconID
		icon.ZIndex = 10
		if off then
			icon.ScaleType = Enum.ScaleType.Crop
			icon.ImageRectSize = Vector2.new(16, 16)
			icon.ImageRectOffset = Vector2.new(off, 0)
		end
		local label = Instance.new("TextLabel")
		label.Name = "ButtonLabel"
		label.Parent = button
		label.BackgroundTransparency = 1
		label.Text = name
		label.Position = UDim2.new(0, 28, 0, 0)
		label.Size = UDim2.new(1, -28, 1, 0)
		label.Font = Enum.Font.SourceSans
		label.TextColor3 = Color3.new(1, 1, 1)
		label.TextSize = 14
		label.ZIndex = 10
		label.TextXAlignment = Enum.TextXAlignment.Left
		table.insert(shade2, button)
		table.insert(text1, label)
		return button
	end

	ColorsButton = makeSettingsButton("Edit Theme", getcustomasset("zeroyield/assets/edittheme.png"))
	ColorsButton.Position = UDim2.new(0, 5, 0, 55)
	ColorsButton.Size = UDim2.new(1, -10, 0, 25)
	ColorsButton.Name = "Colors"
	ColorsButton.Parent = SettingsHolder

	Keybinds = makeSettingsButton("Edit Keybinds", getcustomasset("zeroyield/assets/editkeybinds.png"))
	Keybinds.Position = UDim2.new(0, 5, 0, 85)
	Keybinds.Size = UDim2.new(1, -10, 0, 25)
	Keybinds.Name = "Keybinds"
	Keybinds.Parent = SettingsHolder

	Aliases = makeSettingsButton("Edit Aliases", getcustomasset("zeroyield/assets/editaliases.png"))
	Aliases.Position = UDim2.new(0, 5, 0, 115)
	Aliases.Size = UDim2.new(1, -10, 0, 25)
	Aliases.Name = "Aliases"
	Aliases.Parent = SettingsHolder

	StayOpen.Name = "StayOpen"
	StayOpen.Parent = SettingsHolder
	StayOpen.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	StayOpen.BorderSizePixel = 0
	StayOpen.BackgroundTransparency = 1
	StayOpen.Position = UDim2.new(0, 5, 0, 30)
	StayOpen.Size = UDim2.new(1, -10, 0, 20)
	StayOpen.Font = Enum.Font.SourceSans
	StayOpen.TextSize = 14
	StayOpen.Text = "Keep Menu Open"
	StayOpen.TextColor3 = Color3.new(1, 1, 1)
	StayOpen.TextXAlignment = Enum.TextXAlignment.Left
	StayOpen.ZIndex = 10
	table.insert(shade2, StayOpen)
	table.insert(text1, StayOpen)

	Button.Name = "Button"
	Button.Parent = StayOpen
	Button.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	Button.BorderSizePixel = 0
	Button.Position = UDim2.new(1, -20, 0, 0)
	Button.Size = UDim2.new(0, 20, 0, 20)
	Button.ZIndex = 10
	table.insert(shade3, Button)

	On.Name = "On"
	On.Parent = Button
	On.BackgroundColor3 = Color3.fromRGB(150, 150, 151)
	On.BackgroundTransparency = 1
	On.BorderSizePixel = 0
	On.Position = UDim2.new(0, 2, 0, 2)
	On.Size = UDim2.new(0, 16, 0, 16)
	On.Font = Enum.Font.SourceSans
	On.FontSize = Enum.FontSize.Size14
	On.Text = ""
	On.TextColor3 = Color3.new(0, 0, 0)
	On.ZIndex = 10

	Positions = makeSettingsButton("Edit/Goto Waypoints", getcustomasset("zeroyield/assets/editwaypoints.png"))
	Positions.Position = UDim2.new(0, 5, 0, 145)
	Positions.Size = UDim2.new(1, -10, 0, 25)
	Positions.Name = "Waypoints"
	Positions.Parent = SettingsHolder

	EventBind = makeSettingsButton("Edit Event Binds", getcustomasset("zeroyield/assets/bindsandplugins.png"), 759)
	EventBind.Position = UDim2.new(0, 5, 0, 205)
	EventBind.Size = UDim2.new(1, -10, 0, 25)
	EventBind.Name = "EventBinds"
	EventBind.Parent = SettingsHolder

	Plugins = makeSettingsButton("Manage Plugins", getcustomasset("zeroyield/assets/bindsandplugins.png"), 743)
	Plugins.Position = UDim2.new(0, 5, 0, 175)
	Plugins.Size = UDim2.new(1, -10, 0, 25)
	Plugins.Name = "Plugins"
	Plugins.Parent = SettingsHolder

	Example.Name = "Example"
	Example.Parent = Holder
	Example.BackgroundTransparency = 1
	Example.BorderSizePixel = 0
	Example.Size = UDim2.new(0, 190, 0, 20)
	Example.Visible = false
	Example.Font = Enum.Font.SourceSans
	Example.TextSize = 18
	Example.Text = "Example"
	Example.TextColor3 = Color3.new(1, 1, 1)
	Example.TextXAlignment = Enum.TextXAlignment.Left
	Example.ZIndex = 10
	table.insert(text1, Example)

	Notification.Name = randomString()
	Notification.Parent = ScaledHolder
	Notification.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	Notification.BorderSizePixel = 0
	Notification.Position = UDim2.new(1, -500, 1, 20)
	Notification.Size = UDim2.new(0, 250, 0, 100)
	Notification.ZIndex = 10
	table.insert(shade1, Notification)

	Title_2.Name = "Title"
	Title_2.Parent = Notification
	Title_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Title_2.BorderSizePixel = 0
	Title_2.Size = UDim2.new(0, 250, 0, 20)
	Title_2.Font = Enum.Font.SourceSans
	Title_2.TextSize = 14
	Title_2.Text = "Notification Title"
	Title_2.TextColor3 = Color3.new(1, 1, 1)
	Title_2.ZIndex = 10
	table.insert(shade2, Title_2)
	table.insert(text1, Title_2)

	Text_2.Name = "Text"
	Text_2.Parent = Notification
	Text_2.BackgroundTransparency = 1
	Text_2.BorderSizePixel = 0
	Text_2.Position = UDim2.new(0, 5, 0, 25)
	Text_2.Size = UDim2.new(0, 240, 0, 75)
	Text_2.Font = Enum.Font.SourceSans
	Text_2.TextSize = 16
	Text_2.Text = "Notification Text"
	Text_2.TextColor3 = Color3.new(1, 1, 1)
	Text_2.TextWrapped = true
	Text_2.ZIndex = 10
	table.insert(text1, Text_2)

	CloseButton.Name = "CloseButton"
	CloseButton.Parent = Notification
	CloseButton.BackgroundTransparency = 1
	CloseButton.Position = UDim2.new(1, -20, 0, 0)
	CloseButton.Size = UDim2.new(0, 20, 0, 20)
	CloseButton.Text = ""
	CloseButton.ZIndex = 10

	CloseImage.Parent = CloseButton
	CloseImage.BackgroundColor3 = Color3.new(1, 1, 1)
	CloseImage.BackgroundTransparency = 1
	CloseImage.Position = UDim2.new(0, 5, 0, 5)
	CloseImage.Size = UDim2.new(0, 10, 0, 10)
	CloseImage.Image = getcustomasset("zeroyield/assets/close.png")
	CloseImage.ZIndex = 10

	PinButton.Name = "PinButton"
	PinButton.Parent = Notification
	PinButton.BackgroundTransparency = 1
	PinButton.Size = UDim2.new(0, 20, 0, 20)
	PinButton.ZIndex = 10
	PinButton.Text = ""

	PinImage.Parent = PinButton
	PinImage.BackgroundColor3 = Color3.new(1, 1, 1)
	PinImage.BackgroundTransparency = 1
	PinImage.Position = UDim2.new(0, 3, 0, 3)
	PinImage.Size = UDim2.new(0, 14, 0, 14)
	PinImage.ZIndex = 10
	PinImage.Image = getcustomasset("zeroyield/assets/pin.png")

	Tooltip.Name = randomString()
	Tooltip.Parent = ScaledHolder
	Tooltip.Active = true
	Tooltip.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	Tooltip.BackgroundTransparency = 0.1
	Tooltip.BorderSizePixel = 0
	Tooltip.Size = UDim2.new(0, 200, 0, 96)
	Tooltip.Visible = false
	Tooltip.ZIndex = 10
	table.insert(shade1, Tooltip)

	Title_3.Name = "Title"
	Title_3.Parent = Tooltip
	Title_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Title_3.BackgroundTransparency = 0.1
	Title_3.BorderSizePixel = 0
	Title_3.Size = UDim2.new(0, 200, 0, 20)
	Title_3.Font = Enum.Font.SourceSans
	Title_3.TextSize = 14
	Title_3.Text = ""
	Title_3.TextColor3 = Color3.new(1, 1, 1)
	Title_3.TextTransparency = 0.1
	Title_3.ZIndex = 10
	table.insert(shade2, Title_3)
	table.insert(text1, Title_3)

	Description.Name = "Description"
	Description.Parent = Tooltip
	Description.BackgroundTransparency = 1
	Description.BorderSizePixel = 0
	Description.Size = UDim2.new(0, 180, 0, 72)
	Description.Position = UDim2.new(0, 10, 0, 18)
	Description.Font = Enum.Font.SourceSans
	Description.TextSize = 16
	Description.Text = ""
	Description.TextColor3 = Color3.new(1, 1, 1)
	Description.TextTransparency = 0.1
	Description.TextWrapped = true
	Description.ZIndex = 10
	table.insert(text1, Description)

	IntroBackground.Name = "IntroBackground"
	IntroBackground.Parent = Holder
	IntroBackground.Active = true
	IntroBackground.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	IntroBackground.BorderSizePixel = 0
	IntroBackground.Position = UDim2.new(0, 0, 0, 45)
	IntroBackground.Size = UDim2.new(0, 250, 0, 175)
	IntroBackground.ZIndex = 10

	Logo.Name = "Logo"
	Logo.Parent = Holder
	Logo.BackgroundTransparency = 1
	Logo.BorderSizePixel = 0
	Logo.Position = UDim2.new(0, 125, 0, 127)
	Logo.Size = UDim2.new(0, 10, 0, 10)
	Logo.Image = getcustomasset("zeroyield/assets/logo.png")
	Logo.ImageTransparency = 0
	Logo.ZIndex = 10

	Credits.Name = "Credits"
	Credits.Parent = Holder
	Credits.BackgroundTransparency = 1
	Credits.BorderSizePixel = 0
	Credits.Position = UDim2.new(0, 0, 0.9, 30)
	Credits.Size = UDim2.new(0, 250, 0, 20)
	Credits.Font = Enum.Font.SourceSansLight
	Credits.FontSize = Enum.FontSize.Size14
	Credits.Text = "Edge // Zwolf // Moon // Toon // Peyton // ATP"
	Credits.TextColor3 = Color3.new(1, 1, 1)
	Credits.ZIndex = 10

	KeybindsFrame.Name = "KeybindsFrame"
	KeybindsFrame.Parent = Settings
	KeybindsFrame.Active = true
	KeybindsFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	KeybindsFrame.BorderSizePixel = 0
	KeybindsFrame.Position = UDim2.new(0, 0, 0, 175)
	KeybindsFrame.Size = UDim2.new(0, 250, 0, 175)
	KeybindsFrame.ZIndex = 10
	table.insert(shade1, KeybindsFrame)

	Close.Name = "Close"
	Close.Parent = KeybindsFrame
	Close.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Close.BorderSizePixel = 0
	Close.Position = UDim2.new(0, 205, 0, 150)
	Close.Size = UDim2.new(0, 40, 0, 20)
	Close.Font = Enum.Font.SourceSans
	Close.TextSize = 14
	Close.Text = "Close"
	Close.TextColor3 = Color3.new(1, 1, 1)
	Close.ZIndex = 10
	table.insert(shade2, Close)
	table.insert(text1, Close)

	Add.Name = "Add"
	Add.Parent = KeybindsFrame
	Add.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Add.BorderSizePixel = 0
	Add.Position = UDim2.new(0, 5, 0, 150)
	Add.Size = UDim2.new(0, 40, 0, 20)
	Add.Font = Enum.Font.SourceSans
	Add.TextSize = 14
	Add.Text = "Add"
	Add.TextColor3 = Color3.new(1, 1, 1)
	Add.ZIndex = 10
	table.insert(shade2, Add)
	table.insert(text1, Add)

	Delete.Name = "Delete"
	Delete.Parent = KeybindsFrame
	Delete.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Delete.BorderSizePixel = 0
	Delete.Position = UDim2.new(0, 50, 0, 150)
	Delete.Size = UDim2.new(0, 40, 0, 20)
	Delete.Font = Enum.Font.SourceSans
	Delete.TextSize = 14
	Delete.Text = "Clear"
	Delete.TextColor3 = Color3.new(1, 1, 1)
	Delete.ZIndex = 10
	table.insert(shade2, Delete)
	table.insert(text1, Delete)

	Holder_2.Name = "Holder"
	Holder_2.Parent = KeybindsFrame
	Holder_2.BackgroundTransparency = 1
	Holder_2.BorderSizePixel = 0
	Holder_2.Position = UDim2.new(0, 0, 0, 0)
	Holder_2.Size = UDim2.new(0, 250, 0, 145)
	Holder_2.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)
	Holder_2.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Holder_2.CanvasSize = UDim2.new(0, 0, 0, 0)
	Holder_2.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Holder_2.ScrollBarThickness = 0
	Holder_2.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Holder_2.VerticalScrollBarInset = "Always"
	Holder_2.ZIndex = 10

	Example_2.Name = "Example"
	Example_2.Parent = KeybindsFrame
	Example_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Example_2.BorderSizePixel = 0
	Example_2.Size = UDim2.new(0, 10, 0, 20)
	Example_2.Visible = false
	Example_2.ZIndex = 10
	table.insert(shade2, Example_2)

	Text_3.Name = "Text"
	Text_3.Parent = Example_2
	Text_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Text_3.BorderSizePixel = 0
	Text_3.Position = UDim2.new(0, 10, 0, 0)
	Text_3.Size = UDim2.new(0, 240, 0, 20)
	Text_3.Font = Enum.Font.SourceSans
	Text_3.TextSize = 14
	Text_3.Text = "nom"
	Text_3.TextColor3 = Color3.new(1, 1, 1)
	Text_3.TextXAlignment = Enum.TextXAlignment.Left
	Text_3.ZIndex = 10
	table.insert(shade2, Text_3)
	table.insert(text1, Text_3)

	Delete_2.Name = "Delete"
	Delete_2.Parent = Text_3
	Delete_2.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	Delete_2.BorderSizePixel = 0
	Delete_2.Position = UDim2.new(0, 200, 0, 0)
	Delete_2.Size = UDim2.new(0, 40, 0, 20)
	Delete_2.Font = Enum.Font.SourceSans
	Delete_2.TextSize = 14
	Delete_2.Text = "Delete"
	Delete_2.TextColor3 = Color3.new(0, 0, 0)
	Delete_2.ZIndex = 10
	table.insert(shade3, Delete_2)
	table.insert(text2, Delete_2)

	KeybindEditor.Name = randomString()
	KeybindEditor.Parent = ScaledHolder
	KeybindEditor.Active = true
	KeybindEditor.BackgroundTransparency = 1
	KeybindEditor.Position = UDim2.new(0.5, -180, 0, -500)
	KeybindEditor.Size = UDim2.new(0, 360, 0, 20)
	KeybindEditor.ZIndex = 10

	background_2.Name = "background"
	background_2.Parent = KeybindEditor
	background_2.Active = true
	background_2.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	background_2.BorderSizePixel = 0
	background_2.Position = UDim2.new(0, 0, 0, 20)
	background_2.Size = UDim2.new(0, 360, 0, 185)
	background_2.ZIndex = 10
	table.insert(shade1, background_2)

	Dark_3.Name = "Dark"
	Dark_3.Parent = background_2
	Dark_3.Active = true
	Dark_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Dark_3.BorderSizePixel = 0
	Dark_3.Position = UDim2.new(0, 135, 0, 0)
	Dark_3.Size = UDim2.new(0, 2, 0, 185)
	Dark_3.ZIndex = 10
	table.insert(shade2, Dark_3)

	Directions.Name = "Directions"
	Directions.Parent = background_2
	Directions.BackgroundTransparency = 1
	Directions.BorderSizePixel = 0
	Directions.Position = UDim2.new(0, 10, 0, 15)
	Directions.Size = UDim2.new(0, 115, 0, 90)
	Directions.ZIndex = 10
	Directions.Font = Enum.Font.SourceSans
	Directions.Text = "Click the button below and press a key/mouse button. Then select what you want to bind it to."
	Directions.TextColor3 = Color3.fromRGB(255, 255, 255)
	Directions.TextSize = 14.000
	Directions.TextWrapped = true
	Directions.TextYAlignment = Enum.TextYAlignment.Top
	table.insert(text1, Directions)

	BindTo.Name = "BindTo"
	BindTo.Parent = background_2
	BindTo.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	BindTo.BorderSizePixel = 0
	BindTo.Position = UDim2.new(0, 10, 0, 95)
	BindTo.Size = UDim2.new(0, 115, 0, 50)
	BindTo.ZIndex = 10
	BindTo.Font = Enum.Font.SourceSans
	BindTo.Text = "Click to bind"
	BindTo.TextColor3 = Color3.fromRGB(255, 255, 255)
	BindTo.TextSize = 16.000
	table.insert(shade2, BindTo)
	table.insert(text1, BindTo)

	TriggerLabel.Name = "TriggerLabel"
	TriggerLabel.Parent = background_2
	TriggerLabel.BackgroundTransparency = 1
	TriggerLabel.Position = UDim2.new(0, 10, 0, 155)
	TriggerLabel.Size = UDim2.new(0, 45, 0, 20)
	TriggerLabel.ZIndex = 10
	TriggerLabel.Font = Enum.Font.SourceSans
	TriggerLabel.Text = "Trigger:"
	TriggerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TriggerLabel.TextSize = 14.000
	TriggerLabel.TextXAlignment = Enum.TextXAlignment.Left
	table.insert(text1, TriggerLabel)

	BindTriggerSelect.Name = "BindTo"
	BindTriggerSelect.Parent = background_2
	BindTriggerSelect.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	BindTriggerSelect.BorderSizePixel = 0
	BindTriggerSelect.Position = UDim2.new(0, 60, 0, 155)
	BindTriggerSelect.Size = UDim2.new(0, 65, 0, 20)
	BindTriggerSelect.ZIndex = 10
	BindTriggerSelect.Font = Enum.Font.SourceSans
	BindTriggerSelect.Text = "KeyDown"
	BindTriggerSelect.TextColor3 = Color3.fromRGB(255, 255, 255)
	BindTriggerSelect.TextSize = 16.000
	table.insert(shade2, BindTriggerSelect)
	table.insert(text1, BindTriggerSelect)

	Add_2.Name = "Add"
	Add_2.Parent = background_2
	Add_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Add_2.BorderSizePixel = 0
	Add_2.Position = UDim2.new(0, 310, 0, 35)
	Add_2.Size = UDim2.new(0, 40, 0, 20)
	Add_2.ZIndex = 10
	Add_2.Font = Enum.Font.SourceSans
	Add_2.Text = "Add"
	Add_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Add_2.TextSize = 14.000
	table.insert(shade2, Add_2)
	table.insert(text1, Add_2)

	Toggles.Name = "Toggles"
	Toggles.Parent = background_2
	Toggles.BackgroundTransparency = 1
	Toggles.BorderSizePixel = 0
	Toggles.Position = UDim2.new(0, 150, 0, 125)
	Toggles.Size = UDim2.new(0, 200, 0, 50)
	Toggles.ZIndex = 10
	Toggles.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Toggles.CanvasSize = UDim2.new(0, 0, 0, 50)
	Toggles.ScrollBarThickness = 8
	Toggles.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Toggles.VerticalScrollBarInset = Enum.ScrollBarInset.Always
	table.insert(scroll, Toggles)

	ClickTP.Name = "Click TP (Hold Key & Click)"
	ClickTP.Parent = Toggles
	ClickTP.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	ClickTP.BorderSizePixel = 0
	ClickTP.Size = UDim2.new(0, 200, 0, 20)
	ClickTP.ZIndex = 10
	ClickTP.Font = Enum.Font.SourceSans
	ClickTP.Text = "    Click TP (Hold Key & Click)"
	ClickTP.TextColor3 = Color3.fromRGB(255, 255, 255)
	ClickTP.TextSize = 14.000
	ClickTP.TextXAlignment = Enum.TextXAlignment.Left
	table.insert(shade2, ClickTP)
	table.insert(text1, ClickTP)

	Select.Name = "Select"
	Select.Parent = ClickTP
	Select.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	Select.BorderSizePixel = 0
	Select.Position = UDim2.new(0, 160, 0, 0)
	Select.Size = UDim2.new(0, 40, 0, 20)
	Select.ZIndex = 10
	Select.Font = Enum.Font.SourceSans
	Select.Text = "Add"
	Select.TextColor3 = Color3.fromRGB(0, 0, 0)
	Select.TextSize = 14.000
	table.insert(shade3, Select)
	table.insert(text2, Select)

	ClickDelete.Name = "Click Delete (Hold Key & Click)"
	ClickDelete.Parent = Toggles
	ClickDelete.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	ClickDelete.BorderSizePixel = 0
	ClickDelete.Position = UDim2.new(0, 0, 0, 25)
	ClickDelete.Size = UDim2.new(0, 200, 0, 20)
	ClickDelete.ZIndex = 10
	ClickDelete.Font = Enum.Font.SourceSans
	ClickDelete.Text = "    Click Delete (Hold Key & Click)"
	ClickDelete.TextColor3 = Color3.fromRGB(255, 255, 255)
	ClickDelete.TextSize = 14.000
	ClickDelete.TextXAlignment = Enum.TextXAlignment.Left
	table.insert(shade2, ClickDelete)
	table.insert(text1, ClickDelete)

	Select_2.Name = "Select"
	Select_2.Parent = ClickDelete
	Select_2.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	Select_2.BorderSizePixel = 0
	Select_2.Position = UDim2.new(0, 160, 0, 0)
	Select_2.Size = UDim2.new(0, 40, 0, 20)
	Select_2.ZIndex = 10
	Select_2.Font = Enum.Font.SourceSans
	Select_2.Text = "Add"
	Select_2.TextColor3 = Color3.fromRGB(0, 0, 0)
	Select_2.TextSize = 14.000
	table.insert(shade3, Select_2)
	table.insert(text2, Select_2)

	Cmdbar_2.Name = "Cmdbar_2"
	Cmdbar_2.Parent = background_2
	Cmdbar_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Cmdbar_2.BorderSizePixel = 0
	Cmdbar_2.Position = UDim2.new(0, 150, 0, 35)
	Cmdbar_2.Size = UDim2.new(0, 150, 0, 20)
	Cmdbar_2.ZIndex = 10
	Cmdbar_2.Font = Enum.Font.SourceSans
	Cmdbar_2.PlaceholderText = "Command"
	Cmdbar_2.Text = ""
	Cmdbar_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Cmdbar_2.TextSize = 14.000
	Cmdbar_2.TextXAlignment = Enum.TextXAlignment.Left

	Cmdbar_3.Name = "Cmdbar_3"
	Cmdbar_3.Parent = background_2
	Cmdbar_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Cmdbar_3.BorderSizePixel = 0
	Cmdbar_3.Position = UDim2.new(0, 150, 0, 60)
	Cmdbar_3.Size = UDim2.new(0, 150, 0, 20)
	Cmdbar_3.ZIndex = 10
	Cmdbar_3.Font = Enum.Font.SourceSans
	Cmdbar_3.PlaceholderText = "Command 2"
	Cmdbar_3.Text = ""
	Cmdbar_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	Cmdbar_3.TextSize = 14.000
	Cmdbar_3.TextXAlignment = Enum.TextXAlignment.Left

	CreateToggle.Name = "CreateToggle"
	CreateToggle.Parent = background_2
	CreateToggle.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	CreateToggle.BackgroundTransparency = 1
	CreateToggle.BorderSizePixel = 0
	CreateToggle.Position = UDim2.new(0, 152, 0, 10)
	CreateToggle.Size = UDim2.new(0, 198, 0, 20)
	CreateToggle.ZIndex = 10
	CreateToggle.Font = Enum.Font.SourceSans
	CreateToggle.Text = "Create Toggle"
	CreateToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	CreateToggle.TextSize = 14.000
	CreateToggle.TextXAlignment = Enum.TextXAlignment.Left
	table.insert(text1, CreateToggle)

	Button_2.Name = "Button"
	Button_2.Parent = CreateToggle
	Button_2.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	Button_2.BorderSizePixel = 0
	Button_2.Position = UDim2.new(1, -20, 0, 0)
	Button_2.Size = UDim2.new(0, 20, 0, 20)
	Button_2.ZIndex = 10
	table.insert(shade3, Button_2)

	On_2.Name = "On"
	On_2.Parent = Button_2
	On_2.BackgroundColor3 = Color3.fromRGB(150, 150, 151)
	On_2.BackgroundTransparency = 1
	On_2.BorderSizePixel = 0
	On_2.Position = UDim2.new(0, 2, 0, 2)
	On_2.Size = UDim2.new(0, 16, 0, 16)
	On_2.ZIndex = 10
	On_2.Font = Enum.Font.SourceSans
	On_2.Text = ""
	On_2.TextColor3 = Color3.fromRGB(0, 0, 0)
	On_2.TextSize = 14.000

	shadow_2.Name = "shadow"
	shadow_2.Parent = KeybindEditor
	shadow_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	shadow_2.BorderSizePixel = 0
	shadow_2.Size = UDim2.new(0, 360, 0, 20)
	shadow_2.ZIndex = 10
	table.insert(shade2, shadow_2)

	PopupText_2.Name = "PopupText_2"
	PopupText_2.Parent = shadow_2
	PopupText_2.BackgroundTransparency = 1
	PopupText_2.Size = UDim2.new(1, 0, 0.949999988, 0)
	PopupText_2.ZIndex = 10
	PopupText_2.Font = Enum.Font.SourceSans
	PopupText_2.Text = "Set Keybinds"
	PopupText_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	PopupText_2.TextSize = 14.000
	PopupText_2.TextWrapped = true
	table.insert(text1, PopupText_2)

	Exit_2.Name = "Exit_2"
	Exit_2.Parent = shadow_2
	Exit_2.BackgroundTransparency = 1
	Exit_2.Position = UDim2.new(1, -20, 0, 0)
	Exit_2.Size = UDim2.new(0, 20, 0, 20)
	Exit_2.ZIndex = 10
	Exit_2.Text = ""

	ExitImage_2.Parent = Exit_2
	ExitImage_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ExitImage_2.BackgroundTransparency = 1
	ExitImage_2.Position = UDim2.new(0, 5, 0, 5)
	ExitImage_2.Size = UDim2.new(0, 10, 0, 10)
	ExitImage_2.ZIndex = 10
	ExitImage_2.Image = getcustomasset("zeroyield/assets/close.png")

	PositionsFrame.Name = "PositionsFrame"
	PositionsFrame.Parent = Settings
	PositionsFrame.Active = true
	PositionsFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	PositionsFrame.BorderSizePixel = 0
	PositionsFrame.Size = UDim2.new(0, 250, 0, 175)
	PositionsFrame.Position = UDim2.new(0, 0, 0, 175)
	PositionsFrame.ZIndex = 10
	table.insert(shade1, PositionsFrame)

	Close_3.Name = "Close"
	Close_3.Parent = PositionsFrame
	Close_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Close_3.BorderSizePixel = 0
	Close_3.Position = UDim2.new(0, 205, 0, 150)
	Close_3.Size = UDim2.new(0, 40, 0, 20)
	Close_3.Font = Enum.Font.SourceSans
	Close_3.TextSize = 14
	Close_3.Text = "Close"
	Close_3.TextColor3 = Color3.new(1, 1, 1)
	Close_3.ZIndex = 10
	table.insert(shade2, Close_3)
	table.insert(text1, Close_3)

	Delete_5.Name = "Delete"
	Delete_5.Parent = PositionsFrame
	Delete_5.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Delete_5.BorderSizePixel = 0
	Delete_5.Position = UDim2.new(0, 50, 0, 150)
	Delete_5.Size = UDim2.new(0, 40, 0, 20)
	Delete_5.Font = Enum.Font.SourceSans
	Delete_5.TextSize = 14
	Delete_5.Text = "Clear"
	Delete_5.TextColor3 = Color3.new(1, 1, 1)
	Delete_5.ZIndex = 10
	table.insert(shade2, Delete_5)
	table.insert(text1, Delete_5)

	Part.Name = "PartGoto"
	Part.Parent = PositionsFrame
	Part.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Part.BorderSizePixel = 0
	Part.Position = UDim2.new(0, 5, 0, 150)
	Part.Size = UDim2.new(0, 40, 0, 20)
	Part.Font = Enum.Font.SourceSans
	Part.TextSize = 14
	Part.Text = "Part"
	Part.TextColor3 = Color3.new(1, 1, 1)
	Part.ZIndex = 10
	table.insert(shade2, Part)
	table.insert(text1, Part)

	Holder_4.Name = "Holder"
	Holder_4.Parent = PositionsFrame
	Holder_4.BackgroundTransparency = 1
	Holder_4.BorderSizePixel = 0
	Holder_4.Position = UDim2.new(0, 0, 0, 0)
	Holder_4.Selectable = false
	Holder_4.Size = UDim2.new(0, 250, 0, 145)
	Holder_4.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)
	Holder_4.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Holder_4.CanvasSize = UDim2.new(0, 0, 0, 0)
	Holder_4.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Holder_4.ScrollBarThickness = 0
	Holder_4.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Holder_4.VerticalScrollBarInset = "Always"
	Holder_4.ZIndex = 10

	Example_4.Name = "Example"
	Example_4.Parent = PositionsFrame
	Example_4.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Example_4.BorderSizePixel = 0
	Example_4.Size = UDim2.new(0, 10, 0, 20)
	Example_4.Visible = false
	Example_4.Position = UDim2.new(0, 0, 0, -5)
	Example_4.ZIndex = 10
	table.insert(shade2, Example_4)

	Text_5.Name = "Text"
	Text_5.Parent = Example_4
	Text_5.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Text_5.BorderSizePixel = 0
	Text_5.Position = UDim2.new(0, 10, 0, 0)
	Text_5.Size = UDim2.new(0, 240, 0, 20)
	Text_5.Font = Enum.Font.SourceSans
	Text_5.TextSize = 14
	Text_5.Text = "Position"
	Text_5.TextColor3 = Color3.new(1, 1, 1)
	Text_5.TextXAlignment = Enum.TextXAlignment.Left
	Text_5.ZIndex = 10
	table.insert(shade2, Text_5)
	table.insert(text1, Text_5)

	Delete_6.Name = "Delete"
	Delete_6.Parent = Text_5
	Delete_6.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	Delete_6.BorderSizePixel = 0
	Delete_6.Position = UDim2.new(0, 200, 0, 0)
	Delete_6.Size = UDim2.new(0, 40, 0, 20)
	Delete_6.Font = Enum.Font.SourceSans
	Delete_6.TextSize = 14
	Delete_6.Text = "Delete"
	Delete_6.TextColor3 = Color3.new(0, 0, 0)
	Delete_6.ZIndex = 10
	table.insert(shade3, Delete_6)
	table.insert(text2, Delete_6)

	TP.Name = "TP"
	TP.Parent = Text_5
	TP.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	TP.BorderSizePixel = 0
	TP.Position = UDim2.new(0, 155, 0, 0)
	TP.Size = UDim2.new(0, 40, 0, 20)
	TP.Font = Enum.Font.SourceSans
	TP.TextSize = 14
	TP.Text = "Goto"
	TP.TextColor3 = Color3.new(0, 0, 0)
	TP.ZIndex = 10
	table.insert(shade3, TP)
	table.insert(text2, TP)

	AliasesFrame.Name = "AliasesFrame"
	AliasesFrame.Parent = Settings
	AliasesFrame.Active = true
	AliasesFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	AliasesFrame.BorderSizePixel = 0
	AliasesFrame.Position = UDim2.new(0, 0, 0, 175)
	AliasesFrame.Size = UDim2.new(0, 250, 0, 175)
	AliasesFrame.ZIndex = 10
	table.insert(shade1, AliasesFrame)

	Close_2.Name = "Close"
	Close_2.Parent = AliasesFrame
	Close_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Close_2.BorderSizePixel = 0
	Close_2.Position = UDim2.new(0, 205, 0, 150)
	Close_2.Size = UDim2.new(0, 40, 0, 20)
	Close_2.Font = Enum.Font.SourceSans
	Close_2.TextSize = 14
	Close_2.Text = "Close"
	Close_2.TextColor3 = Color3.new(1, 1, 1)
	Close_2.ZIndex = 10
	table.insert(shade2, Close_2)
	table.insert(text1, Close_2)

	Delete_3.Name = "Delete"
	Delete_3.Parent = AliasesFrame
	Delete_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Delete_3.BorderSizePixel = 0
	Delete_3.Position = UDim2.new(0, 5, 0, 150)
	Delete_3.Size = UDim2.new(0, 40, 0, 20)
	Delete_3.Font = Enum.Font.SourceSans
	Delete_3.TextSize = 14
	Delete_3.Text = "Clear"
	Delete_3.TextColor3 = Color3.new(1, 1, 1)
	Delete_3.ZIndex = 10
	table.insert(shade2, Delete_3)
	table.insert(text1, Delete_3)

	Holder_3.Name = "Holder"
	Holder_3.Parent = AliasesFrame
	Holder_3.BackgroundTransparency = 1
	Holder_3.BorderSizePixel = 0
	Holder_3.Position = UDim2.new(0, 0, 0, 0)
	Holder_3.Size = UDim2.new(0, 250, 0, 145)
	Holder_3.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)
	Holder_3.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Holder_3.CanvasSize = UDim2.new(0, 0, 0, 0)
	Holder_3.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Holder_3.ScrollBarThickness = 0
	Holder_3.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Holder_3.VerticalScrollBarInset = "Always"
	Holder_3.ZIndex = 10

	Example_3.Name = "Example"
	Example_3.Parent = AliasesFrame
	Example_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Example_3.BorderSizePixel = 0
	Example_3.Size = UDim2.new(0, 10, 0, 20)
	Example_3.Visible = false
	Example_3.ZIndex = 10
	table.insert(shade2, Example_3)

	Text_4.Name = "Text"
	Text_4.Parent = Example_3
	Text_4.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Text_4.BorderSizePixel = 0
	Text_4.Position = UDim2.new(0, 10, 0, 0)
	Text_4.Size = UDim2.new(0, 240, 0, 20)
	Text_4.Font = Enum.Font.SourceSans
	Text_4.TextSize = 14
	Text_4.Text = "honk"
	Text_4.TextColor3 = Color3.new(1, 1, 1)
	Text_4.TextXAlignment = Enum.TextXAlignment.Left
	Text_4.ZIndex = 10
	table.insert(shade2, Text_4)
	table.insert(text1, Text_4)

	Delete_4.Name = "Delete"
	Delete_4.Parent = Text_4
	Delete_4.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	Delete_4.BorderSizePixel = 0
	Delete_4.Position = UDim2.new(0, 200, 0, 0)
	Delete_4.Size = UDim2.new(0, 40, 0, 20)
	Delete_4.Font = Enum.Font.SourceSans
	Delete_4.TextSize = 14
	Delete_4.Text = "Delete"
	Delete_4.TextColor3 = Color3.new(0, 0, 0)
	Delete_4.ZIndex = 10
	table.insert(shade3, Delete_4)
	table.insert(text2, Delete_4)

	PluginsFrame.Name = "PluginsFrame"
	PluginsFrame.Parent = Settings
	PluginsFrame.Active = true
	PluginsFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	PluginsFrame.BorderSizePixel = 0
	PluginsFrame.Position = UDim2.new(0, 0, 0, 175)
	PluginsFrame.Size = UDim2.new(0, 250, 0, 175)
	PluginsFrame.ZIndex = 10
	table.insert(shade1, PluginsFrame)

	Close_4.Name = "Close"
	Close_4.Parent = PluginsFrame
	Close_4.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Close_4.BorderSizePixel = 0
	Close_4.Position = UDim2.new(0, 205, 0, 150)
	Close_4.Size = UDim2.new(0, 40, 0, 20)
	Close_4.Font = Enum.Font.SourceSans
	Close_4.TextSize = 14
	Close_4.Text = "Close"
	Close_4.TextColor3 = Color3.new(1, 1, 1)
	Close_4.ZIndex = 10
	table.insert(shade2, Close_4)
	table.insert(text1, Close_4)

	Add_3.Name = "Add"
	Add_3.Parent = PluginsFrame
	Add_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Add_3.BorderSizePixel = 0
	Add_3.Position = UDim2.new(0, 5, 0, 150)
	Add_3.Size = UDim2.new(0, 40, 0, 20)
	Add_3.Font = Enum.Font.SourceSans
	Add_3.TextSize = 14
	Add_3.Text = "Add"
	Add_3.TextColor3 = Color3.new(1, 1, 1)
	Add_3.ZIndex = 10
	table.insert(shade2, Add_3)
	table.insert(text1, Add_3)

	Holder_5.Name = "Holder"
	Holder_5.Parent = PluginsFrame
	Holder_5.BackgroundTransparency = 1
	Holder_5.BorderSizePixel = 0
	Holder_5.Position = UDim2.new(0, 0, 0, 0)
	Holder_5.Selectable = false
	Holder_5.Size = UDim2.new(0, 250, 0, 145)
	Holder_5.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)
	Holder_5.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Holder_5.CanvasSize = UDim2.new(0, 0, 0, 0)
	Holder_5.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Holder_5.ScrollBarThickness = 0
	Holder_5.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Holder_5.VerticalScrollBarInset = "Always"
	Holder_5.ZIndex = 10

	Example_5.Name = "Example"
	Example_5.Parent = PluginsFrame
	Example_5.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Example_5.BorderSizePixel = 0
	Example_5.Size = UDim2.new(0, 10, 0, 20)
	Example_5.Visible = false
	Example_5.ZIndex = 10
	table.insert(shade2, Example_5)

	Text_6.Name = "Text"
	Text_6.Parent = Example_5
	Text_6.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Text_6.BorderSizePixel = 0
	Text_6.Position = UDim2.new(0, 10, 0, 0)
	Text_6.Size = UDim2.new(0, 240, 0, 20)
	Text_6.Font = Enum.Font.SourceSans
	Text_6.TextSize = 14
	Text_6.Text = "F4 > Toggle Fly"
	Text_6.TextColor3 = Color3.new(1, 1, 1)
	Text_6.TextXAlignment = Enum.TextXAlignment.Left
	Text_6.ZIndex = 10
	table.insert(shade2, Text_6)
	table.insert(text1, Text_6)

	Delete_7.Name = "Delete"
	Delete_7.Parent = Text_6
	Delete_7.BackgroundColor3 = Color3.fromRGB(78, 78, 79)
	Delete_7.BorderSizePixel = 0
	Delete_7.Position = UDim2.new(0, 200, 0, 0)
	Delete_7.Size = UDim2.new(0, 40, 0, 20)
	Delete_7.Font = Enum.Font.SourceSans
	Delete_7.TextSize = 14
	Delete_7.Text = "Delete"
	Delete_7.TextColor3 = Color3.new(0, 0, 0)
	Delete_7.ZIndex = 10
	table.insert(shade3, Delete_7)
	table.insert(text2, Delete_7)

	PluginEditor.Name = randomString()
	PluginEditor.Parent = ScaledHolder
	PluginEditor.BorderSizePixel = 0
	PluginEditor.Active = true
	PluginEditor.BackgroundTransparency = 1
	PluginEditor.Position = UDim2.new(0.5, -180, 0, -500)
	PluginEditor.Size = UDim2.new(0, 360, 0, 20)
	PluginEditor.ZIndex = 10

	background_3.Name = "background"
	background_3.Parent = PluginEditor
	background_3.Active = true
	background_3.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	background_3.BorderSizePixel = 0
	background_3.Position = UDim2.new(0, 0, 0, 20)
	background_3.Size = UDim2.new(0, 360, 0, 160)
	background_3.ZIndex = 10
	table.insert(shade1, background_3)

	Dark_2.Name = "Dark"
	Dark_2.Parent = background_3
	Dark_2.Active = true
	Dark_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	Dark_2.BorderSizePixel = 0
	Dark_2.Position = UDim2.new(0, 222, 0, 0)
	Dark_2.Size = UDim2.new(0, 2, 0, 160)
	Dark_2.ZIndex = 10
	table.insert(shade2, Dark_2)

	Img.Name = "Img"
	Img.Parent = background_3
	Img.BackgroundTransparency = 1
	Img.Position = UDim2.new(0, 242, 0, 3)
	Img.Size = UDim2.new(0, 100, 0, 95)
	Img.Image = getcustomasset("zeroyield/assets/imgstudiopluginlogo.png")
	Img.ZIndex = 10

	AddPlugin.Name = "AddPlugin"
	AddPlugin.Parent = background_3
	AddPlugin.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	AddPlugin.BorderSizePixel = 0
	AddPlugin.Position = UDim2.new(0, 235, 0, 100)
	AddPlugin.Size = UDim2.new(0, 115, 0, 50)
	AddPlugin.Font = Enum.Font.SourceSans
	AddPlugin.TextSize = 14
	AddPlugin.Text = "Add Plugin"
	AddPlugin.TextColor3 = Color3.new(1, 1, 1)
	AddPlugin.ZIndex = 10
	table.insert(shade2, AddPlugin)
	table.insert(text1, AddPlugin)

	FileName.Name = "FileName"
	FileName.Parent = background_3
	FileName.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	FileName.BorderSizePixel = 0
	FileName.Position = UDim2.new(0.028, 0, 0.625, 0)
	FileName.Size = UDim2.new(0, 200, 0, 50)
	FileName.Font = Enum.Font.SourceSans
	FileName.TextSize = 14
	FileName.Text = "Plugin File Name"
	FileName.TextColor3 = Color3.new(1, 1, 1)
	FileName.ZIndex = 10
	table.insert(shade2, FileName)
	table.insert(text1, FileName)

	About.Name = "About"
	About.Parent = background_3
	About.BackgroundTransparency = 1
	About.BorderSizePixel = 0
	About.Position = UDim2.new(0, 17, 0, 10)
	About.Size = UDim2.new(0, 187, 0, 49)
	About.Font = Enum.Font.SourceSans
	About.TextSize = 14
	About.Text = "Plugins are .zy files and should be located in the 'workspace' folder of your exploit."
	About.TextColor3 = Color3.fromRGB(255, 255, 255)
	About.TextWrapped = true
	About.TextYAlignment = Enum.TextYAlignment.Top
	About.ZIndex = 10
	table.insert(text1, About)

	Directions_2.Name = "Directions"
	Directions_2.Parent = background_3
	Directions_2.BackgroundTransparency = 1
	Directions_2.BorderSizePixel = 0
	Directions_2.Position = UDim2.new(0, 17, 0, 60)
	Directions_2.Size = UDim2.new(0, 187, 0, 49)
	Directions_2.Font = Enum.Font.SourceSans
	Directions_2.TextSize = 14
	Directions_2.Text = "Type the name of the plugin file you want to add below."
	Directions_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Directions_2.TextWrapped = true
	Directions_2.TextYAlignment = Enum.TextYAlignment.Top
	Directions_2.ZIndex = 10
	table.insert(text1, Directions_2)

	shadow_3.Name = "shadow"
	shadow_3.Parent = PluginEditor
	shadow_3.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	shadow_3.BorderSizePixel = 0
	shadow_3.Size = UDim2.new(0, 360, 0, 20)
	shadow_3.ZIndex = 10
	table.insert(shade2, shadow_3)

	PopupText_3.Name = "PopupText"
	PopupText_3.Parent = shadow_3
	PopupText_3.BackgroundTransparency = 1
	PopupText_3.Size = UDim2.new(1, 0, 0.95, 0)
	PopupText_3.ZIndex = 10
	PopupText_3.Font = Enum.Font.SourceSans
	PopupText_3.TextSize = 14
	PopupText_3.Text = "Add Plugins"
	PopupText_3.TextColor3 = Color3.new(1, 1, 1)
	PopupText_3.TextWrapped = true
	table.insert(text1, PopupText_3)

	Exit_3.Name = "Exit"
	Exit_3.Parent = shadow_3
	Exit_3.BackgroundTransparency = 1
	Exit_3.Position = UDim2.new(1, -20, 0, 0)
	Exit_3.Size = UDim2.new(0, 20, 0, 20)
	Exit_3.Text = ""
	Exit_3.ZIndex = 10

	ExitImage_3.Parent = Exit_3
	ExitImage_3.BackgroundColor3 = Color3.new(1, 1, 1)
	ExitImage_3.BackgroundTransparency = 1
	ExitImage_3.Position = UDim2.new(0, 5, 0, 5)
	ExitImage_3.Size = UDim2.new(0, 10, 0, 10)
	ExitImage_3.Image = getcustomasset("zeroyield/assets/close.png")
	ExitImage_3.ZIndex = 10

	AliasHint.Name = "AliasHint"
	AliasHint.Parent = AliasesFrame
	AliasHint.BackgroundTransparency = 1
	AliasHint.BorderSizePixel = 0
	AliasHint.Position = UDim2.new(0, 25, 0, 40)
	AliasHint.Size = UDim2.new(0, 200, 0, 50)
	AliasHint.Font = Enum.Font.SourceSansItalic
	AliasHint.TextSize = 16
	AliasHint.Text = "Add aliases by using the 'addalias' command"
	AliasHint.TextColor3 = Color3.new(1, 1, 1)
	AliasHint.TextStrokeColor3 = Color3.new(1, 1, 1)
	AliasHint.TextWrapped = true
	AliasHint.ZIndex = 10
	table.insert(text1, AliasHint)

	PluginsHint.Name = "PluginsHint"
	PluginsHint.Parent = PluginsFrame
	PluginsHint.BackgroundTransparency = 1
	PluginsHint.BorderSizePixel = 0
	PluginsHint.Position = UDim2.new(0, 25, 0, 40)
	PluginsHint.Size = UDim2.new(0, 200, 0, 50)
	PluginsHint.Font = Enum.Font.SourceSansItalic
	PluginsHint.TextSize = 16
	PluginsHint.Text = "Download plugins from the IY Discord (discord.gg/78ZuWSq)"
	PluginsHint.TextColor3 = Color3.new(1, 1, 1)
	PluginsHint.TextStrokeColor3 = Color3.new(1, 1, 1)
	PluginsHint.TextWrapped = true
	PluginsHint.ZIndex = 10
	table.insert(text1, PluginsHint)

	PositionsHint.Name = "PositionsHint"
	PositionsHint.Parent = PositionsFrame
	PositionsHint.BackgroundTransparency = 1
	PositionsHint.BorderSizePixel = 0
	PositionsHint.Position = UDim2.new(0, 25, 0, 40)
	PositionsHint.Size = UDim2.new(0, 200, 0, 70)
	PositionsHint.Font = Enum.Font.SourceSansItalic
	PositionsHint.TextSize = 16
	PositionsHint.Text =
		"Use the 'swp' or 'setwaypoint' command to add a position using your character (NOTE: Part teleports will not save)"
	PositionsHint.TextColor3 = Color3.new(1, 1, 1)
	PositionsHint.TextStrokeColor3 = Color3.new(1, 1, 1)
	PositionsHint.TextWrapped = true
	PositionsHint.ZIndex = 10
	table.insert(text1, PositionsHint)

	ToPartFrame.Name = randomString()
	ToPartFrame.Parent = ScaledHolder
	ToPartFrame.Active = true
	ToPartFrame.BackgroundTransparency = 1
	ToPartFrame.Position = UDim2.new(0.5, -180, 0, -500)
	ToPartFrame.Size = UDim2.new(0, 360, 0, 20)
	ToPartFrame.ZIndex = 10

	background_4.Name = "background"
	background_4.Parent = ToPartFrame
	background_4.Active = true
	background_4.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
	background_4.BorderSizePixel = 0
	background_4.Position = UDim2.new(0, 0, 0, 20)
	background_4.Size = UDim2.new(0, 360, 0, 117)
	background_4.ZIndex = 10
	table.insert(shade1, background_4)

	ChoosePart.Name = "ChoosePart"
	ChoosePart.Parent = background_4
	ChoosePart.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	ChoosePart.BorderSizePixel = 0
	ChoosePart.Position = UDim2.new(0, 100, 0, 55)
	ChoosePart.Size = UDim2.new(0, 75, 0, 30)
	ChoosePart.Font = Enum.Font.SourceSans
	ChoosePart.TextSize = 14
	ChoosePart.Text = "Select Part"
	ChoosePart.TextColor3 = Color3.new(1, 1, 1)
	ChoosePart.ZIndex = 10
	table.insert(shade2, ChoosePart)
	table.insert(text1, ChoosePart)

	CopyPath.Name = "CopyPath"
	CopyPath.Parent = background_4
	CopyPath.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	CopyPath.BorderSizePixel = 0
	CopyPath.Position = UDim2.new(0, 185, 0, 55)
	CopyPath.Size = UDim2.new(0, 75, 0, 30)
	CopyPath.Font = Enum.Font.SourceSans
	CopyPath.TextSize = 14
	CopyPath.Text = "Copy Path"
	CopyPath.TextColor3 = Color3.new(1, 1, 1)
	CopyPath.ZIndex = 10
	table.insert(shade2, CopyPath)
	table.insert(text1, CopyPath)

	Directions_3.Name = "Directions"
	Directions_3.Parent = background_4
	Directions_3.BackgroundTransparency = 1
	Directions_3.BorderSizePixel = 0
	Directions_3.Position = UDim2.new(0, 51, 0, 17)
	Directions_3.Size = UDim2.new(0, 257, 0, 32)
	Directions_3.Font = Enum.Font.SourceSans
	Directions_3.TextSize = 14
	Directions_3.Text = 'Click on a part and then click the "Select Part" button below to set it as a teleport location'
	Directions_3.TextColor3 = Color3.new(1, 1, 1)
	Directions_3.TextWrapped = true
	Directions_3.TextYAlignment = Enum.TextYAlignment.Top
	Directions_3.ZIndex = 10
	table.insert(text1, Directions_3)

	Path.Name = "Path"
	Path.Parent = background_4
	Path.BackgroundTransparency = 1
	Path.BorderSizePixel = 0
	Path.Position = UDim2.new(0, 0, 0, 94)
	Path.Size = UDim2.new(0, 360, 0, 16)
	Path.Font = Enum.Font.SourceSansItalic
	Path.TextSize = 14
	Path.Text = ""
	Path.TextColor3 = Color3.new(1, 1, 1)
	Path.TextScaled = true
	Path.TextWrapped = true
	Path.TextYAlignment = Enum.TextYAlignment.Top
	Path.ZIndex = 10
	table.insert(text1, Path)

	shadow_4.Name = "shadow"
	shadow_4.Parent = ToPartFrame
	shadow_4.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
	shadow_4.BorderSizePixel = 0
	shadow_4.Size = UDim2.new(0, 360, 0, 20)
	shadow_4.ZIndex = 10
	table.insert(shade2, shadow_4)

	PopupText_5.Name = "PopupText"
	PopupText_5.Parent = shadow_4
	PopupText_5.BackgroundTransparency = 1
	PopupText_5.Size = UDim2.new(1, 0, 0.95, 0)
	PopupText_5.ZIndex = 10
	PopupText_5.Font = Enum.Font.SourceSans
	PopupText_5.TextSize = 14
	PopupText_5.Text = "Teleport to Part"
	PopupText_5.TextColor3 = Color3.new(1, 1, 1)
	PopupText_5.TextWrapped = true
	table.insert(text1, PopupText_5)

	Exit_4.Name = "Exit"
	Exit_4.Parent = shadow_4
	Exit_4.BackgroundTransparency = 1
	Exit_4.Position = UDim2.new(1, -20, 0, 0)
	Exit_4.Size = UDim2.new(0, 20, 0, 20)
	Exit_4.Text = ""
	Exit_4.ZIndex = 10

	ExitImage_5.Parent = Exit_4
	ExitImage_5.BackgroundColor3 = Color3.new(1, 1, 1)
	ExitImage_5.BackgroundTransparency = 1
	ExitImage_5.Position = UDim2.new(0, 5, 0, 5)
	ExitImage_5.Size = UDim2.new(0, 10, 0, 10)
	ExitImage_5.Image = getcustomasset("zeroyield/assets/close.png")
	ExitImage_5.ZIndex = 10

	logs.Name = randomString()
	logs.Parent = ScaledHolder
	logs.Active = true
	logs.BackgroundTransparency = 1
	logs.Position = UDim2.new(0, 0, 1, 10)
	logs.Size = UDim2.new(0, 338, 0, 20)
	logs.ZIndex = 10

	shadow.Name = "shadow"
	shadow.Parent = logs
	shadow.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
	shadow.BorderSizePixel = 0
	shadow.Position = UDim2.new(0, 0, 0.00999999978, 0)
	shadow.Size = UDim2.new(0, 338, 0, 20)
	shadow.ZIndex = 10
	table.insert(shade2, shadow)

	Hide.Name = "Hide"
	Hide.Parent = shadow
	Hide.BackgroundTransparency = 1
	Hide.Position = UDim2.new(1, -40, 0, 0)
	Hide.Size = UDim2.new(0, 20, 0, 20)
	Hide.ZIndex = 10
	Hide.Text = ""

	ImageLabel.Parent = Hide
	ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Position = UDim2.new(0, 3, 0, 3)
	ImageLabel.Size = UDim2.new(0, 14, 0, 14)
	ImageLabel.Image = getcustomasset("zeroyield/assets/minimize.png")
	ImageLabel.ZIndex = 10

	PopupText.Name = "PopupText"
	PopupText.Parent = shadow
	PopupText.BackgroundTransparency = 1
	PopupText.Size = UDim2.new(1, 0, 0.949999988, 0)
	PopupText.ZIndex = 10
	PopupText.Font = Enum.Font.SourceSans
	PopupText.FontSize = Enum.FontSize.Size14
	PopupText.Text = "Logs"
	PopupText.TextColor3 = Color3.new(1, 1, 1)
	PopupText.TextWrapped = true
	table.insert(text1, PopupText)

	Exit.Name = "Exit"
	Exit.Parent = shadow
	Exit.BackgroundTransparency = 1
	Exit.Position = UDim2.new(1, -20, 0, 0)
	Exit.Size = UDim2.new(0, 20, 0, 20)
	Exit.ZIndex = 10
	Exit.Text = ""

	ImageLabel_2.Parent = Exit
	ImageLabel_2.BackgroundColor3 = Color3.new(1, 1, 1)
	ImageLabel_2.BackgroundTransparency = 1
	ImageLabel_2.Position = UDim2.new(0, 5, 0, 5)
	ImageLabel_2.Size = UDim2.new(0, 10, 0, 10)
	ImageLabel_2.Image = getcustomasset("zeroyield/assets/close.png")
	ImageLabel_2.ZIndex = 10

	background.Name = "background"
	background.Parent = logs
	background.Active = true
	background.BackgroundColor3 = Color3.new(0.141176, 0.141176, 0.145098)
	background.BorderSizePixel = 0
	background.ClipsDescendants = true
	background.Position = UDim2.new(0, 0, 1, 0)
	background.Size = UDim2.new(0, 338, 0, 245)
	background.ZIndex = 10

	chat.Name = "chat"
	chat.Parent = background
	chat.Active = true
	chat.BackgroundColor3 = Color3.new(0.141176, 0.141176, 0.145098)
	chat.BorderSizePixel = 0
	chat.ClipsDescendants = true
	chat.Size = UDim2.new(0, 338, 0, 245)
	chat.ZIndex = 10
	table.insert(shade1, chat)

	Clear.Name = "Clear"
	Clear.Parent = chat
	Clear.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
	Clear.BorderSizePixel = 0
	Clear.Position = UDim2.new(0, 5, 0, 220)
	Clear.Size = UDim2.new(0, 50, 0, 20)
	Clear.ZIndex = 10
	Clear.Font = Enum.Font.SourceSans
	Clear.FontSize = Enum.FontSize.Size14
	Clear.Text = "Clear"
	Clear.TextColor3 = Color3.new(1, 1, 1)
	table.insert(shade2, Clear)
	table.insert(text1, Clear)

	SaveChatlogs.Name = "SaveChatlogs"
	SaveChatlogs.Parent = chat
	SaveChatlogs.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
	SaveChatlogs.BorderSizePixel = 0
	SaveChatlogs.Position = UDim2.new(0, 258, 0, 220)
	SaveChatlogs.Size = UDim2.new(0, 75, 0, 20)
	SaveChatlogs.ZIndex = 10
	SaveChatlogs.Font = Enum.Font.SourceSans
	SaveChatlogs.FontSize = Enum.FontSize.Size14
	SaveChatlogs.Text = "Save To .txt"
	SaveChatlogs.TextColor3 = Color3.new(1, 1, 1)
	table.insert(shade2, SaveChatlogs)
	table.insert(text1, SaveChatlogs)

	Toggle.Name = "Toggle"
	Toggle.Parent = chat
	Toggle.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
	Toggle.BorderSizePixel = 0
	Toggle.Position = UDim2.new(0, 60, 0, 220)
	Toggle.Size = UDim2.new(0, 66, 0, 20)
	Toggle.ZIndex = 10
	Toggle.Font = Enum.Font.SourceSans
	Toggle.FontSize = Enum.FontSize.Size14
	Toggle.Text = "Disabled"
	Toggle.TextColor3 = Color3.new(1, 1, 1)
	table.insert(shade2, Toggle)
	table.insert(text1, Toggle)

	scroll_2.Name = "scroll"
	scroll_2.Parent = chat
	scroll_2.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
	scroll_2.BorderSizePixel = 0
	scroll_2.Position = UDim2.new(0, 5, 0, 25)
	scroll_2.Size = UDim2.new(0, 328, 0, 190)
	scroll_2.ZIndex = 10
	scroll_2.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	scroll_2.CanvasSize = UDim2.new(0, 0, 0, 10)
	scroll_2.ScrollBarThickness = 8
	scroll_2.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	table.insert(scroll, scroll_2)
	table.insert(shade2, scroll_2)

	join.Name = "join"
	join.Parent = background
	join.Active = true
	join.BackgroundColor3 = Color3.new(0.141176, 0.141176, 0.145098)
	join.BorderSizePixel = 0
	join.ClipsDescendants = true
	join.Size = UDim2.new(0, 338, 0, 245)
	join.Visible = false
	join.ZIndex = 10
	table.insert(shade1, join)

	Toggle_2.Name = "Toggle"
	Toggle_2.Parent = join
	Toggle_2.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
	Toggle_2.BorderSizePixel = 0
	Toggle_2.Position = UDim2.new(0, 60, 0, 220)
	Toggle_2.Size = UDim2.new(0, 66, 0, 20)
	Toggle_2.ZIndex = 10
	Toggle_2.Font = Enum.Font.SourceSans
	Toggle_2.FontSize = Enum.FontSize.Size14
	Toggle_2.Text = "Disabled"
	Toggle_2.TextColor3 = Color3.new(1, 1, 1)
	table.insert(shade2, Toggle_2)
	table.insert(text1, Toggle_2)

	Clear_2.Name = "Clear"
	Clear_2.Parent = join
	Clear_2.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
	Clear_2.BorderSizePixel = 0
	Clear_2.Position = UDim2.new(0, 5, 0, 220)
	Clear_2.Size = UDim2.new(0, 50, 0, 20)
	Clear_2.ZIndex = 10
	Clear_2.Font = Enum.Font.SourceSans
	Clear_2.FontSize = Enum.FontSize.Size14
	Clear_2.Text = "Clear"
	Clear_2.TextColor3 = Color3.new(1, 1, 1)
	table.insert(shade2, Clear_2)
	table.insert(text1, Clear_2)

	scroll_3.Name = "scroll"
	scroll_3.Parent = join
	scroll_3.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
	scroll_3.BorderSizePixel = 0
	scroll_3.Position = UDim2.new(0, 5, 0, 25)
	scroll_3.Size = UDim2.new(0, 328, 0, 190)
	scroll_3.ZIndex = 10
	scroll_3.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	scroll_3.CanvasSize = UDim2.new(0, 0, 0, 10)
	scroll_3.ScrollBarThickness = 8
	scroll_3.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	table.insert(scroll, scroll_3)
	table.insert(shade2, scroll_3)

	selectChat.Name = "selectChat"
	selectChat.Parent = background
	selectChat.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.184314)
	selectChat.BorderSizePixel = 0
	selectChat.Position = UDim2.new(0, 5, 0, 5)
	selectChat.Size = UDim2.new(0, 164, 0, 20)
	selectChat.ZIndex = 10
	selectChat.Font = Enum.Font.SourceSans
	selectChat.FontSize = Enum.FontSize.Size14
	selectChat.Text = "Chat Logs"
	selectChat.TextColor3 = Color3.new(1, 1, 1)
	table.insert(shade2, selectChat)
	table.insert(text1, selectChat)

	selectJoin.Name = "selectJoin"
	selectJoin.Parent = background
	selectJoin.BackgroundColor3 = Color3.new(0.305882, 0.305882, 0.309804)
	selectJoin.BorderSizePixel = 0
	selectJoin.Position = UDim2.new(0, 169, 0, 5)
	selectJoin.Size = UDim2.new(0, 164, 0, 20)
	selectJoin.ZIndex = 10
	selectJoin.Font = Enum.Font.SourceSans
	selectJoin.FontSize = Enum.FontSize.Size14
	selectJoin.Text = "Join Logs"
	selectJoin.TextColor3 = Color3.new(1, 1, 1)
	table.insert(shade3, selectJoin)
	table.insert(text1, selectJoin)

	return env
end
