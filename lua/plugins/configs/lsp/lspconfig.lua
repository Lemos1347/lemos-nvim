dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp")

local M = {}
local utils = require("core.utils")

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local lspconfig = require("lspconfig")

-- configure html server
lspconfig.html.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

-- configure typescript server with plugin
lspconfig.tsserver.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

lspconfig.lua_ls.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          [vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      hint = { enable = true },
    },
  },
})

-- configure css server
lspconfig.cssls.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
})

-- configure tailwindcss server
lspconfig.tailwindcss.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
})

-- configure svelte server
lspconfig.svelte.setup({
  capabilities = M.capabilities,
  on_attach = function(client, bufnr)
    M.on_attach(client, bufnr)

    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.js", "*.ts" },
      callback = function(ctx)
        if client.name == "svelte" then
          client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
        end
      end,
    })
  end,
})

-- configure prisma orm server
lspconfig.prismals.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
})

-- configure graphql language server
lspconfig.graphql.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
})

-- configure emmet language server
lspconfig.emmet_ls.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- configure python server
lspconfig.pyright.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  before_init = function(_, config)
    if vim.env.VIRTUAL_ENV then
      config.settings.python.pythonPath = vim.env.VIRTUAL_ENV .. "/bin/python"
    end
  end,
})

-- configure rust analyzer with rust_tools
-- local rust_tools_opts = {
--   tools = {
--     runnables = {
--       use_telescope = true,
--     },
--     inlay_hints = {
--       auto = true,
--       show_parameter_hints = false,
--       parameter_hints_prefix = "",
--       other_hints_prefix = "",
--     },
--   },
--
--   -- all the opts to send to nvim-lspconfig
--   -- these override the defaults set by rust-tools.nvim
--   -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
--   server = {
--     -- on_attach is a callback called when the language server attachs to the buffer
--     on_attach = M.on_attach,
--     settings = {
--       -- to enable rust-analyzer settings visit:
--       -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
--       ["rust-analyzer"] = {
--         completition = {
--           dynamicRegistration = true,
--         },
--         imports = {
--           granularity = {
--             group = "module",
--           },
--           prefix = "self",
--         },
--         cargo = {
--           buildScripts = {
--             enable = true,
--           },
--         },
--         procMacro = {
--           enable = true,
--         },
--         -- enable clippy on save
--         checkOnSave = {
--           command = "clippy",
--         },
--       },
--     },
--   },
-- }
-- --
-- require("rust-tools").setup(rust_tools_opts)

lspconfig.rust_analyzer.setup({
  on_attach = M.on_attach,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
      },
      cachePriming = {
        enable = true,
      },
      completition = {
        dynamicRegistration = true,
      },
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        bindingModeHints = { enable = true },
        closureCaptureHints = { enable = true },
        closureReturnTypeHints = { enable = "always" },
        lifetimeElisionHints = { enable = "always", useParameterNames = true },
        rangeExclusiveHints = { enable = true },
        typeHints = { hideClosureInitialization = true },
      },
    },
  },
})

--configure golps
lspconfig.gopls.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  settings = {
    gopls = {
      buildFlags = { "-tags=wireinject" },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

--configure cmake
lspconfig.cmake.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
})

--configure clangd for C and C++
lspconfig.clangd.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
})

--configure for docker-compose e Dockerfile
lspconfig.docker_compose_language_service.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  filetypes = { "yaml, yml" },
})
lspconfig.dockerls.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  filetypes = { "Dockerfile, dockerfile" },
})

--configure for sql files
lspconfig.sqls.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
})

--configure for zig files
lspconfig.zls.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
})

--configure for nix files
lspconfig.nil_ls.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
})

return M
