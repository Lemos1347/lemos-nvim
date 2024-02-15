local conform = require "conform"

local utils = require "core.utils"

utils.load_mappings "formatting"

conform.setup {
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    svelte = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    graphql = { "prettier" },
    lua = { "stylua" },
    python = { "isort", "black" },
    rust = { "rustfmt" },
    go = { "goimports" },
    cmake = { "cmakelang" },
    c = { "clang-format" },
    cpp = { "clang-format" },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  },
}
