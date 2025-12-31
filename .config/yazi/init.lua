require("full-border"):setup()

function Linemode:rmtime() -- relative modified time
	local time = math.floor(self._file.cha.mtime or 0)
	local stime

	if time == 0 then
		stime = ""
	elseif os.date("%Y", time) == os.date("%Y") then -- same year
		if os.date("%m", time) == os.date("%m") then -- same month
			local day = tonumber(os.date("%d", time))
			local today = tonumber(os.date("%d"))
			if day == today then -- same day
				stime = os.date("%H:%M", time)
			else
				local diff = today - day
				if diff == 1 then
					stime = os.date("Yesterday %H:%M", time)
				elseif diff < 7 then -- same week
					stime = os.date("%a %H:%M", time)
				else
					stime = os.date("%b %d %H:%M", time)
				end
			end
		else
			stime = os.date("%b %d %H:%M", time)
		end
	else
		stime = os.date("%b %d %Y ", time)
	end

	return string.format("%s", stime)
end

function Linemode:rbtime() -- relative birth time
	local time = math.floor(self._file.cha.btime or 0)
	local stime

	if time == 0 then
		stime = ""
	elseif os.date("%Y", time) == os.date("%Y") then -- same year
		if os.date("%m", time) == os.date("%m") then -- same month
			if os.date("%d", time) == os.date("%d") then -- same day
				stime = os.date("%H:%M", time)
			else
				stime = os.date("%d %H:%M", time)
			end
		else
			stime = os.date("%b %d %H:%M", time)
		end
	else
		stime = os.date("%b %d  %Y", time)
	end

	return string.format("%s", stime)
end

require("folder-rules"):setup()

require("relative-motions"):setup({
	show_numbers = "relative",
	show_motion = true,
	enter_mode = "first",
})

require("yatline"):setup({
	tab_width = 20,
	show_background = false,

	component_positions = { "header", "tab", "status" },

	header_line = {
		left = {
			section_a = {
				{ type = "line", custom = false, name = "tabs", params = { "left" } },
			},
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {},
			section_b = {},
			section_c = {},
		},
	},

	status_line = {
		left = {
			section_a = {
				{ type = "string", custom = false, name = "tab_mode" },
			},
			section_b = {
				{ type = "string", custom = false, name = "hovered_size" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_path" },
			},
		},
		right = {
			section_c = {
				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
				{ type = "coloreds", custom = false, name = "permissions" },
				{ type = "coloreds", custom = false, name = "count", params = { true } }, -- params doesn't do anything... it should show the filtered files as well
			},
			section_b = {
				-- { type = "string", custom = false, name = "cursor_position" }, -- since count already shows the number of total files, i don't want to show the information twice, even if this also shows the current file index
				{ type = "string", custom = false, name = "cursor_percentage" },
			},
			section_a = {
				{ type = "string", custom = false, name = "date", params = { " %H:%M" } },
			},
		},
	},
	theme = {
		style_a = {
			fg = "black",
			bg_mode = {
				normal = "#78A9FF",
				select = "#BE95FF",
				-- un_set = "#d65d0e", -- what is this?
			},
		},
		style_b = {
			fg = "white",
			bg = "#2C3B55",
			-- bg_mode = { -- sadly, it seems this is not supported for style_b
			-- 	normal = "#2C3B55",
			-- 	select = "#413555",
			-- },
		},
		style_c = {
			fg = "white",
			bg = "#0C0C0C",
		},
	},
})

require("bookmarks"):setup({
	last_directory = { enable = true, persist = true },
	persist = "vim",
	desc_format = "full",
	notify = { enable = true },
	file_pick_mode = "hover",
	custom_desc_input = false,
})

require("smart-enter"):setup({
	open_multi = true,
})

require("gvfs"):setup({
	-- (Optional) Allowed keys to select device.
	-- which_keys = "1234567890qwertyuiopasdfghjklzxcvbnm-=[]\\;',./!@#$%^&*()_+{}|:\"<>?",
})

local pref_by_location = require("pref-by-location")
pref_by_location:setup({})

if os.getenv("YAZI_RESTORE") then
	require("projects"):setup({
		save = {
			method = "lua",
		},
		last = {
			load_after_start = true,
			update_before_quit = true,
		},
		notify = {
			enable = false,
		},
	})
end

-- require("git"):setup()
