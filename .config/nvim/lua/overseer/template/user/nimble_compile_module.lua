return {
  name = "nimble compile",
  builder = function()
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "nimble" },
      args = { "c", file },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "nim" },
  },
}
