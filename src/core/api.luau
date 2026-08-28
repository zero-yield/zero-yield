return function(env)
	function missing(t, f, fallback)
		if type(f) == t then
			return f
		end
		return fallback
	end

	cloneref = missing("function", cloneref, function(...)
		return ...
	end)
	sethidden = missing("function", sethiddenproperty or set_hidden_property or set_hidden_prop)
	gethidden = missing("function", gethiddenproperty or get_hidden_property or get_hidden_prop)
	queueteleport = missing(
		"function",
		queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
	)
	httprequest = missing(
		"function",
		request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
	)
	everyClipboard = missing("function", setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set))
	firetouchinterest = missing("function", firetouchinterest)
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
		local success, result = pcall(function()
			return readfile(file)
		end)
		return success and result ~= nil and result ~= ""
	end)
	makefolder = missing("function", makefolder)
	isfolder = missing("function", isfolder)
	waxgetcustomasset = missing("function", getcustomasset or getsynasset)
	hookfunction = missing("function", hookfunction)
	hookmetamethod = missing("function", hookmetamethod)
	getnamecallmethod = missing("function", getnamecallmethod or get_namecall_method)
	checkcaller = missing("function", checkcaller, function()
		return false
	end)
	newcclosure = missing("function", newcclosure, function(f, ...)
		return f(...)
	end)
	getgc = missing("function", getgc or get_gc_objects)
	setthreadidentity = missing(
		"function",
		setthreadidentity or (syn and syn.set_thread_identity) or syn_context_set or setthreadcontext
	)
	replicatesignal = missing("function", replicatesignal)
	getconnections = missing("function", getconnections or get_signal_cons)

	return env
end
