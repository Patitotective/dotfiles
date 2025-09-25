return {
  "folke/which-key.nvim",
  opts = {
    replace = {
      desc = {
        function(desc)
          return string.lower(desc)
        end,
      },
    },
  },
}
