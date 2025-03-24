return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<leader>bf", "<cmd>FzfLua lines<cr>", desc = "Find In Open Buffers" },
    { "<leader>bF", "<cmd>FzfLua blines<cr>", desc = "Find In Current Buffer" },
    { "<leader>f~", "<cmd>FzfLua files cwd=~<cr>", desc = "Search files in $HOME" },
    { "<leader>f/", "<cmd>FzfLua files cwd=/<cr>", desc = "Search files in /" },
  },
}
