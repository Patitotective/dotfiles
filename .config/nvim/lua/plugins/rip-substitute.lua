return {
  "chrisgrieser/nvim-rip-substitute",
  opts = {
    keymaps = {
      prevSubstitutionInHistory = "<up>", --"<c-p>",
      nextSubstitutionInHistory = "<down>", --"<c-n>",
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
