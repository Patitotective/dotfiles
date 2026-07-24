return {
  "stevearc/overseer.nvim",
  lazy = true,
  opts = {
    templates = {
      "builtin",
      "user.nim_run",
      "user.nimscript",
      "user.shell",
      "user.nim_compile",
      "user.nimble_run",
      "user.nimble_build",
    },
    on_output_quickfix = {
      items_only = true,
      open = true,
    },
  },
  keys = {
    { "<leader>or", "<cmd>OverseerRestartLast<cr>", desc = "Restart Last Task" },
    { "<leader>oc", false }, -- Since it collides with orgmode capture binding
  },
}
