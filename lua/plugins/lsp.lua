return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    servers = {
      omnisharp = {
        settings = {
          FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
          },
          RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
          },
          Sdk = {
            IncludePrereleases = true,
          },
        },
      },
      pyright = {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
            }
          }
        }
      },
      ts_ls = {},
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            check = { command = "clippy" },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
          },
        },
      },
      -- Rest of your servers...
      marksman = {},
      bashls = {},
      yamlls = {},
      gopls = {},
      texlab = {},
      svelte = {},
    },
  },
  config = function(_, opts)
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    for server, server_opts in pairs(opts.servers) do
      server_opts.capabilities = capabilities
      vim.lsp.config[server] = server_opts
      vim.lsp.enable(server)
    end

    -- Show diagnostic in floating window
    vim.o.updatetime = 250
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
      end,
    })

    -- Keymaps
    vim.keymap.set('n', 'K', vim.diagnostic.open_float, { noremap = true, silent = true })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
  end,
}
