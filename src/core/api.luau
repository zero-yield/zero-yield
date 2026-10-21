return function(env)
	function missing(t, f, fallback)
		if type(f) == t then
			return f
		end
		return fallback
	end

	local function firstFunction(...)
		for i = 1, select("#", ...) do
			local value = select(i, ...)
			if type(value) == "function" then
				return value
			end
		end
	end

	function loadcode(source, chunkName)
		if type(source) ~= "string" or source == "" then
			return nil, "empty source"
		end

		local loader = loadstring
		if type(loader) ~= "function" then
			loader = rawget(_G, "load")
		end
		if type(loader) ~= "function" then
			return nil, "missing loadstring"
		end

		local success, func, err = pcall(loader, source, chunkName)
		if success and type(func) == "function" then
			return func
		end
		return nil, err
	end

	syn = missing("table", syn, {})
	getgenv = missing("function", getgenv, function()
		return _G
	end)
	cloneref = missing("function", cloneref, function(value)
		return value
	end)
	gethui = missing("function", gethui or get_hidden_gui)
	syn_protect_gui = missing("function", syn_protect_gui or protect_gui or (syn and syn.protect_gui))
	sethidden = missing("function", sethiddenproperty or set_hidden_property or set_hidden_prop)
	gethidden = missing("function", gethiddenproperty or get_hidden_property or get_hidden_prop)
	queueteleport = missing(
		"function",
		queue_on_teleport or queueonteleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
	)
	httprequest = missing(
		"function",
		request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
	)
	everyClipboard = missing(
		"function",
		setclipboard or toclipboard or set_clipboard or setrbxclipboard or (Clipboard and Clipboard.set)
	)
	firetouchinterest = firstFunction(firetouchinterest, fire_touch_interest)
	waxwritefile, waxreadfile = writefile, readfile
	writefile = missing("function", waxwritefile)
		and function(file, data, safe)
			if safe == true then
				return pcall(waxwritefile, file, data)
			end
			waxwritefile(file, data)
		end
	readfile = missing("function", waxreadfile)
		and function(file, safe)
			if safe == true then
				return pcall(waxreadfile, file)
			end
			return waxreadfile(file)
		end
	isfile = missing("function", isfile, readfile and function(file)
		local success, result = pcall(readfile, file)
		return success and result ~= nil
	end)
	makefolder = missing("function", makefolder)
	listfiles = missing("function", listfiles)
	isfolder = missing("function", isfolder, listfiles and function(folder)
		local success, result = pcall(listfiles, folder)
		return success and type(result) == "table"
	end)
	loadfile = missing("function", loadfile, readfile and function(path)
		local success, source = pcall(readfile, path)
		if not success or type(source) ~= "string" then
			return nil
		end
		return loadcode(source, path)
	end)
	waxgetcustomasset = firstFunction(getcustomasset, getsynasset)
	getcustomasset = function(asset)
		if waxgetcustomasset then
			local success, result = pcall(waxgetcustomasset, asset)
			if success and type(result) == "string" and result ~= "" then
				return result
			end
		end
	end
	hookfunction = firstFunction(hookfunction, replaceclosure, hookfunc)
	hookmetamethod = firstFunction(hookmetamethod, hook_method)
	getnamecallmethod = firstFunction(getnamecallmethod, get_namecall_method)
	checkcaller = missing("function", checkcaller, function()
		return false
	end)
	newcclosure = firstFunction(newcclosure, new_cclosure) or function(func)
		return func
	end
	getgc = firstFunction(getgc, get_gc_objects, getgcobjects)
	setthreadidentity = firstFunction(
		setthreadidentity,
		set_thread_identity,
		setidentity,
		syn_context_set,
		setthreadcontext,
		syn and syn.set_thread_identity
	)
	replicatesignal = firstFunction(replicatesignal, replicate_signal, firesignal)
	getconnections = firstFunction(getconnections, get_signal_cons)
	getnilinstances = firstFunction(getnilinstances, get_nil_instances)
	saveinstance = firstFunction(saveinstance, save_instance)
	printconsole = firstFunction(printconsole, rconsoleprint)
	printoutput = firstFunction(printoutput, printconsole, rconsoleprint)
	setfpscap = firstFunction(setfpscap, set_fps_cap)
	keypress = firstFunction(keypress, key_press)
	keyrelease = firstFunction(keyrelease, key_release)
	mouse1press = firstFunction(mouse1press, mouse1_press)
	mouse1release = firstFunction(mouse1release, mouse1_release)
	fireclickdetector = firstFunction(fireclickdetector, fire_click_detector)
	fireproximityprompt = firstFunction(fireproximityprompt, fire_proximity_prompt)

	function httpget(url, binary)
		if type(game.HttpGet) == "function" then
			local success, result = pcall(function()
				return game:HttpGet(url, binary)
			end)
			if success and result ~= nil then
				return result
			end
		end

		if httprequest then
			local success, response = pcall(httprequest, {
				Url = url,
				Method = "GET",
			})
			if success and type(response) == "table" and response.Body ~= nil then
				return response.Body
			end
		end

		local success, result = pcall(function()
			return game:GetService("HttpService"):GetAsync(url, binary)
		end)
		if success then
			return result
		end
	end

	function getobjects(assetId)
		if type(game.GetObjects) == "function" then
			local success, objects = pcall(function()
				return game:GetObjects(assetId)
			end)
			if success and type(objects) == "table" and #objects > 0 then
				return objects
			end
		end

		local success, insertService = pcall(function()
			return game:GetService("InsertService")
		end)
		local id = tonumber(tostring(assetId):match("%d+"))
		if success and insertService and id then
			local loaded, model = pcall(function()
				return insertService:LoadAsset(id)
			end)
			if loaded and model then
				return { model }
			end
		end
	end

	function loadremote(url, binary)
		if not httpget then
			return false, "missing HTTP functions"
		end

		local success, source = pcall(httpget, url, binary)
		if not success or type(source) ~= "string" or source == "" then
			return false, "failed to download script"
		end

		local func, err = loadcode(source, url)
		if not func then
			return false, err or "failed to compile script"
		end

		local ran, result = pcall(func)
		if not ran then
			return false, result
		end
		return true
	end

	return env
end
