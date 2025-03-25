version = "1.0.0"
---@diagnostic disable
---local xplr = xplr -- The globally exposed configuration to be overridden.
------@diagnostic enable
---
----- This is the built-in configuration file that gets loaded and sets the
----- default values when xplr loads, before loading any other custom
----- configuration file.
-----
----- You can use this file as a reference to create a your custom config file.
-----
----- To create a custom configuration file, you need to define the script version
----- for compatibility checks.
-----
----- See https://xplr.dev/en/upgrade-guide
-----
----- ```lua
----- version = "0.0.0"
----- ```
---
----- # Configuration ------------------------------------------------------------
-----
----- xplr can be configured using [Lua][1] via a special file named `init.lua`,
----- which can be placed in `~/.config/xplr/` (local to user) or `/etc/xplr/`
----- (global) depending on the use case.
-----
----- When xplr loads, it first executes the [built-in init.lua][2] to set the
----- default values, which is then overwritten by another config file, if found
----- using the following lookup order:
-----
----- 1. `--config /path/to/init.lua`
----- 2. `~/.config/xplr/init.lua`
----- 3. `/etc/xplr/init.lua`
-----
----- The first one found will be loaded by xplr and the lookup will stop.
-----
----- The loaded config can be further extended using the `-C` or `--extra-config`
----- command-line option.
-----
-----
----- [1]: https://www.lua.org
----- [2]: https://github.com/sayanarijit/xplr/blob/main/src/init.lua
----- [3]: https://xplr.dev/en/upgrade-guide
---
----- ## Config ------------------------------------------------------------------
-----
----- The xplr configuration, exposed via `xplr.config` Lua API contains the
----- following sections.
-----
----- See:
-----
----- * [xplr.config.general](https://xplr.dev/en/general-config)
----- * [xplr.config.node_types](https://xplr.dev/en/node_types)
----- * [xplr.config.layouts](https://xplr.dev/en/layouts)
----- * [xplr.config.modes](https://xplr.dev/en/modes)
local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path .. ";" .. xpm_path .. "/?.lua;" .. xpm_path .. "/?/init.lua"

os.execute(string.format("[ -e '%s' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path))

xplr.config.modes.builtin.default.key_bindings.on_key.x = {
	help = "xpm",
	messages = {
		"PopMode",
		{ SwitchModeCustom = "xpm" },
	},
}

require("xpm").setup({
	"dtomvan/xpm.xplr",
	"sayanarijit/tree-view.xplr",
	"sayanarijit/tri-pane.xplr",
})
