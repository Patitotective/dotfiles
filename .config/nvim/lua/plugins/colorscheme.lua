return {
  {
    "EdenEast/nightfox.nvim",
    opts = {
      transparent = true,
      dim_inactive = true,
      palettes = {
        carbonfox = {
          sel0 = "#3e3e3e", -- Popup bg, visual selection bg -- NOTE: made it brigther
          -- sel1 = "#525253", -- Popup sel bg, search bg
        },
      },
      -- groups = {
      --   all = {
      --     Visual = { bg = "spec.keyword" },
      --     VisualNOS = { link = "Visual" },
      --   },
      -- },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "carbonfox",
    },
  },
}
