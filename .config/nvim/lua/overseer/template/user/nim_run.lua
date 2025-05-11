return {
  name = "nim compile and run",
  builder = function()
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "nim" },
      args = { "c", "-r", file },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "nim" },
  },
}
