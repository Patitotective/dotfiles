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

-- Navigation in insert mode
vim.keymap.set({ "i", "c" }, "<c-h>", "<left>")
vim.keymap.set({ "i", "c" }, "<c-l>", "<right>")
vim.keymap.set({ "i" }, "<c-j>", "<down>")
vim.keymap.set({ "i" }, "<c-k>", "<up>")

vim.keymap.set({ "i", "c" }, "<c-a>", "<home>") -- start of line
vim.keymap.set({ "i", "c" }, "<c-e>", "<end>") -- end of line
vim.keymap.set({ "c" }, "<c-b>", "<s-left>") -- prev word
vim.keymap.set({ "c" }, "<c-f>", "<s-right>") -- next word
vim.keymap.set({ "i" }, "<c-b>", "<c-o>b") -- prev word
vim.keymap.set({ "i" }, "<c-f>", "<c-o>w") -- next word

vim.keymap.set({ "i" }, "<c-u>", "<c-o>d0") -- del until start of line
vim.keymap.set({ "i" }, "<c-c>", "<c-o>d$") -- del until end of line
vim.keymap.set({ "i", "c" }, "<c-s>", "<bs>") -- del prev char
vim.keymap.set({ "i", "c" }, "<c-d>", "<del>") -- del next char

vim.keymap.set({ "i", "c" }, "<c-v>", "<c-r>+") -- paste

vim.keymap.set("n", "<cr>", "<cmd>write<cr>") -- save file

-- Since Tab is mapped to toggle fold, c-i needs to be mapped to something for nvim to differentiate bet them
vim.keymap.set("n", "<c-i>", "<c-i>")

-- Tabs
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>[")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab>l")

vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnew<cr>")
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnext<cr>")
vim.keymap.set("n", "<leader><tab><s-tab>", "<cmd>tabprev<cr>")
vim.keymap.set("n", "<leader><tab>0", "<cmd>tabfirst<cr>")
vim.keymap.set("n", "<leader><tab>$", "<cmd>tablast<cr>")

-- Comments
-- vim.keymap.del("n", "gco")
-- vim.keymap.del("n", "gcO")
-- -- vim.keymap.del("n", "gcc") -- Uncommenting this makes it fail with Too much rescursion
-- vim.keymap.set("n", "gc", "<cmd>norm gcc<CR>")
