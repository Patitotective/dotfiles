return {
  "folke/flash.nvim",
  opts = {
    modes = {
      char = {
        char_actions = function(motion)
          return {
            [","] = "next", -- set to `right` to always go right
            [";"] = "prev", -- set to `left` to always go left
            -- clever-f style
            [motion:lower()] = "next",
            [motion:upper()] = "prev",
            -- jump2d style: same case goes next, opposite case goes prev
            -- [motion] = "next",
            -- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
          }
        end,
      },
    },
  },
}
