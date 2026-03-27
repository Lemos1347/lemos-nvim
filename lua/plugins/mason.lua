return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- formatters
        "prettierd",
        "prettier",
        "stylua",
        "isort",
        "black",
        "clang-format",
        "cmakelang",
        "goimports",
        -- linters
        "eslint_d",
        "pyright",
      },
    },
  },
}
