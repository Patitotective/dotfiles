local function endswith(str, suffix)
  return str:sub(-#suffix) == suffix
end

local function split(str, delimiter)
  local returnTable = {}
  for k, _ in string.gmatch(str, "([^" .. delimiter .. "]+)") do
    returnTable[#returnTable + 1] = k
  end
  return returnTable
end

local function contains(table, value)
  for _, v in ipairs(table) do
    if v == value then
      return true
    end
  end

  return false
end

return {
  "nvim-mini/mini.hipatterns",
  opts = {
    highlighters = {
      rgba_color_hashless = {
        pattern = "%f[%x]%x%x()%x%x%x%x%x%x()%f[%X]", -- To match eight digit hex rgba colors
        group = function(buf_id, _, data)
          if contains({ "conf", "ini" }, vim.bo[buf_id].filetype) then
            return nil
          end
          -- NOTE: for some reason using data.from_col and data_to_col doesn't work here
          local match = data.full_match:sub(1, 6)
          if #match ~= 6 then
            return
          end
          local path = vim.api.nvim_buf_get_name(buf_id)
          if endswith(path, "ly/config.ini") then
            return require("mini.hipatterns").compute_hex_color_group("#" .. data.full_match:sub(3, 8), "bg")
          else
            return require("mini.hipatterns").compute_hex_color_group("#" .. match, "bg")
          end
        end,
        extmark_opts = { priority = 2000 },
      },
      -- TODO: make it work for comma separated 0..1 values
      rgb_color_255 = {
        pattern = "rgb%(%d%d?%d?%s*,%s*%d%d?%d?%s*,%s*%d%d?%d?%)",
        group = function(_, _, data)
          local match = data.full_match:sub(5, -2):gsub("%s+", "")
          local splitted = split(match, ",")
          if #splitted ~= 3 then
            return
          end

          local rx = string.format("%02x", splitted[1])
          local gx = string.format("%02x", splitted[2])
          local bx = string.format("%02x", splitted[3])

          if #rx ~= 2 or #gx ~= 2 or #bx ~= 2 then
            return
          end
          return require("mini.hipatterns").compute_hex_color_group("#" .. rx .. gx .. bx, "bg")
        end,
        extmark_opts = { priority = 2000 },
      },
      rgba_color_255 = {
        pattern = "rgba%(%d%d?%d?%s*,%s*%d%d?%d?%s*,%s*%d%d?%d?,%s*%d%.?%d*%)",
        group = function(_, _, data)
          local match = data.full_match:sub(6, -2):gsub("%s+", "")
          -- vim.notify(match)
          local splitted = split(match, ",")
          if #splitted ~= 4 then
            return
          end

          local rx = string.format("%02x", splitted[1])
          local gx = string.format("%02x", splitted[2])
          local bx = string.format("%02x", splitted[3])

          if #rx ~= 2 or #gx ~= 2 or #bx ~= 2 then
            return
          end
          return require("mini.hipatterns").compute_hex_color_group("#" .. rx .. gx .. bx, "bg")
        end,
        extmark_opts = { priority = 2000 },
      },
      rgba_color = {
        pattern = "rgba%(()%x%x%x%x%x%x()%x%x%)", -- To match the same as above but surrounded by rgba()
        group = function(_, _, data)
          local match = data.full_match:sub(data.from_col, data.to_col)
          if #match == 0 then
            return
          end
          return require("mini.hipatterns").compute_hex_color_group("#" .. match, "bg")
        end,
        extmark_opts = { priority = 2000 },
      },
      rgb_color = {
        pattern = "rgb%(()%x%x%x%x%x%x()%)", -- Same as above but only rgb()
        group = function(_, _, data)
          local match = data.full_match:sub(data.from_col, data.to_col)
          if #match == 0 then
            return
          end
          return require("mini.hipatterns").compute_hex_color_group("#" .. match, "bg")
        end,
        extmark_opts = { priority = 2000 },
      },
      rgb_color_hashless = {
        pattern = "%f[%x]()%x%x%x%x%x%x()%f[%X]", -- To match RGB colors without hash
        group = function(buf_id, _, data)
          if contains({ "conf", "ini" }, vim.bo[buf_id].filetype) then
            return nil
          end
          -- NOTE: for some reason using data.from_col and data_to_col doesn't work here
          -- as it returns some numbers over 70
          local match = data.full_match:sub(1, 6)
          if #match ~= 6 then
            return
          end
          return require("mini.hipatterns").compute_hex_color_group("#" .. data.full_match:sub(1, 6), "bg")
        end,
        extmark_opts = { priority = 1000 },
      },
    },
  },
}
