return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        keys = {
          { "<c-k>", false, mode = { "i" } }, -- disable c-k in insert mode
        },
      },
    },
  },
}
