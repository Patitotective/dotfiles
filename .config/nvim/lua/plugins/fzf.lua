return {
  "ibhagwan/fzf-lua",
  opts = function()
    local actions = require("fzf-lua").actions
    return {
      previewers = {
        custom = {
          cmd = "/home/cristobal/scripts/fzf-preview.sh",
        },
      },
      files = {
        -- previewer = "custom",
      },
      actions = {
        files = {
          ["enter"] = actions.file_edit,
        },
      },
    }
  end,
  keys = {
    { "<leader>bf", "<cmd>FzfLua lines<cr>", desc = "Find In Open Buffers" },
    { "<leader>bF", "<cmd>FzfLua blines<cr>", desc = "Find In Current Buffer" },
    { "<leader>s~", "<cmd>FzfLua files cwd=~<cr>", desc = "Search files in $HOME" },
    { "<leader>s/", "<cmd>FzfLua files cwd=/<cr>", desc = "Search files in /" },
    { "<leader>fc", "<cmd>FzfLua files cwd=~/.config/<cr>", desc = "Search config files" },
    {
      "<leader><space>",
      function()
        LazyVim.pick.open("files", { cwd = vim.fn.getcwd() })
      end,
      desc = "Find Files (Root Dir)",
    },
    {
      "<leader>ff",
      function()
        LazyVim.pick.open("files", { cwd = vim.fn.expand("%:p:h") })
      end,
      desc = "Find Files (cwd)",
    },
    { "<leader>fF", false },
  },
}
