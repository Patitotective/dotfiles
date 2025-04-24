return {
  "stevearc/overseer.nvim",
  opts = {
    templates = { "builtin", "user.nim_run", "user.nimscript", "user.shell" },
    on_output_quickfix = {
      items_only = true,
      open = true,
    },
  },
  keys = {
    { "<leader>or", "<cmd>OverseerRestartLast<cr>", desc = "Restart Last Task" },
  },
}
