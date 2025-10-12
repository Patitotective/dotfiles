return {
  "chrisgrieser/nvim-rip-substitute",
  opts = {
    popupWin = {
      disableCompletions = false,
    },
    keymaps = {
      abort = "<esc>",
      -- abort = { "q", "<esc>" },
      prevSubstitutionInHistory = "<up>",
      nextSubstitutionInHistory = "<down>",
    },
  },
  keys = {
    {
      "g/",
      function()
        require("rip-substitute").sub()
      end,
      mode = { "n", "x" },
      desc = " Rip Substitute",
    },
  },
}
