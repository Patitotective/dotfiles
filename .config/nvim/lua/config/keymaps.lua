-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<Leader>fp", "<cmd>let @+ = expand('%:p')<CR>", { desc = "Copy absolute path" })
vim.keymap.set("n", "<leader>fi", function()
  vim.notify(vim.fn.system("ls -l " .. vim.fn.expand("%")))
end, { desc = "File information" })
-- vim.keymap.set("n", "<Leader>yx", "<cmd>let @+ = expand('<cfile>')<CR>", { desc = "Copy path/link" })
vim.keymap.del("n", "<C-Down>")
vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Right>")

-- Resize windows
vim.keymap.set("n", "<C-S-j>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<C-S-h>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<C-S-l>", "<cmd>vertical resize +2<cr>")
vim.keymap.set("n", "<C-S-k>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<cr>", "<cmd>write<cr>")

-- Navigation in insert mode
vim.keymap.set("i", "<c-h>", "<left>")
vim.keymap.set("i", "<c-j>", "<down>")
vim.keymap.set("i", "<c-k>", "<up>")
vim.keymap.set("i", "<c-l>", "<right>")
vim.keymap.set("i", "<c-b>", "<s-left>")
vim.keymap.set("i", "<c-f>", "<s-right>")

vim.keymap.set("i", "<c-a>", "<bs>")
vim.keymap.set("i", "<c-s>", "<del>")

vim.keymap.set("i", "<c-v>", "<c-r>+")

-- Since Tab is mapped to toggle fold, c-i needs to be mapped to something for nvim to differentiate bet them
vim.keymap.set("n", "<c-i>", "<c-i>")
