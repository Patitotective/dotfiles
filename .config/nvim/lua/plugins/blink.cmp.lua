return {
  "saghen/blink.cmp",
  version = "*",
  opts = {
    keymap = {
      preset = "default",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        path = {
          opts = {
            show_hidden_files_by_default = true,
            ignore_root_slash = true, -- Treat `/path` as starting from the current working directory (cwd) instead of the root of your filesystem
          },
        },
        buffer = {
          max_items = 5,
          min_keyword_length = 3, -- Don't index short buffer tokens immediately
          score_offset = -3,
        },
        lsp = {
          max_items = 30,
          fallbacks = {},
        },
        snippets = {
          min_keyword_length = 2,
        },
      },
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning", -- Fast Rust SIMD matcher
    },

    completion = {
      -- 3. Adjust trigger debounce / delay for fast typing
      keyword = {
        range = "full",
      },
      trigger = {
        show_on_keyword = true,
        show_on_trigger_character = true,
        -- Block automatic popup trigger on backspace to eliminate unnecessary queries
        show_on_backspace = false,
      },
      -- 4. Lazy-render heavy UI elements
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200, -- Delay doc rendering so typing stays 60fps
      },
      ghost_text = {
        enabled = false, -- Disable inline virtual ghost text if it introduces draw lag
      },
    },
  },
}
