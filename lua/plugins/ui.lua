return {
  -- ======================================================================== --
  -- COLOURSCHEME (Catppuccin)                                                --
  -- ======================================================================== --
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Ensures it loads first
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          indent_blankline = { enabled = true },
          nvimtree = true,
          telescope = true,
          treesitter = true,
          which_key = true,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
        },
        custom_highlights = function(colors)
          return {
            NormalFloat = { bg = colors.base },                    -- popup background
            FloatBorder = { fg = colors.surface2 },                -- border color
            Pmenu = { bg = colors.mantle, fg = colors.text },      -- cmp menu
            PmenuSel = { bg = colors.surface1, fg = colors.text }, -- selected item
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

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
