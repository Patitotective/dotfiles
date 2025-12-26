return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "prettier",
      "bash-language-server",
      "black",
      "clangd",
      "codelldb",
      "google-java-format",
      "jdtls",
      "json-lsp",
      "kdlfmt",
      "lua-language-server",
      "markdown-toc",
      "markdownlint-cli2",
      "marksman",
      "shellcheck",
      "shfmt",
      "stylua",
      "texlab",
      "taplo",
      "tree-sitter-cli",
    },
    automatic_enable = {
      exclude = { "biome" },
    },
  },
}
