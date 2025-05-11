return {
  "sindrets/diffview.nvim",
  opts = function()
    vim.opt.fillchars:append({ diff = "╱" })
  end,
}
