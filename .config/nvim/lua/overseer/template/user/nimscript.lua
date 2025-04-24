return {
  name = "nim e",
  builder = function()
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "nim" },
      args = { "e", file },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "nim" },
  },
}
