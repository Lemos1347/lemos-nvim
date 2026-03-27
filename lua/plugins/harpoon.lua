return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>a",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Harpoon: Add File",
    },
    {
      "<C-e>",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon: Toggle Menu",
    },
    {
      "<A-a>",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon: Go to File 1",
    },
    {
      "<A-s>",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon: Go to File 2",
    },
    {
      "<A-d>",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon: Go to File 3",
    },
    {
      "<A-f>",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon: Go to File 4",
    },
  },
  config = function()
    require("harpoon"):setup()
  end,
}
