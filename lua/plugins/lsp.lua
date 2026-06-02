return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  lazy = false,
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
      hls = {
        settings = {
          haskell = {
            checkProject = true,
            formattingProvider = "ormolu",
            cabalFormattingProvider = "cabalfmt",
          },
        },
        cmd = { "haskell-language-server-wrapper", "--lsp" },
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
  -- 2. Init runs IMMEDIATELY on startup so vim.lsp.config has configurations ready
  init = function()
    -- Set up an automatic handler to attach capabilities to servers as they open
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        -- Show diagnostic in floating window on hover
        vim.o.updatetime = 250
        vim.api.nvim_create_autocmd("CursorHold", {
          buffer = args.buf,
          callback = function()
            vim.diagnostic.open_float(nil, { focusable = false })
          end,
        })

        -- Keymaps local to the active LSP buffer
        vim.keymap.set('n', 'K', vim.diagnostic.open_float, { buffer = args.buf, noremap = true, silent = true })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, noremap = true, silent = true })
      end,
    })
  end,
  config = function(_, opts)
    -- Fetch capabilities safely from nvim-cmp
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    for server, server_opts in pairs(opts.servers) do
      -- Inject cmp capabilities
      server_opts.capabilities = vim.tbl_deep_extend("force", server_opts.capabilities or {}, capabilities)

      -- Native Neovim 0.11+ configuration definitions
      vim.lsp.config(server, server_opts)
      vim.lsp.enable(server)
    end
  end,
}
