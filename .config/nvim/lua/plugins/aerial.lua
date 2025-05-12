return {
  "stevearc/aerial.nvim",
  -- keys = {
  --   {
  --     "<leader>cs",
  --     function()
  --       vim.cmd("AerialToggle")
  --       require("aerial").tree_close_all()
  --     end,
  --     desc = "Aerial (Symbols)",
  --   },
  -- },
  opts = {
    manage_folds = false,
    keymaps = {
      ["l"] = "actions.jump",
      ["<tab>"] = "actions.tree_toggle",
      ["L"] = "actions.scroll",
    },
    layout = {
      resize_to_content = true,
      placement = "edge",
      default_direction = "right",
    },
  },
}
