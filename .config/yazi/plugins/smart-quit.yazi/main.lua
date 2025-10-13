return {
	entry = function(_, job)
		if os.getenv("YAZI_RESTORE") then
			-- ya.emit("plugin projects quit", {}) -- for some reason this doesn't work
			require("projects").entry(_, { args = { "quit" } })
		else
			ya.emit("quit", {})
		end
	end,
}
