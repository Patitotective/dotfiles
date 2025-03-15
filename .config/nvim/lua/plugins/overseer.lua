return {
  "stevearc/overseer.nvim",
  opts = {
    templates = { "builtin", "user.nim_run" },
    on_output_quickfix = {
      items_only = true,
      open = true,
    },
  },
  keys = {
    { "<leader>or", "<cmd>OverseerRestartLast<cr>", desc = "Restart Last Task" },
  },
}
