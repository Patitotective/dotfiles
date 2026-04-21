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

local function startswith(table, value)
  for i = 1, #table do
    if value:sub(1, #table[i]) == table[i] then
      return true
    end
  end
  return false
end

local function serializeTable(val, name, skipnewlines, depth)
  skipnewlines = skipnewlines or false
  depth = depth or 0

  local tmp = string.rep(" ", depth)

  if name then
    tmp = tmp .. name .. " = "
  end

  if type(val) == "table" then
    tmp = tmp .. "{" .. (not skipnewlines and "\n" or "")

    for k, v in pairs(val) do
      tmp = tmp .. serializeTable(v, k, skipnewlines, depth + 1) .. "," .. (not skipnewlines and "\n" or "")
    end

    tmp = tmp .. string.rep(" ", depth) .. "}"
  elseif type(val) == "number" then
    tmp = tmp .. tostring(val)
  elseif type(val) == "string" then
    tmp = tmp .. string.format("%q", val)
  elseif type(val) == "boolean" then
    tmp = tmp .. (val and "true" or "false")
  else
    tmp = tmp .. '"[inserializeable datatype:' .. type(val) .. ']"'
  end

  return tmp
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

-- This Csv files' fields are shown in different lines, not like a table
local specialCsvDirs = {
  "/home/cristobal/Sync/spain/upv/anki/",
}
-- Colon-delimited
local specialCsv = {
  "/home/cristobal/Sync/data/study_mext.csv",
  "/home/cristobal/Sync/data/study_bunpou.csv",
}
for i = 1, #specialCsvDirs do
  table.insert(specialCsv, string.format("%s*", specialCsvDirs[i]))
end

local semicolonCsv = {
  "/home/cristobal/Documents/orgfiles/notasDeCorteUV.csv",
  "/home/cristobal/Documents/orgfiles/notasDeCorteUPV.csv",
}

-- TODO: for some reason this isn't triggered when opening nvim with the orgfiles fish function
-- and the last opened buffer was a csv file
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "csv", "tsv" },
  callback = function(args)
    local path = vim.api.nvim_buf_get_name(args.buf)
    if contains(semicolonCsv, path) then
      vim.cmd("CsvViewEnable delimiter=;")
    elseif startswith(specialCsvDirs, path) or contains(specialCsv, path) then
      vim.opt_local.filetype = "tex"
      -- vim.opt_local.commentstring = "# %s" -- TODO: make this work
      -- vim.opt_local.comments = "b:#"
    else
      vim.cmd("CsvViewEnable")
    end
  end,
})

-- TODO: ignore \: and \<br> and \<hr>
vim.api.nvim_create_autocmd("BufRead", {
  pattern = specialCsv,
  callback = function()
    vim.cmd("silent /^[^#]/,$s/:/:\\r  /eg")
    vim.cmd("silent %s/<br>/<br>\\r    /eg")
    vim.cmd("silent %s/<hr>/<hr>\\r    /eg")
    vim.cmd("silent %s/\\\\\\\\/\\\\\\\\\\r    /eg")
  end,
})

vim.api.nvim_create_autocmd("BufWriteCmd", {
  pattern = specialCsv,
  callback = function(args)
    local cursorPos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("silent %s/:\\n  /:/e")
    vim.cmd("silent %s/<br>\\n    /<br>/e")
    vim.cmd("silent %s/<hr>\\n    /<br>/e")
    vim.cmd("silent %s/\\\\\\\\\\n    /\\\\\\\\/e")
    vim.cmd("write")
    vim.cmd("silent %s/:/:\\r  /eg") -- TODO: make it work as line 14 (    vim.cmd("silent /^[^#]/,$s/:/:\\r  /eg"))
    vim.cmd("silent %s/<br>/&\\r    /eg")
    vim.cmd("silent %s/<hr>/&\\r    /eg")
    vim.cmd("silent %s/\\\\\\\\/&\\r    /eg")
    vim.cmd("set nomodified")
    vim.api.nvim_win_set_cursor(0, cursorPos)
  end,
})

-- https://github.com/nvim-mini/mini.nvim/issues/1322
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

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "/tmp/nvim-everywhere/*" },
--   callback = function()
--     vim.keymap.del("i", "<c-v>") -- TODO: doesn't work, it says it doesn't exist
--   end,
-- })

-- Quit on save
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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rip-substitute",
  callback = function(ctx)
    vim.keymap.set({ "i", "n" }, "<c-p>", "<c-o><up>", { buffer = ctx.buf, remap = true })
    vim.keymap.set({ "i", "n" }, "<c-n>", "<c-o><down>", { buffer = ctx.buf, remap = true })
    vim.keymap.set("n", "q", "<esc>", { buffer = ctx.buf, remap = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "aerial",
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = true
  end,
})

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "PersistenceLoadPost",
--   callback = function(args)
--     -- We use vim.schedule to ensure the session UI is fully settled
--     -- before we start re-triggering events.
--     vim.notify("a")
--     vim.schedule(function()
--       vim.notify("b")
--       if vim.api.nvim_buf_is_valid(args.buf) and vim.api.nvim_buf_is_loaded(args.buf) then
--         -- Re-trigger FileType and BufReadPost for the buffer
--         -- this will run all your autocmds (CSV, LSP, etc.)
--         vim.api.nvim_exec_autocmds("FileType", { buffer = args.buf })
--         vim.api.nvim_exec_autocmds("BufReadPost", { buffer = args.buf })
--       end
--     end)
--   end,
-- })
