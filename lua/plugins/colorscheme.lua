return {
  -- Tokyonight with built-in transparency
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = {
  --     transparent = true,
  --     styles = {
  --       sidebars = "transparent",
  --       floats = "transparent",
  --     },
  --     on_highlights = function(hl, _)
  --       hl.WinSeparator = { fg = "#3b4261", bg = "NONE" }
  --       hl.TreesitterContext = { bg = "NONE" }
  --       hl.CursorLine = { bg = "NONE" }
  --       hl.CursorLineNr = { bg = "NONE" }
  --     end,
  --   },
  -- },

  -- onedark with built-in transparency
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onedark").setup({
        style = "darker",
        transparent = true,
        lualine = {
          transparent = true,
        },
        highlights = {
          WinSeparator = { fg = "#3b4261", bg = "NONE" },
          TreesitterContext = { bg = "NONE" },
          CursorLine = { bg = "NONE" },
          CursorLineNr = { bg = "NONE" },
          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE" },
          FloatTitle = { bg = "NONE" },
        },
      })
      require("onedark").load()
    end,
  },

  -- {
  --   "tiagovla/tokyodark.nvim",
  --   opts = {
  --     -- custom options here
  --   },
  --   config = function(_, opts)
  --     require("tokyodark").setup(opts) -- calling setup is optional
  --     vim.cmd([[colorscheme tokyodark]])
  --   end,
  -- },

  -- Lualine custom layout with transparent background
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}

      opts.options.section_separators = { left = "\u{e0b1}", right = "\u{e0b3}" }
      opts.options.component_separators = { left = "\u{e0b1}", right = "\u{e0b3}" }

      -- Load lualine theme, then make all backgrounds transparent
      -- For sections with dark fg on bright bg (a, z), use the original bg as fg
      -- local ok, lualine_theme = pcall(require, "lualine.themes.tokyonight")
      local ok, lualine_theme = pcall(require, "lualine.themes.onedark")
      -- local ok, lualine_theme = pcall(require, "lualine.themes.tokyodark")
      if ok then
        for _, mode in pairs(lualine_theme) do
          for section_name, section in pairs(mode) do
            if type(section) == "table" then
              if (section_name == "a" or section_name == "z") and section.bg then
                section.fg = section.bg
              end
              section.bg = "NONE"
            end
          end
        end
        opts.options.theme = lualine_theme
      end

      -- Left: MODE | filename + icon | git branch
      opts.sections = opts.sections or {}
      opts.sections.lualine_a = { "mode" }
      opts.sections.lualine_b = {
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 0 },
      }
      opts.sections.lualine_c = { "branch" }

      -- Right: encoding | project name | line/total
      opts.sections.lualine_x = {
        { "encoding" },
      }
      opts.sections.lualine_y = {
        {
          function()
            return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          end,
          icon = "\u{e5ff}",
        },
      }
      opts.sections.lualine_z = {
        { "progress" },
        { "location" },
      }
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
