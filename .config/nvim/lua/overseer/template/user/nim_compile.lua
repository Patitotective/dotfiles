return {
  name = "nim c",
  builder = function()
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "nim" },
      args = { "c", file },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "nim" },
  },
}
