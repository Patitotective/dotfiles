return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      nim = { "nph" },
      toml = { "taplo" },
      kdl = { "kdlfmt" },
      python = { "black" },
      rust = { "rustfmt" },
      java = { "google-java-format" },
      bash = { "shfmt" },
      lua = { "stylua" },

      markdown = { "prettier" },
      angular = { "prettier" },
      css = { "prettier" },
      flow = { "prettier" },
      graphql = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      jsx = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      vue = { "prettier" },
      yaml = { "prettier" },
    },
    formatters = {
      kdlfmt = {
        inherit = false,
        args = { "format", "--kdl-version v1", "-" },
      },
    },
  },
}
