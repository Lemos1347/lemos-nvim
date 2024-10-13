local options = {
  ensure_installed = {
    "lua",
    "c",
    "cpp",
    "c_sharp",
    "cmake",
    "go",
    "json",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "html",
    "css",
    "prisma",
    "markdown",
    "markdown_inline",
    "svelte",
    "graphql",
    "bash",
    "vim",
    "dockerfile",
    "gitignore",
    "query",
    "rust",
    "python",
    "zig",
    "just",
    "nix",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
  },

  indent = { enable = true },

  autotag = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },

  utils = require("nvim-treesitter.ts_utils"),
}

return options
