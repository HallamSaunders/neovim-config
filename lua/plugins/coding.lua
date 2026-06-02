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
        -- '<C-space>' to invoke completion
        -- '<CR>' (Enter) to accept completion if selected
        -- '<Tab>' and '<S-Tab>' to navigate menu / jump snippets
      },

      -- Built-in sources
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- Built-in completion documentation and signatures
      completion = {
        menu = { border = "rounded" },
        documentation = { auto_show = true, window = { border = "rounded" } },
      },

      signature = { enabled = true, window = { border = "rounded" } },
    },
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
}
