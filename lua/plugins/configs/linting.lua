local lint = require("lint")

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  svelte = { "eslint_d" },
  python = { "pylint" },
}

local config_files_by_ft = {
  javascript = { ".eslintrc.js", ".eslintrc.json", ".eslintrc" },
  typescript = { ".eslintrc.js", ".eslintrc.json", ".eslintrc" },
  javascriptreact = { ".eslintrc.js", ".eslintrc.json", ".eslintrc" },
  typescriptreact = { ".eslintrc.js", ".eslintrc.json", ".eslintrc" },
  svelte = { ".eslintrc.js", ".eslintrc.json", ".eslintrc" },
  python = { ".pylintrc", "pyproject.toml" },
  -- Adicione mais tipos de arquivo e seus respectivos arquivos de configuração aqui.
}

local function has_lint_config(filetype)
  local config_files = config_files_by_ft[filetype]
  if not config_files then
    return false
  end

  local pathlib = require("plenary.path")
  for _, filename in ipairs(config_files) do
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
    local filetype = vim.bo.filetype
    if has_lint_config(filetype) then
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
