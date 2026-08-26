return {
  -- ======================================================================== --
  -- COLOURSCHEME                                                             --
  -- ======================================================================== --
  { "catppuccin/nvim",        name = "catppuccin", lazy = false,   priority = 1000 },
  { "rebelot/kanagawa.nvim",  name = "kanagawa",   lazy = false,   priority = 1000 },
  { "sainnhe/everforest",     lazy = false,        priority = 1000 },
  { "EdenEast/nightfox.nvim", lazy = false,        priority = 1000 },
  { "folke/tokyonight.nvim",  lazy = false,        priority = 1000 },

  -- ======================================================================== --
  -- STATUS LINE (Lualine)                                                    --
  -- ======================================================================== --
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        section_separators = "",
        component_separators = "",
        --theme = 'everforest'
      },
    },
  },

  -- ======================================================================== --
  -- TREESITTER                                                               --
  -- ======================================================================== --
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = { "lua", "vim", "vimdoc", "python", "rust", "c_sharp",
        "haskell", "javascript", "typescript", "tsx", "svelte", "html", "css",
        "json", "yaml", "bash", "markdown", "markdown_inline", "sql", "regex" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -- ======================================================================== --
  -- COLOURIZER                                                               --
  -- ======================================================================== --
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      user_default_options = {
        RGB      = true,         -- #RGB hex codes
        RRGGBB   = true,         -- #RRGGBB hex codes
        names    = true,         -- "Blue" or "blue" colour names
        RRGGBBAA = true,         -- #RRGGBBAA hex codes
        css      = true,         -- Enable all CSS features
        tailwind = true,         -- Tailwind colour classes
        mode     = "background", -- "foreground", "background", or "virtualtext"
      },
    },
  },

  -- ======================================================================== --
  -- GIT INDICATION (Gitsigns)                                                --
  -- ======================================================================== --
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- Lazy load on file open
    opts = {},
  },

  -- ======================================================================== --
  -- INDENT GUIDES (Indent Blankline)                                         --
  -- ======================================================================== --
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- ======================================================================== --
  -- MARKDOWN ENHANCEMENT (Render Markdown)                                   --
  -- ======================================================================== --
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    opts = {},
  },

  -- ======================================================================== --
  -- TODO COMMENTS HIGHLIGHTER                                                --
  -- ======================================================================== --
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTrouble", "TodoTelescope", "TodoQuickFix" },
    event = "BufReadPost",
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next TODO comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous TODO comment" },
      { "<leader>xt", "<cmd>TodoTrouble<CR>",                              desc = "Todo (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<CR>",                            desc = "Todo (Telescope)" },
    },
    opts = {},
  },

  -- ======================================================================== --
  -- KEYBIND HINTS (Which-Key)                                                --
  -- ======================================================================== --
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Load when you actually start typing commands
    opts = {},
  },

  -- ======================================================================== --
  -- ICONS PROVIDER (Web Devicons)                                            --
  -- ======================================================================== --
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- ======================================================================== --
  -- MODERN CODE FOLDING (Nvim-Ufo)                                           --
  -- ======================================================================== --
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "zR", function() require("ufo").openAllFolds() end,  desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
      {
        "zp",
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then vim.lsp.buf.hover() end
        end,
        desc = "Preview fold or LSP hover"
      },
    },
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    opts = {
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
    },
  },
}
