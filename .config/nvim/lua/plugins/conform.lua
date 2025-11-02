return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      nim = { "nph" },
      toml = { "tombi" },
      kdl = { "kdlfmt" },
      python = { "black" },
      rust = { "rustfmt" },
    },
  },
}
