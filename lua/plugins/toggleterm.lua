return {
  -- Disable snacks terminal
  {
    "folke/snacks.nvim",
    opts = {
      terminal = { enabled = false },
    },
    keys = {
      { "<c-/>", false },
      { "<c-_>", false },
    },
  },

  -- Add toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return math.floor(vim.o.columns * 0.4)
          else
            return 20
          end
        end,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        persist_size = true,
        persist_mode = true,
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          width = function()
            return math.floor(vim.o.columns * 0.85)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.8)
          end,
          winblend = 3,
        },
      })

      local Terminal = require("toggleterm.terminal").Terminal
      local float_term = Terminal:new({ count = 1, direction = "float" })
      local bottom_term = Terminal:new({ count = 2, direction = "horizontal" })
      local vert_term = Terminal:new({ count = 3, direction = "vertical" })

      -- Shift+Alt+t -> floating terminal
      vim.keymap.set({ "n", "t", "i" }, "<A-I>", function()
        float_term:toggle()
      end, { noremap = true, silent = true, desc = "Toggle Floating Terminal" })

      -- Alt+b -> horizontal bottom terminal
      vim.keymap.set({ "n", "t", "i" }, "<A-b>", function()
        bottom_term:toggle()
      end, { noremap = true, silent = true, desc = "Toggle Bottom Terminal" })

      -- Alt+h -> vertical split terminal
      vim.keymap.set({ "n", "t", "i" }, "<A-v>", function()
        vert_term:toggle()
      end, { noremap = true, silent = true, desc = "Toggle Vertical Terminal" })
    end,
  },
}
