return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  config = function()
    -- Setup orgmode
    local org = require("orgmode")
    org.setup({
      org_agenda_files = "~/Documents/orgfiles/**/*",
      org_default_notes_file = "~/Documents/orgfiles/Default.org",
      -- org_startup_folded = "content",
      org_priority_highest = "A",
      org_priority_default = "D",
      org_priority_lowest = "G",
      org_blank_before_new_entry = {
        heading = false,
        plain_list_item = false,
      },
    })

    vim.keymap.set("n", "<leader>cor", function()
      -- local Agenda = require("orgmode.agenda")
      -- org.agenda:open_view("search", { search = "install" })
      require("orgmode.api.agenda").agenda({})
    end)
  end,
}
