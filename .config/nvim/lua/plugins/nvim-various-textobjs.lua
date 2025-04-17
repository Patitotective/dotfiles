return {
  "chrisgrieser/nvim-various-textobjs",
  enabled = false,
  keys = {
    vim.keymap.set({ "o", "x" }, "x", '<cmd>lua require("various-textobjs").url()<CR>'),
  },
}
