require("core.common")

hl.on("window.active", function(w)
	-- Fetch current live active window from Hyprland state
	local active = hl.get_active_window()

	-- 1. If active is nil, the workspace is now completely empty
	if active == nil then
		return
	end

	-- 2. Verify geometry exists on the currently active window
	if active.at ~= nil and active.size ~= nil then
		local x = active.at.x
		local y = active.size.x and active.at.x -- safety check
		local width = active.size.x
		local height = active.size.y

		-- Fire spotlight to Quickshell
		local cmd = string.format(
			"quickshell ipc call main triggerSpotlight %d %d %d %d",
			active.at.x,
			active.at.y,
			width,
			height
		)
		hl.exec_cmd(cmd)
	end
end)
