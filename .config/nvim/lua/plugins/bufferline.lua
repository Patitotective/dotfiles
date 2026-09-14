local function repeatCmd(cmd, times)
  for _ = 1, times do
    vim.cmd(cmd)
  end
end

return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      move_wraps_at_ends = true,
      indicator = {
        style = "none",
      },
      hover = {
        enabled = true,
        delay = 00,
        reveal = { "close" },
      },
      -- Don't use until relative numbers are a feature https://github.com/akinsho/bufferline.nvim/issues/249
      -- numbers = function(opts)
      --   return string.format("%s|", opts.ordinal)
      -- end,
    },
  },
  keys = {
    {
      "L",
      function()
        require("bufferline").cycle(vim.v.count1)
      end,
      desc = "Next buffer",
    },
    {
      "H",
      function()
        require("bufferline").cycle(-vim.v.count1)
      end,
      desc = "Previous buffer",
    },
    {
      "]B",
      function()
        repeatCmd("BufferLineMoveNext", vim.v.count1)
      end,
      desc = "Next buffer",
    },
    {
      "[B",
      function()
        repeatCmd("BufferLineMovePrev", vim.v.count1)
      end,
      desc = "Previous buffer",
    },
    {
      "<leader>1",
      function()
        require("bufferline").go_to(1, true)
      end,
      desc = "Go to 1st buffer",
    },
    {
      "<leader>2",
      function()
        require("bufferline").go_to(2, true)
      end,
      desc = "Go to 2nd buffer",
    },
    {
      "<leader>3",
      function()
        require("bufferline").go_to(3, true)
      end,
      desc = "Go to 3rd buffer",
    },
    {
      "<leader>4",
      function()
        require("bufferline").go_to(4, true)
      end,
      desc = "Go to 4th buffer",
    },
    {
      "<leader>5",
      function()
        require("bufferline").go_to(5, true)
      end,
      desc = "Go to 5th buffer",
    },
    {
      "<leader>6",
      function()
        require("bufferline").go_to(6, true)
      end,
      desc = "Go to 6th buffer",
    },
    {
      "<leader>7",
      function()
        require("bufferline").go_to(7, true)
      end,
      desc = "Go to 7th buffer",
    },
    {
      "<leader>8",
      function()
        require("bufferline").go_to(8, true)
      end,
      desc = "Go to 8th buffer",
    },
    {
      "<leader>9",
      function()
        require("bufferline").go_to(9, true)
      end,
      desc = "Go to 9th buffer",
    },
    {
      "<leader>0",
      function()
        require("bufferline").go_to(10, true)
      end,
      desc = "Go to 10th buffer",
    },
  },
}
