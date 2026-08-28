return function(env)
	Services = setmetatable({}, {
		__index = function(self, name)
			local success, cache = pcall(function()
				return cloneref(game:GetService(name))
			end)
			if success then
				rawset(self, name, cache)
				return cache
			else
				error("Invalid Service: " .. tostring(name))
			end
		end,
	})

	Players = Services.Players
	UserInputService = Services.UserInputService
	TweenService = Services.TweenService
	HttpService = Services.HttpService
	ExperienceService = Services.ExperienceService
	MarketplaceService = Services.MarketplaceService
	RunService = Services.RunService
	TeleportService = Services.TeleportService
	StarterGui = Services.StarterGui
	GuiService = Services.GuiService
	Lighting = Services.Lighting
	ContextActionService = Services.ContextActionService
	ReplicatedStorage = Services.ReplicatedStorage
	GroupService = Services.GroupService
	PathService = Services.PathfindingService
	SoundService = Services.SoundService
	Teams = Services.Teams
	StarterPlayer = Services.StarterPlayer
	InsertService = Services.InsertService
	ChatService = Services.Chat
	ProximityPromptService = Services.ProximityPromptService
	ContentProvider = Services.ContentProvider
	StatsService = Services.Stats
	MaterialService = Services.MaterialService
	AvatarEditorService = Services.AvatarEditorService
	TextService = Services.TextService
	TextChatService = Services.TextChatService
	CaptureService = Services.CaptureService
	VoiceChatService = Services.VoiceChatService
	SocialService = Services.SocialService

	PlayerGui = cloneref(Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui"))
	COREGUI = Services.CoreGui or PlayerGui
	ZYMouse = cloneref(Players.LocalPlayer:GetMouse())
	PlaceId, JobId = game.PlaceId, game.JobId
	xpcall(function()
		IsOnMobile = table.find({ Enum.Platform.Android, Enum.Platform.IOS }, UserInputService:GetPlatform())
	end, function()
		IsOnMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
	end)
	isLegacyChat = TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService

	-- xylex & europa
	local zyassets = {
		["zeroyield/assets/bindsandplugins.png"] = "rbxassetid://5147695474",
		["zeroyield/assets/close.png"] = "rbxassetid://5054663650",
		["zeroyield/assets/editaliases.png"] = "rbxassetid://5147488658",
		["zeroyield/assets/editkeybinds.png"] = "rbxassetid://129697930",
		["zeroyield/assets/edittheme.png"] = "rbxassetid://4911962991",
		["zeroyield/assets/editwaypoints.png"] = "rbxassetid://5147488592",
		["zeroyield/assets/imgstudiopluginlogo.png"] = "rbxassetid://4113050383",
		["zeroyield/assets/logo.png"] = "rbxassetid://1352543873",
		["zeroyield/assets/minimize.png"] = "rbxassetid://2406617031",
		["zeroyield/assets/pin.png"] = "rbxassetid://6234691350",
		["zeroyield/assets/reference.png"] = "rbxassetid://3523243755",
		["zeroyield/assets/settings.png"] = "rbxassetid://1204397029",
	}

	function getcustomasset(asset)
		if waxgetcustomasset then
			local success, result = pcall(function()
				return waxgetcustomasset(asset)
			end)
			if success and result ~= nil and result ~= "" then
				return result
			end
		end
		return zyassets[asset]
	end

	if makefolder and isfolder and writefile and isfile then
		pcall(function() -- good executor trust
			local assets = "https://raw.githubusercontent.com/infyiff/backup/refs/heads/main/"
			for _, folder in { "zeroyield", "zeroyield/assets" } do
				if not isfolder(folder) then
					makefolder(folder)
				end
			end
			for path in zyassets do
				if not isfile(path) then
					writefile(path, game:HttpGet((path:gsub("zeroyield/", assets))))
				end
			end
			-- honestly just blame your phone if the assets appear in your gallery
			if IsOnMobile then
				writefile("zeroyield/assets/.nomedia", "")
			end
		end)
	end

	currentVersion = "6.6.1"

	return env
end
