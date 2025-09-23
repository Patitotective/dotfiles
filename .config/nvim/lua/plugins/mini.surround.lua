return {
  "nvim-mini/mini.surround",
  opts = {
    custom_surroundings = {
      ["「"] = { input = { "「().-()」" }, output = { left = "「", right = "」" } },
      ["｛"] = { input = { "｛「().-()｝" }, output = { left = "｛", right = "｝" } },
      ["（"] = { input = { "（().-()）" }, output = { left = "（", right = "）" } },
    },
  },
}
