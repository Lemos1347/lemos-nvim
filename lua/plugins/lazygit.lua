return {
  -- Disable snacks lazygit keymaps
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>gg", false },
      { "<leader>gG", false },
    },
  },

  -- Add lazygit.nvim
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
    },
  },
}
