local header = [[
            ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗          Z
            ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║      Z    
            ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║   z       
            ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ z         
            ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║           
            ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝           
]]

return {
  "snacks.nvim",
  keys = {
    -- disable the keymap for the explorer
    { "<leader>e", false },
  },
  opts = {
    scroll = { enabled = false },
    explorer = {
      enabled = false,
    },
    dashboard = {
      preset = {
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "s", desc = "Load Session", action = ":lua require('persistence').load()" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = header,
      },
    },
    image = {
      doc = {
        max_width = 40,
        max_height = 20,
      },
      math = { enabled = false },
    },
  },
}
