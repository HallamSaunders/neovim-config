return {
  -- ======================================================================== --
  -- LSP CORE CONFIGURATION & INTERACTION                                     --
  -- ======================================================================== --
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    event = { "BufReadPre", "BufNewFile" },

    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
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
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        omnisharp = {
          settings = {
            FormattingOptions = { EnableEditorConfigSupport = true, OrganizeImports = true },
            RoslynExtensionsOptions = { EnableAnalyzersSupport = true, EnableImportCompletion = true },
            Sdk = { IncludePrereleases = true },
          },
        },
        ts_ls = {},
        marksman = {},
        bashls = {},
        yamlls = {},
        --gopls = {},
        texlab = {},
        svelte = {},
        html = {},
        cssls = {},
        jsonls = {},
        clangd = {},
        sqls = {},
      },
    },

    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local blink = require("blink.cmp")

      -- Unified Mason setup handler
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_filter(function(k)
          return k ~= "hls"
        end, vim.tbl_keys(opts.servers)),
        handlers = {
          function(server_name)
            local server_opts = opts.servers[server_name] or {}
            -- Inject natively from blink.cmp
            server_opts.capabilities = blink.get_lsp_capabilities(server_opts.capabilities)
            lspconfig[server_name].setup(server_opts)
          end,
        },
      })

      -- Manually set up hls, since we defer to the locally installed version
      vim.lsp.config('hls', {
        cmd = { "haskell-language-server-wrapper", "--lsp" },
        filetypes = { "haskell", "lhaskell" },
        root_markers = { "stack.yaml", "cabal.project", "*.cabal", "package.yaml" },
        capabilities = blink.get_lsp_capabilities(),
        settings = {
          haskell = {
            checkProject = true,
            checkOnSave = true,
            plugin = {
              ghcide = {
                diagnosticsOnFly = false,
              }
            },
            formattingProvider = "ormolu",
            cabalFormattingProvider = "cabalfmt",
          },
        },
      })
      vim.lsp.enable('hls')

      vim.o.updatetime = 250

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf

          vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            callback = function()
              vim.diagnostic.open_float(nil, { focusable = false })
            end,
          })

          local map = function(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, silent = true, desc = desc })
          end

          map("n", "gd", vim.lsp.buf.definition, "LSP: Go To Definition")
          map("n", "gI", vim.lsp.buf.implementation, "LSP: Go To Implementation")
          map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename Symbol")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
        end,
      })
    end,
  },

  -- ======================================================================== --
  -- PACKAGE EXTERNAL MANAGER (Mason Core)                                    --
  -- ======================================================================== --
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },

  -- ======================================================================== --
  -- CODE REFORMATTING ENGINE (Conform)                                       --
  -- ======================================================================== --
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    opts = {
      format_on_save = {
        timeout_ms = 5000,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        yml = { "prettier" },
        python = { "black" },
        tex = { "latexindent" },
        bib = { "latexindent" },
        go = { "gofmt" },
        rust = { "rustfmt" },
        svelte = { "prettier" },
        cs = { "csharpier" },
        haskell = { "ormolu" },
        cabal = { "cabalfmt" },
      },
    },
    init = function()
      vim.api.nvim_create_user_command("Format", function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end, { desc = "Format current buffer" })
    end,
  },

  -- ======================================================================== --
  -- AI CODE ASSISTANCE (GitHub Copilot)                                      --
  -- ======================================================================== --
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = false,
        keymap = {
          accept = "<C-J>",
          next = "<C-]>",
          prev = "<C-[>",
          dismiss = "<C-X>",
        },
      },
      panel = { enabled = true },
      filetypes = { ["*"] = true },
    },
    config = function(_, opts)
      require("copilot").setup(opts)

      local suggestion = require("copilot.suggestion")
      vim.keymap.set("i", "<C-S>", function()
        if suggestion.is_visible() then suggestion.dismiss() else suggestion.next() end
      end, { desc = "Manual Copilot trigger" })

      vim.keymap.set("i", "<C-f>", function() suggestion.accept_line() end, { desc = "Copilot accept line" })
      vim.keymap.set("i", "<C-L>", function() suggestion.accept_word() end, { desc = "Copilot accept word" })
    end,
  },

  -- ======================================================================== --
  -- DOCUMENT ENGINE & LaTeX COMPILER (Vimtex)                                --
  -- ======================================================================== --
  {
    "lervag/vimtex",
    ft = { "tex", "bib" },
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        out_dir = "build",
        options = { "-lualatex", "-shell-escape", "-synctex=1", "-verbose" },
      }
      vim.g.vimtex_compiler_start_immediately = 1

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex", "bib" },
        callback = function()
          vim.keymap.set("n", "<leader>cv", "<cmd>VimtexCompile<CR>", { buffer = true, desc = "Vimtex Compile" })
        end,
      })
    end,
  },
}
