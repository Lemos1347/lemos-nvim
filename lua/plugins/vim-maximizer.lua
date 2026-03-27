return {
  -- Disable default <leader>sm (search marks) to avoid conflict
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>sm", false },
    },
  },
}
