return {
  -- Window picker for choosing which split to open files in
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    version = "2.*",
    opts = {
      hint = "floating-big-letter",
      selection_chars = "ABCDEFGHIJK",
      filter_rules = {
        autoselect_one = true,
        include_current_win = true,
        bo = {
          filetype = { "snacks_picker_list", "snacks_picker_input", "snacks_layout_box", "noice", "notify" },
          buftype = { "terminal", "nofile" },
        },
      },
    },
  },

  -- Explorer config
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
      explorer = { replace_netrw = true },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            jump = { close = true },
            layout = {
              preset = "sidebar",
              layout = {
                position = "right",
                width = 40,
                min_width = 40,
                box = "vertical",
                { win = "list", border = "none" },
                { win = "input", height = 1, border = true, title = "{title} {live} {flags}", title_pos = "center" },
              },
            },
          },
        },
      },
    },
  },
}
