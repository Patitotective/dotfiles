return {
  "hinell/lsp-timeout.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  init = function()
    vim.g.lspTimeoutConfig = {
      stopTimeout = 1000 * 60, -- ms, timeout before stopping all LSPs
      startTimeout = 1000 * 5, -- ms, timeout before restart
    }
  end,
}
