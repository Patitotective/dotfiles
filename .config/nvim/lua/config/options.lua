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

vim.api.nvim_create_user_command("OverseerRestartLast", function()
  local overseer = require("overseer")
  local tasks = overseer.list_tasks({ recent_first = true })
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "restart")
  end
end, {})

vim.api.nvim_create_user_command("LspStart", function(args)
  -- If no argument provided, enable all configured servers for the buffer
  local name = args.fargs[1]
  vim.lsp.enable(name and { name } or nil, true)
end, { nargs = "?" })

vim.api.nvim_create_user_command("LspStop", function(args)
  -- If no argument provided, disable all active servers for the buffer
  local name = args.fargs[1]
  vim.lsp.enable(name and { name } or nil, false)
end, { nargs = "?" })

vim.api.nvim_create_user_command("Anki", function()
  local file = vim.api.nvim_buf_get_name(0)
  os.execute("~/scripts/ankiImport.py " .. file .. "> /dev/null &") -- NOTE: triggers a corrupt collection warning if run while anki is open
  vim.notify("Sent data to Anki")
end, {})
