return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    servers = {
      pyright = {},
      ts_ls = {},
      rust_analyzer = {},
      marksman = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      },
      bashls = {},
      yamlls = {},
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
          },
        },
      },
      texlab = {
        settings = {
          texlab = {
            build = {
              executable = "latexmk",
              args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-outdir=%OUTDIR%", "%INPUT%" },
              onSave = true,
            },
            forwardSearch = {
              executable = "zathura",
              args = { "--synctex-forward", "%l:1:%f", "%p" },
            },
          }
        }
      }
    },
  },
  config = function(_, opts)
    -- Register configs
    local server_configs = {}
    for server, server_opts in pairs(opts.servers) do
      server_configs[server] = vim.lsp.config(server, server_opts)
    end

    -- Autostart LSP when opening matching files
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
      callback = function(args)
        local buffer = args.buf
        local filetype = vim.bo[buffer].filetype
        for _, config in pairs(server_configs) do
          if config.filetypes == nil or vim.tbl_contains(config.filetypes, filetype) then
            vim.lsp.start(config, { bufnr = buffer })
          end
        end
      end,
    })

    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.py", "*.js", "*.ts", "*.tsx", "*.jsx", "*.rs", "*.md", "*.lua", "*.sh", "*.yaml", "*.tex", "*.yml", "*.html", "*.css", "*.json", "*.go" },
      callback = function()
        vim.lsp.buf.format({ async = true })
      end,
    })

    -- Show diagnostic in floating window with 250ms hold
    vim.o.updatetime = 250
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
      end,
    })

    -- Keymaps
    vim.keymap.set('n', 'K', vim.diagnostic.open_float, { noremap = true, silent = true })
  end,
}
