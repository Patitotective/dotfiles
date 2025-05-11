return {
  "chrisgrieser/nvim-spider",
  enabled = false,
  opts = {},
  keys = {
    {
      "w",
      "<cmd>lua require('spider').motion('w')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to start of next of word",
    },
    {
      "e",
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to end of word",
    },
    {
      "b",
      "<cmd>lua require('spider').motion('b')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to start of previous word",
    },
  },
  dependencies = {
    { "rami3l/nvim-spider-utf8", build = "rockspec" },
  },
  -- dependencies = {
  --   "theHamsta/nvim_rocks",
  --   -- build = "pip3 install --user hererocks && python3 -mhererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua",
  --   -- build = "yay -S hererocks && python3 -mhererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua",
  --   build = "python3 -mhererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua",
  --   config = function()
  --     require("nvim_rocks").ensure_installed("luautf8")
  --   end,
  -- },
}
