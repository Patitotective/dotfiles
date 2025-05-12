return {
  name = "nimble build",
  builder = function()
    -- local file = vim.fn.expand("%:p")
    return {
      cmd = { "nimble" },
      args = { "build" },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  -- condition = {
  --   filetype = { "nim" },
  -- },
}
