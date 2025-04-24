return {
  name = "run in shell",
  builder = function()
    local file = vim.fn.expand("%:p")
    return {
      cmd = { file },
      args = {},
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
}
