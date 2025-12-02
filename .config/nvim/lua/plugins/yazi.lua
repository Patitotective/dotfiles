---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>e",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      -- Open in the current working directory
      "<leader>E",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
    {
      "<c-up>",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  ---@type YaziConfig | {}
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
      open_file_in_vertical_split = false, -- "<c-v>",
      open_file_in_horizontal_split = false, -- "<c-x>",
      open_file_in_tab = false, -- "<c-t>",
      grep_in_directory = false, -- "<c-s>",
      replace_in_directory = false, -- "<c-g>",
      cycle_open_buffers = false, -- "<tab>",
      copy_relative_path_to_selected_files = false, -- "<c-y>",
      send_to_quickfix_list = false, -- "<c-q>",
      change_working_directory = false, -- "<c-\\>",
      open_and_pick_window = false, -- "<c-o>",
    },
  },
  -- 👇 if you use `open_for_directories=true`, this is recommended
  init = function()
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    -- vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
}
