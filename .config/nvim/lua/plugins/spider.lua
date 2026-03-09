-- a bC --
-- á bC --
return {
  {
    "chrisgrieser/nvim-spider",
    enabled = true,
    lazy = false,
    opts = {},
    -- TODO: recognize when the next non-whitespace character is going to be a non-ascii character to use extend_word_motion instead of spider
    -- dependencies = {
    --   "uga-rosa/utf8.nvim",
    -- },
    -- keys = {
    --   {
    --     "w",
    --     -- "<cmd>lua require('spider').motion('w')<CR>",
    --     function()
    --       local region = vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("."))
    --       local utf8 = require("utf8")
    --       if #region < 1 then
    --         return
    --       end
    --       vim.notify_once("a " .. region[1] .. utf8.codepoint(region[1]))
    --       if utf8.codepoint(region[1]) > 126 then
    --         require("extend_word_motion").handle_motion("w")
    --       else
    --         require("spider").motion("w")
    --       end
    --     end,
    --     mode = { "n", "o", "x" },
    --     desc = "Move to start of next of word",
    --   },
    --   {
    --     "e",
    --     "<cmd>lua require('spider').motion('e')<CR>",
    --     mode = { "n", "o", "x" },
    --     desc = "Move to end of word",
    --   },
    --   {
    --     "b",
    --     "<cmd>lua require('spider').motion('b')<CR>",
    --     mode = { "n", "o", "x" },
    --     desc = "Move to start of previous word",
    --   },
    -- },
  },
  -- {
  --   "vhyrro/luarocks.nvim",
  --   priority = 1000, -- high priority required, luarocks.nvim should run as the first plugin in your config
  --   lazy = false,
  --   opts = {
  --     rocks = { "luautf8 ~> 0.1.5" }, -- specifies a list of rocks to install
  --   },
  -- },
}
