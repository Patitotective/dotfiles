require("full-border"):setup()

require("folder-rules"):setup()

require("relative-motions"):setup({
	show_numbers = "relative",
	show_motion = true,
	enter_mode = "first",
})

require("yatline"):setup({
	tab_width = 20,
	tab_use_inverse = false,
	show_background = true,
	display_header_line = true,
	display_status_line = true,

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
			section_a = {
				{ type = "string", custom = false, name = "date", params = { "%A, %d %B %Y" } },
			},
			section_b = {
				{ type = "string", custom = false, name = "date", params = { "%X" } },
			},
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
				{ type = "coloreds", custom = false, name = "count" },
			},
		},
		right = {
			section_a = {
				{ type = "string", custom = false, name = "cursor_position" },
			},
			section_b = {
				{ type = "string", custom = false, name = "cursor_percentage" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
				{ type = "coloreds", custom = false, name = "permissions" },
			},
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

function Linemode:rmtime() -- relative modified time
	-- TODO: show yesterday when needed
	-- TODO: show wekkday when same week
	local time = math.floor(self._file.cha.mtime or 0)
	local stime

	if time == 0 then
		stime = ""
	elseif os.date("%d", time) == os.date("%d") then -- same day
		stime = os.date("%H:%M", time)
	elseif os.date("%Y", time) == os.date("%Y") then -- same year
		stime = os.date("%b %d %H:%M", time)
	else
		stime = os.date("%b %d  %Y", time)
	end

	-- local size = self._file:size()
	-- if size and ya.readable_size(size) then
	-- 	return string.format("%s|%s", ya.readable_size(size), time)
	-- else
	return string.format("%s", stime)
end

require("gvfs"):setup({
	-- (Optional) Allowed keys to select device.
	which_keys = "1234567890qwertyuiopasdfghjklzxcvbnm-=[]\\;',./!@#$%^&*()_+{}|:\"<>?",

	-- (Optional) Save file.
	-- Default: ~/.config/yazi/gvfs.private
	save_path = os.getenv("HOME") .. "/.config/yazi/gvfs.private",

	-- (Optional) Input box position.
	-- Default: { "top-center", y = 3, w = 60 },
	-- Position, which is a table:
	-- 	`1`: Origin position, available values: "top-left", "top-center", "top-right",
	-- 	     "bottom-left", "bottom-center", "bottom-right", "center", and "hovered".
	--         "hovered" is the position of hovered file/folder
	-- 	`x`: X offset from the origin position.
	-- 	`y`: Y offset from the origin position.
	-- 	`w`: Width of the input.
	-- 	`h`: Height of the input.
	input_position = { "center", y = 0, w = 60 },

	-- (Optional) Select where to save passwords.
	-- Default: nil
	-- Available options: "keyring", "pass", or nil
	-- password_vault = "keyring",

	-- (Optional) Only need if you set password_vault = "pass"
	-- Read the guide at SECURE_SAVED_PASSWORD.md to get your key_grip
	-- key_grip = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",

	-- (Optional) Auto-save password after mount.
	-- Default: false
	-- save_password_autoconfirm = true,
	-- (Optional) mountpoint of gvfs. Default: /run/user/USER_ID/gvfs
	-- On some system it could be ~/.gvfs
	-- You can't decide this path, it will be created automatically. Only changed if you know where gvfs mountpoint is.
	-- Use command `ps aux | grep gvfs` to search for gvfs process and get the mountpoint path.
	-- root_mountpoint = (os.getenv("XDG_RUNTIME_DIR") or ("/run/user/" .. ya.uid())) .. "/gvfs"
})
