-- TODO make this work https://github.com/pysan3/fcitx5.nvim#setup
-- https://github.com/keaising/im-select.nvim
-- local method_toggled = false
--
-- -- IM off
-- vim.api.nvim_create_autocmd("InsertLeave", {
--     pattern = "*",
--     callback = function()
--         local im = vim.fn.system(im_check_cmd)
--         if not im_isoff(im) then
--             method_toggled = true
--             vim.fn.system(im_off_cmd)
--         else
--             method_toggled = false
--         end
--     end,
-- })
--
-- -- IM on
-- vim.api.nvim_create_autocmd("InsertEnter", {
--     pattern = "*",
--     callback = function()
--         if method_toggled then
--             vim.fn.system(im_on_cmd)
--             method_toggled = false
--         end
--     end,
-- })
return {
  "pysan3/fcitx5.nvim",
  enabled = false,
  cmd = {
    "Fcitx5",
    "Fcitx5SetName",
    "Fcitx5Geneious",
    "Fcitx5OnModeChanged",
    "Fcitx5SetPrior",
    "Fcitx5GetImname",
    "Fcitx5GetImnames",
  },
  cond = vim.fn.executable("fcitx5-remote") == 1,
  event = { "ModeChanged" },
  opts = {
    -- ... Your Config
    autostart_fcitx5 = true,
  },
}
