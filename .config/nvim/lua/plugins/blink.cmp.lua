return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
    },
    sources = {
      providers = {
        path = {
          opts = {
            show_hidden_files_by_default = true,
            ignore_root_slash = true, -- Treat `/path` as starting from the current working directory (cwd) instead of the root of your filesystem
          },
        },
      },
    },
  },
}
