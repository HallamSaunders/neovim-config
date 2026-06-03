-- ========================================================================== --
--                                 SETTINGS                                   --
-- ========================================================================== --

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Interface and numbers
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.scrolloff = 8         -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8     -- Keep 8 columns left/right of cursor
vim.opt.termguicolors = true  -- Enable 24-bit RGB colors

-- Tabs and indentation
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftwidth = 2     -- Shift 2 spaces when tab
vim.opt.tabstop = 2        -- 1 tab == 2 spaces
vim.opt.smartindent = true -- Autoindent new lines

-- Line wrapping
vim.opt.wrap = true        -- Wrap long lines
vim.opt.linebreak = true   -- Wrap at word boundaries
vim.opt.breakindent = true -- Indent wrapped lines

-- ========================================================================== --
--                                 KEYMAPS                                    --
-- ========================================================================== --

-- General Keymaps
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = "Save file" })
vim.keymap.set('i', 'nml', '<Esc>', { desc = "Exit insert mode" })

-- -------------------------------------------------------------------------- --
-- Mouse & Arrow Keys Hardcore Toggle                                         --
-- -------------------------------------------------------------------------- --
vim.opt.mouse = ""
local arrows = { "<Up>", "<Down>", "<Left>", "<Right>" }
local modes = { "n", "i", "v" }

-- Disable arrows on startup
for _, mode in ipairs(modes) do
  for _, arrow in ipairs(arrows) do
    vim.keymap.set(mode, arrow, "<Nop>", { silent = true })
  end
end

-- State trackers
local arrows_disabled = true
local mouse_disabled = true

-- Helper functions
local function disable_arrows()
  for _, mode in ipairs(modes) do
    for _, arrow in ipairs(arrows) do
      vim.keymap.set(mode, arrow, "<Nop>", { silent = true })
    end
  end
end

local function enable_arrows()
  for _, mode in ipairs(modes) do
    for _, arrow in ipairs(arrows) do
      pcall(vim.keymap.del, mode, arrow)
    end
  end
end

-- Toggle arrow keys
vim.keymap.set("n", "<leader>ta", function()
  arrows_disabled = not arrows_disabled
  if arrows_disabled then
    disable_arrows()
    vim.notify("Arrows DISABLED", vim.log.levels.WARN)
  else
    enable_arrows()
    vim.notify("Arrows ENABLED", vim.log.levels.INFO)
  end
end, { desc = "Toggle Arrow Keys" })

-- Toggle mouse
vim.keymap.set("n", "<leader>tm", function()
  mouse_disabled = not mouse_disabled
  if mouse_disabled then
    vim.opt.mouse = ""
    vim.notify("Mouse DISABLED", vim.log.levels.WARN)
  else
    vim.opt.mouse = "a"
    vim.notify("Mouse ENABLED", vim.log.levels.INFO)
  end
end, { desc = "Toggle Mouse" })

-- Toggle hardcore mode (both at once)
vim.keymap.set("n", "<leader>th", function()
  -- If either is enabled, disable both; if both disabled, enable both
  local any_enabled = not arrows_disabled or not mouse_disabled
  if any_enabled then
    arrows_disabled = true
    mouse_disabled = true
    disable_arrows()
    vim.opt.mouse = ""
    vim.notify("Hardcore mode ON: Mouse & Arrows DISABLED", vim.log.levels.WARN)
  else
    arrows_disabled = false
    mouse_disabled = false
    enable_arrows()
    vim.opt.mouse = "a"
    vim.notify("Hardcore mode OFF: Mouse & Arrows ENABLED", vim.log.levels.INFO)
  end
end, { desc = "Toggle Hardcore Mode (Mouse & Arrows)" })

-- ========================================================================== --
--                               AUTOCMDS                                     --
-- ========================================================================== --

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Spell checking for text-based filetypes
autocmd("FileType", {
  group = augroup("SpellCheck", { clear = true }),
  pattern = { "txt", "md", "tex" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_gb"
  end,
})

-- LSP-only keymaps (only map these when an LSP actually attaches to a buffer)
autocmd("LspAttach", {
  group = augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    opts.desc = "LSP: Signature help"
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

    opts.desc = "LSP: Hover documentation"
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  end,
})

-- ========================================================================== --
--                            PLUGIN MANAGER                                  --
-- ========================================================================== --

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim to look inside lua/plugins/
require("lazy").setup("plugins", {
  concurrency = 5,
  change_detection = { notify = false }, -- Stop popups when config changed
})

-- ========================================================================== --
--                             THEME MANAGER                                  --
-- ========================================================================== --

require("config.theme").load_saved()

vim.keymap.set("n", "<leader>tt", function()
  require("config.theme").pick()
end, { desc = "Theme Switcher" })
vim.keymap.set("n", "<leader>tn", function() require("config.theme").next() end, { desc = "Next Theme" })
vim.keymap.set("n", "<leader>tp", function() require("config.theme").prev() end, { desc = "Prev Theme" })
