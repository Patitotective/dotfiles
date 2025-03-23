return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<leader>bs", "<cmd>FzfLua lines<cr>", desc = "Search OpenOpen  Buffers Contents" },
    { "<leader>bS", "<cmd>FzfLua blines<cr>", desc = "Search Current Buffer Conents" },
    { "<leader>f~", "<cmd>FzfLua files cwd=~<cr>", desc = "Search files in $HOME" },
    { "<leader>f/", "<cmd>FzfLua files cwd=/<cr>", desc = "Search files in /" },
  },
}
