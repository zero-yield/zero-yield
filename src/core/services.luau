return function(env)
	local function getService(name)
		local success, service = pcall(function()
			return game:GetService(name)
		end)
		if not success or not service then
			return nil
		end

		local cloned, clone = pcall(cloneref, service)
		if cloned and clone then
			return clone
		end
		return service
	end

	local function cloneRef(value)
		if value == nil then
			return nil
		end
		local success, clone = pcall(cloneref, value)
		if success and clone then
			return clone
		end
		return value
	end

	Services = setmetatable({}, {
		__index = function(self, name)
			local service = getService(name)
			if service ~= nil then
				rawset(self, name, service)
			end
			return service
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

	local localPlayer = Players and Players.LocalPlayer
	local waited = 0
	while not localPlayer and waited < 10 do
		task.wait(0.1)
		waited = waited + 0.1
		localPlayer = Players and Players.LocalPlayer
	end

	local playerGui
	if localPlayer then
		playerGui = localPlayer:FindFirstChildWhichIsA("PlayerGui") or localPlayer:WaitForChild("PlayerGui", 10)
	end
	PlayerGui = cloneRef(playerGui)

	local hiddenGui
	if gethui then
		local success, result = pcall(gethui)
		if success and typeof(result) == "Instance" then
			hiddenGui = result
		end
	end
	COREGUI = getService("CoreGui") or hiddenGui or PlayerGui

	local mouse
	if localPlayer then
		local success, result = pcall(function()
			return localPlayer:GetMouse()
		end)
		if success then
			mouse = result
		end
	end
	ZYMouse = cloneRef(mouse)
	PlaceId, JobId = game.PlaceId, game.JobId
	xpcall(function()
		IsOnMobile = table.find({ Enum.Platform.Android, Enum.Platform.IOS }, UserInputService:GetPlatform())
	end, function()
		IsOnMobile = UserInputService and UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
	end)
	isLegacyChat = true
	if TextChatService then
		local success, version = pcall(function()
			return TextChatService.ChatVersion
		end)
		if success then
			isLegacyChat = version == Enum.ChatVersion.LegacyChatService
		end
	end

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
		["zeroyield/assets/scrollbar.png"] = "rbxassetid://75024581433929",
	}

	function getcustomasset(asset)
		if waxgetcustomasset then
			local success, result = pcall(waxgetcustomasset, asset)
			if success and type(result) == "string" and result ~= "" then
				return result
			end
		end
		return zyassets[asset]
	end

	if writefile and isfile then
		pcall(function() -- good executor trust
			local assets = "https://raw.githubusercontent.com/infyiff/backup/refs/heads/main/"
			if makefolder and isfolder then
				for _, folder in { "zeroyield", "zeroyield/assets" } do
					if not isfolder(folder) then
						makefolder(folder)
					end
				end
			end
			for path in zyassets do
				if httpget and path ~= "zeroyield/assets/scrollbar.png" and not isfile(path) then
					local content = httpget((path:gsub("zeroyield/", assets)))
					if content then
						writefile(path, content)
					end
				end
			end
			-- honestly just blame your phone if the assets appear in your gallery
			if IsOnMobile then
				writefile("zeroyield/assets/.nomedia", "")
			end
		end)
	end

	return env
end
