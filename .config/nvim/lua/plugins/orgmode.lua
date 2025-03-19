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
      org_todo_keywords = { "TODO(t)", "NEXT(n)", "|", "DONE(d)" },
      org_todo_keyword_faces = {
        -- Color list https://codeyarns.com/tech/2011-07-29-vim-chart-of-color-names.html#gsc.tab=0
        TODO = ":foreground hotpink2",
        NEXT = ":foreground orange",
        DONE = ":foreground limegreen",
      },
      -- org_startup_folded = "content",
      org_priority_highest = "A",
      org_priority_default = "D",
      org_priority_lowest = "G",
      org_blank_before_new_entry = {
        heading = false,
        plain_list_item = false,
      },
      org_agenda_span = "month",
      org_agenda_custom_commands = {
        T = {
          description = "To Do",
          types = {
            {
              type = "tags_todo",
              match = "-dev-contribute-crochet-cumpleaños/-DONE",
              org_agenda_sorting_strategy = { "todo-state-down", "priority-down" },
            },
          },
        },
      },
    })
  end,
}
