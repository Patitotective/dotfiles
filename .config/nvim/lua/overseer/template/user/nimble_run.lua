return {
  name = "nimble run",
  builder = function()
    -- local file = vim.fn.expand("%:p")
    return {
      cmd = { "nimble" },
      args = { "run" },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  -- condition = {
  --   filetype = { "nim" },
  -- },
}
