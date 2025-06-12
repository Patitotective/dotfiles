return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  opts = {
    org_agenda_files = "~/Documents/orgfiles/**/*",
    org_default_notes_file = "~/Documents/orgfiles/1Default.org",
    -- org_archive_location = "zArchive.%s::",
    org_archive_location = "%s_archive::",
    org_id_link_to_org_use_id = true,
    org_cycle_separator_lines = 1,
    calendar_week_start_day = 0,
    -- org_startup_folded = "content",
    org_priority_highest = "A",
    org_priority_default = "D",
    org_priority_lowest = "G",
    org_agenda_span = "week",
    org_agenda_skip_scheduled_if_done = true,
    org_agenda_skip_deadline_if_done = true,
    org_deadline_warning_days = 4,
    org_startup_indented = true,
    org_indent_mode_turns_on_hiding_stars = false,
    org_todo_keywords = { "TODO(t)", "NEXT(n)", "DOING(i)", "|", "DONE(d)" },
    org_todo_keyword_faces = {
      -- Color list https://codeyarns.com/tech/2011-07-29-vim-chart-of-color-names.html#gsc.tab=0
      TODO = ":foreground hotpink2",
      NEXT = ":foreground orange",
      DOING = ":foreground orchid",
      DONE = ":foreground limegreen",
    },
    org_blank_before_new_entry = {
      heading = false,
      plain_list_item = false,
    },
    org_agenda_custom_commands = {
      T = {
        description = "To Do",
        types = {
          {
            type = "tags_todo",
            match = "-pc-dev-contribute-crochet-cumpleaños/-DONE",
            org_agenda_sorting_strategy = { "todo-state-down", "priority-down" },
          },
        },
      },
      p = {
        description = "To PC",
        types = {
          {
            type = "tags_todo",
            match = "pc/-DONE",
            org_agenda_sorting_strategy = { "todo-state-down", "priority-down" },
          },
        },
      },
      d = {
        description = "To Dev",
        types = {
          {
            type = "tags_todo",
            match = "dev/-DONE",
            org_agenda_sorting_strategy = { "todo-state-down", "priority-down" },
          },
        },
      },
      c = {
        description = "To Crochet",
        types = {
          {
            type = "tags_todo",
            match = "crochet/-DONE",
            org_agenda_sorting_strategy = { "todo-state-down", "priority-down" },
          },
        },
      },
    },
    mappings = {
      org = {
        org_cycle = false,
        org_global_cycle = false,
      },
    },
    ui = {
      folds = {
        -- colored = false,
      },
      input = {
        use_vim_ui = true,
      },
    },
  },
}
