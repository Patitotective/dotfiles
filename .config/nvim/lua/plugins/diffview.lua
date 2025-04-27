return {
  "sindrets/diffview.nvim",
  lazy = true,
  opts = function()
    vim.opt.fillchars:append({ diff = "╱" })
  end,
}
