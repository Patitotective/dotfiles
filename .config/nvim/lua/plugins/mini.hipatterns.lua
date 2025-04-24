return {
  "echasnovski/mini.hipatterns",
  opts = {
    highlighters = {
      rgba_color_hashless = {
        pattern = "%f[%x]()%x%x%x%x%x%x%x%x()%f[%X]", -- To match RGBA colors without hash
        group = function(_, _, data)
          return require("mini.hipatterns").compute_hex_color_group("#" .. data.full_match:sub(1, 6), "bg")
        end,
        extmark_opts = { priority = 2000 },
      },
      rgba_color = {
        pattern = "rgba%(()%x%x%x%x%x%x%x%x()%)", -- To match RGBA colors without hash
        group = function(_, _, data)
          return require("mini.hipatterns").compute_hex_color_group("#" .. data.full_match:sub(6, 11), "bg")
        end,
        extmark_opts = { priority = 2000 },
      },
      rgb_color = {
        pattern = "rgb%(()%x%x%x%x%x%x()%)", -- To match RGBA colors without hash
        group = function(_, _, data)
          return require("mini.hipatterns").compute_hex_color_group("#" .. data.full_match:sub(5, 10), "bg")
        end,
        extmark_opts = { priority = 2000 },
      },
      -- Both patterns match :/
      -- hex_color_hashless = {
      --   pattern = "()%x%x%x%x%x%x()%f[%X]", -- To match RGBA colors without hash
      --   group = function(_, _, data)
      --     return require("mini.hipatterns").compute_hex_color_group("#" .. data.full_match:sub(1, 6), "bg")
      --   end,
      --   extmark_opts = { priority = 1000 },
      -- },
    },
  },
}
