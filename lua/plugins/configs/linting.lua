local lint = require("lint")

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  svelte = { "eslint_d" },
  -- python = { "pylint" },
}

local function has_eslint_config()
  -- Verifica a presença de um arquivo de configuração do ESLint no diretório atual ou em qualquer diretório pai
  local eslint_config_files = { ".eslintrc.js", ".eslintrc.json", ".eslintrc" }
  local pathlib = require("plenary.path")
  for _, filename in ipairs(eslint_config_files) do
    local config_path = pathlib:new(filename)
    if config_path:exists() then
      return true
    end
  end
  return false
end

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    if has_eslint_config() or vim.bo.filetype ~= "javascript" then
      lint.try_lint()
    end
  end,
})

require("core.utils").load_mappings("linting")

-- local lint = require("lint")
--
-- lint.linters_by_ft = {
--   -- javascript = { "eslint_d" },
--   -- typescript = { "eslint_d" },
--   -- javascriptreact = { "eslint_d" },
--   -- typescriptreact = { "eslint_d" },
--   svelte = { "eslint_d" },
--   -- python = { "pylint" },
-- }
--
-- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
--
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
--   group = lint_augroup,
--   callback = function()
--     lint.try_lint()
--   end,
-- })
--
-- require("core.utils").load_mappings("linting")
