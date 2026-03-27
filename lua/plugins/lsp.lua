return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      servers = {
        lua_ls = {},
        html = {},
        cssls = {},
        tailwindcss = {},
        svelte = {},
        prismals = {},
        cmake = {},
        zls = {},
        nil_ls = {},
        dockerls = {},
        docker_compose_language_service = {},

        ts_ls = {
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
        },

        graphql = {
          filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        },

        emmet_ls = {
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        },

        pyright = {
          before_init = function(_, config)
            if vim.env.VIRTUAL_ENV then
              config.settings = config.settings or {}
              config.settings.python = config.settings.python or {}
              config.settings.python.pythonPath = vim.env.VIRTUAL_ENV .. "/bin/python"
              config.settings.python.venvPath = vim.fn.fnamemodify(vim.env.VIRTUAL_ENV, ":h")
              config.settings.python.venv = vim.fn.fnamemodify(vim.env.VIRTUAL_ENV, ":t")
            end
          end,
        },

        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              diagnostics = { enable = true },
              cachePriming = { enable = true },
              imports = {
                granularity = { group = "module" },
                prefix = "self",
              },
              cargo = {
                buildScripts = { enable = true },
              },
              procMacro = { enable = true },
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
        },

        gopls = {
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
        },

        clangd = {
          cmd = {
            "clangd",
            "--background-index",
          },
        },

        elixirls = {
          settings = {
            elixirLS = {
              dialyzerEnabled = false,
              fetchDeps = false,
              suggestSpecs = true,
            },
          },
        },
      },
    },
  },
}
