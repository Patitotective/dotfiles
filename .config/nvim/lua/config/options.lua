-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.shada = "!,'10000,<100,s10,h" -- Increase the number of oldfiles (first number) and stored lines for registers
vim.o.shell = "/usr/bin/fish"
vim.o.mousemoveevent = true
vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
  filename = { ["env-hyprland"] = "conf" },
})
