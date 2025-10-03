return {
	entry = function(_, job)
		-- when yazi is opened from yazi.nvim, quit normally
		if os.getenv("NVIM_CWD") == nil then
			-- ya.emit("plugin projects quit", {}) -- for some reason this doesn't work
			require("projects").entry(_, { args = { "quit" } })
		else
			ya.emit("quit", {})
		end
		return
	end,
}
