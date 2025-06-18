-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local function contains(table, value)
  for i = 1, #table do
    if table[i] == value then
      return true
    end
  end
  return false
end

vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
  pattern = { "org", "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.smartindent = false
    vim.opt_local.autoindent = false
    -- vim.opt_local.spell = true
  end,
})

local specialCSV = {
  "/home/cristobal/Sync/data/study_mext.csv",
  "/home/cristobal/Sync/data/study_bunpou.csv",
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "csv", "tsv" },
  callback = function(args)
    if not contains(specialCSV, args.file) then
      require("csvview").enable()
    else
      -- vim.cmd("CsvViewEnable delimiter=:")
    end
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = specialCSV,
  callback = function()
    vim.cmd("silent %s/:/:\\r  /eg")
    vim.cmd("silent %s/<br>/<br>\\r    /eg")
  end,
})

vim.api.nvim_create_autocmd("BufWriteCmd", {
  pattern = specialCSV,
  callback = function()
    vim.cmd("silent %s/:\\n  /:/e")
    vim.cmd("silent %s/<br>\\n    /<br>/e")
    vim.cmd("write")
    vim.cmd("silent %s/:/&\\r  /eg")
    vim.cmd("silent %s/<br>/&\\r    /eg")
    vim.cmd("set nomodified")
    vim.cmd("norm!``")
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
-- vim.api.nvim_create_autocmd("Filetype", {
--   pattern = { "*" },
--   callback = function()
--     -- vim.opt.formatoptions = vim.opt.formatoptions - "o"
--     if vim.bo["ft"] == "css" then
--       vim.opt_local.formatoptions:remove("r") -- don't enter comment leader on Enter in css files
--     end
--     vim.opt.formatoptions = vim.opt.formatoptions + {
--       o = false, -- Don't continue comments with o and O
--     }
--   end,
--   -- group = "mygroup",
--   desc = "Don't continue comments with o and O",
-- })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "fuzzel.ini" },
  callback = function()
    vim.opt_local.commentstring = "# %s"
  end,
})

-- Set focused directory as current working directory
local set_cwd = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify("Cursor is not on valid entry")
  end
  vim.fn.chdir(vim.fs.dirname(path))
end

-- Yank in register full path of entry under cursor
local yank_path = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify("Cursor is not on valid entry")
  end
  vim.fn.setreg(vim.v.register, path)
end

-- Open path with system default handler (useful for non-text files)
local ui_open = function()
  vim.ui.open(MiniFiles.get_fs_entry().path)
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local b = args.data.buf_id
    vim.keymap.set("n", "g~", set_cwd, { buffer = b, desc = "Set cwd" })
    vim.keymap.set("n", "gX", ui_open, { buffer = b, desc = "OS open" })
    vim.keymap.set("n", "gy", yank_path, { buffer = b, desc = "Yank path" })
  end,
})

local set_mark = function(id, path, desc)
  MiniFiles.set_bookmark(id, path, { desc = desc })
end
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesExplorerOpen",
  callback = function()
    set_mark("c", vim.fn.stdpath("config"), "Config") -- path
    set_mark("w", vim.fn.getcwd, "Working directory") -- callable
    set_mark("~", "~", "Home directory")
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "/tmp/nvim-everywhere/*", "/tmp/aerc-compose-*.eml" },
  callback = function()
    vim.opt_local.wrap = true
  end,
})
-- Quit on sav e
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "/tmp/nvim-everywhere/*", "/tmp/aerc-compose-*.eml", "/tmp/yazi-*/bulk-*" },
  callback = function()
    vim.cmd("quit")
  end,
})

-- Disable tab and shift tab since aerc uses that to switch between body and header
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "/tmp/aerc-compose-*.eml",
--   callback = function()
--     vim.keymap.del("n", "<tab>")
--     vim.keymap.del("n", "<s-tab>")
--   end,
-- })

-- Unmap <cr> to save on command line window, since it executes the command of the current line there
vim.api.nvim_create_autocmd("CmdwinEnter", {
  callback = function()
    vim.keymap.del("n", "<cr>")
  end,
})

vim.api.nvim_create_autocmd("CmdwinLeave", {
  callback = function()
    -- TODO: make it actually restore the previous keymap
    vim.keymap.set("n", "<cr>", "<cmd>write<cr>") -- save file
  end,
})
