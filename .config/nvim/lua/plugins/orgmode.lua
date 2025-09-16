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
    org_agenda_start_on_weekday = 7,
    org_startup_folded = "overview",
    org_priority_highest = "A",
    org_priority_default = "D",
    org_priority_lowest = "G",
    org_agenda_span = "day",
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
      -- D = { -- TODO: Fix nothing comiing out here
      --   description = "Done",
      --   types = {
      --     {
      --       type = "tags",
      --       match = "/DONE",
      --       -- org_agenda_sorting_strategy = { "time-up" },
      --     },
      --   },
      -- },
      T = {
        description = "To Do",
        types = {
          {
            type = "tags_todo",
            match = "-dev-contribute-cumpleaños/-DONE",
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
      A = {
        description = "Weekly Agenda",
        types = {
          {
            type = "agenda",
            org_agenda_span = "week",
          },
        },
      },
      u = {
        description = "To UPV",
        types = {
          {
            type = "tags_todo",
            match = "upv/-DONE",
            org_agenda_sorting_strategy = { "todo-state-down", "priority-down" },
          },
        },
      },
    },
    org_capture_templates = {
      o = {
        description = "oneshot task",
        target = "~/Documents/orgfiles/1Default.org",
        headline = "Oneshot",
        template = "** TODO %?\n %u",
      },
    },
    mappings = {
      org = {
        org_cycle = false,
        org_global_cycle = false,
        org_meta_return = "<leader>oih",
        org_insert_heading_respect_content = "<leader><cr>",
      },
    },
    ui = {
      input = {
        use_vim_ui = true,
      },
    },
  },
}
