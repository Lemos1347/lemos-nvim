local conform = require("conform")

local utils = require("core.utils")

utils.load_mappings("formatting")

conform.setup({
  formatters_by_ft = {
    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    svelte = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    yaml = { "prettierd", "prettier" },
    markdown = { "prettierd", "prettier" },
    graphql = { "prettierd", "prettier" },
    lua = { "stylua" },
    python = { "isort", "black" },
    rust = { "rustfmt" },
    go = { "goimports" },
    cmake = { "cmakelang" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    -- sql = { "sql-formatter" },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  },
})
