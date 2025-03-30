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
    { "<leader>f~", "<cmd>FzfLua files cwd=~<cr>", desc = "Search files in $HOME" },
    { "<leader>f/", "<cmd>FzfLua files cwd=/<cr>", desc = "Search files in /" },
  },
}
