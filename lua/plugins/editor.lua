return {
  -- ======================================================================== --
  -- VISUAL TABS (Bufferline)                                                 --
  -- ======================================================================== --
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
      { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>",      "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<leader>bp", "<cmd>BufferLinePick<cr>",      desc = "Buffer Pick" },
      { "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Buffer Pick Close" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp", -- Show LSP error badges directly on tabs
        always_show_bufferline = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
            separator = true,
          },
        },
      },
    },
  },

  -- ======================================================================== --
  -- FILE TREE SIDEBAR (Nvim-Tree)                                            --
  -- ======================================================================== --
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>de", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
    },
    opts = {
      filters = { dotfiles = false },
      view = {
        width = { min = 30, max = -1, padding = 1 },
        preserve_window_proportions = true,
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)

      -- Disable side scrolling specific to the explorer window
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "NvimTree",
        callback = function()
          vim.opt_local.wrap = false
          vim.opt_local.sidescroll = 0
          vim.opt_local.sidescrolloff = 0
        end,
      })
    end,
  },

  -- ======================================================================== --
  -- IN-BUFFER FILE EXPLORER (Oil.nvim)                                       --
  -- ======================================================================== --
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
    },
    opts = {
      view_options = { show_hidden = true },
    },
  },

  -- ======================================================================== --
  -- FUZZY FINDER (Telescope)                                                 --
  -- ======================================================================== --
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live Grep" },
    },
    opts = {},
  },

  -- ======================================================================== --
  -- DIAGNOSTICS & SYMBOLS PANELS (Trouble.nvim)                              --
  -- ======================================================================== --
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols/Outline (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Items (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
    },
    opts = {},
  },
}
