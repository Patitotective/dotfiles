return {
  "stevearc/overseer.nvim",
  opts = {
    templates = { "builtin", "user.nim_run" },
  },
  keys = {
    { "<leader>or", "<cmd>OverseerRestartLast<cr>", desc = "Restart Last Task" },
  },
}
