return {
  "stevearc/aerial.nvim",
  lazy = true,
  keys = {
    {
      "<leader>cs",
      function()
        vim.cmd("AerialToggle")
        -- require("aerial").tree_close_all()
      end,
      desc = "Aerial (Symbols)",
    },
  },
  opts = {
    keymaps = {
      ["l"] = "actions.jump",
      ["<tab>"] = "actions.tree_toggle",
      ["L"] = "actions.scroll",
      ["J"] = "actions.down_and_scroll",
      ["K"] = "actions.up_and_scroll",
      ["<c-k>"] = false,
      ["<c-j>"] = false,
    },
    layout = {
      min_width = 30,
      resize_to_content = true,
      placement = "edge",
      default_direction = "right",
      win_opts = {
        statuscolumn = "",
      },
    },
    filter_kind = {
      "Class",
      "Constructor",
      "Enum",
      "EnumMember",
      "Struct",
      "Function",
      "Interface",
      "Module",
      "Method",
      "Boolean",
    },
    manage_folds = false,
    link_folds_to_tree = false,
    link_tree_to_folds = false,
    -- open_automatic = true,
    lazy_load = true,
    on_attach = function(bufnr)
      require("aerial").tree_close_all()
    end,
  },
}
