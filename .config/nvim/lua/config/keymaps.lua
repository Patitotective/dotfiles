-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<Leader>fp", "<cmd>let @+ = @%<CR>", { desc = "Copy absolute path" })
-- vim.keymap.set("n", "<Leader>yx", "<cmd>let @+ = expand('<cfile>')<CR>", { desc = "Copy path/link" })
