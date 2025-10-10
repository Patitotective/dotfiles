function string:endswith(suffix)
  return self:sub(-#suffix) == suffix
end

return {
  "nvim-mini/mini.hipatterns",
  opts = {
    highlighters = {
      rgba_color_hashless = {
        pattern = "%f[%x]()%x%x%x%x%x%x%x%x()%f[%X]", -- To match eight digit hex rgba colors
        group = function(buf_id, _, data)
          local path = vim.api.nvim_buf_get_name(buf_id)
          if path:endswith("ly/config.ini") then
            return require("mini.hipatterns").compute_hex_color_group("#" .. data.full_match:sub(3, 8), "bg")
          else
            return require("mini.hipatterns").compute_hex_color_group("#" .. data.full_match:sub(1, 6), "bg")
          end
        end,
        extmark_opts = { priority = 2000 },
      },
      rgba_color = {
        pattern = "rgba%(()%x%x%x%x%x%x%x%x()%)", -- To match the same as above but surrounded by rgba()
        group = function(_, _, data)
          return require("mini.hipatterns").compute_hex_color_group("#" .. data.full_match:sub(6, 11), "bg")
        end,
        extmark_opts = { priority = 2000 },
      },
      rgb_color = {
        pattern = "rgb%(()%x%x%x%x%x%x()%)", -- Same as above but only rgb()
        group = function(_, _, data)
          return require("mini.hipatterns").compute_hex_color_group("#" .. data.full_match:sub(5, 10), "bg")
        end,
        extmark_opts = { priority = 2000 },
      },
      rgb_color_hashless = {
        pattern = "%f[%x]()%x%x%x%x%x%x()%f[%X]", -- To match RGB colors without hash
        group = function(_, _, data)
          return require("mini.hipatterns").compute_hex_color_group("#" .. data.full_match:sub(1, 6), "bg")
        end,
        extmark_opts = { priority = 1000 },
      },
    },
  },
}
