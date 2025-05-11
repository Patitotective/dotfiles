return {
  "jghauser/fold-cycle.nvim",
  enabled = false,
  keys = {
    {
      "<tab>",
      function()
        return require("fold-cycle").open()
      end,
      silent = true,
      desc = "Fold-cycle: open folds",
    },
    {
      "<s-tab>",
      function()
        return require("fold-cycle").close()
      end,
      silent = true,
      desc = "Fold-cycle: close folds",
    },
  },
}
