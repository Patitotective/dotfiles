-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
  pattern = { "org", "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    -- vim.opt_local.spell = true
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "csv" },
  callback = function()
    require("csvview").enable()
  end,
})

-- https://github.com/echasnovski/mini.nvim/issues/1322
local function miniFilesWinMaxHeight()
  return vim.o.lines - vim.o.cmdheight - 12
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesWindowUpdate",
  callback = function(args)
    local config = vim.api.nvim_win_get_config(args.data.win_id)

    -- Ensure fixed height
    if config.height > miniFilesWinMaxHeight() then
      config.height = miniFilesWinMaxHeight()
    end

    vim.api.nvim_win_set_config(args.data.win_id, config)
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "fish" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- Taken from https://github.com/dpetka2001/dotfiles/blob/main/dot_config/nvim/lua/config/autocmds.lua
vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "*" },
  callback = function()
    -- vim.opt.formatoptions = vim.opt.formatoptions - "o"
    if vim.bo["ft"] == "css" then
      vim.opt_local.formatoptions:remove("r") -- don't enter comment leader on Enter in css files
    end
    vim.opt.formatoptions = vim.opt.formatoptions + {
      o = false, -- Don't continue comments with o and O
    }
  end,
  -- group = "mygroup",
  desc = "Don't continue comments with o and O",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "fuzzel.ini" },
  callback = function()
    vim.opt_local.commentstring = "# %s"
  end,
})
