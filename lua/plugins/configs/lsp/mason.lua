local options = {
  ensure_installed = {
    "lua-language-server",
    "prettier", -- prettier formatter
    "prettierd",
    "stylua", -- lua formatter
    "isort", -- python formatter
    "black", -- python formatter
    "pylint", -- python linter
    "eslint_d", -- js linter
    "clang-format", -- C/C++ formatter
    "cmakelang", -- cmake formatter
    "goimports", -- golang formatter
    "rust-analyzer",
    "clangd",
    "cmake-language-server",
    "css-lsp",
    "emmet-ls",
    "gopls",
    "graphql-language-service-cli",
    "html-lsp",
    "prisma-language-server",
    "pyright",
    "svelte-language-server",
    "tailwindcss-language-server",
    "typescript-language-server",
    "docker-compose-language-service",
    "dockerfile-language-server",
    "sqlfmt",
    "sqls",
    "zls",
  }, -- not an option from mason.nvim

  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = "󰄳 ",
      package_uninstalled = " 󰚌",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}

return options
