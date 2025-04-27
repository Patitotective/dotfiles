local function repeatCmd(cmd, times)
  for _ = 1, times do
    vim.cmd(cmd)
  end
end

return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      indicator = {
        style = "none",
        -- icon = " ▐",
      },
      -- separator_style = "thin",
      -- show_close_icon = false,
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
        repeatCmd("BufferLineCycleNext", vim.v.count1)
      end,
      desc = "Next buffer",
    },
    {
      "H",
      function()
        -- vim.cmd("bprev " .. vim.v.count1)
        repeatCmd("BufferLineCyclePrev", vim.v.count1)
      end,
      desc = "Previous buffer",
    },
    {
      "]b",
      function()
        -- vim.cmd("bnext " .. vim.v.count1)
        repeatCmd("BufferLineCycleNext", vim.v.count1)
      end,
      desc = "Next buffer",
    },
    {
      "[b",
      function()
        -- vim.cmd("bprev " .. vim.v.count1)
        repeatCmd("BufferLineCyclePrev", vim.v.count1)
      end,
      desc = "Previous buffer",
    },
  },
}
