return {
  -- ======================================================================== --
  -- AUTOCMP ENGINE (blink.cmp)                                               --
  -- ======================================================================== --
  {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter", -- Only load when typing starts

    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"] = { "accept", "fallback" },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      completion = {
        menu = { border = "rounded" },
        documentation = { auto_show = true, window = { border = "rounded" } },
      },

      signature = { enabled = true, window = { border = "rounded" } },
    },
  },

  {
    "rafamadriz/friendly-snippets",
    lazy = false,
  },

  -- ======================================================================== --
  -- AUTOMATIC PAIRS (Autopairs)                                              --
  -- ======================================================================== --
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- ======================================================================== --
  -- SURROUND OPERATORS (Nvim-Surround)                                       --
  -- ======================================================================== --
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- ======================================================================== --
  -- MULTI-CURSOR SUPPORT (Vim-Visual-Multi)                                  --
  -- ======================================================================== --
  {
    "mg979/vim-visual-multi",
    branch = "master",
    -- Load at startup since it maps global keys like Ctrl-N
    lazy = false,
  },

  -- ======================================================================== --
  -- CURSOR WORD HIGHLIGHT                                                     --
  -- ======================================================================== --
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 100,
      large_file_cutoff = 2000,
      providers = { "lsp", "treesitter", "regex" },
      filetypes_denylist = { "NvimTree", "oil", "trouble", "lazy", "mason", "help", "dashboard" },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
}
