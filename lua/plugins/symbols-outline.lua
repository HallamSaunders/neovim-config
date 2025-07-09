return {
  'simrat39/symbols-outline.nvim',
  cmd = 'SymbolsOutline',
  keys = {
    { '<leader>so', '<cmd>SymbolsOutline<CR>', desc = 'Symbols Outline' }
  },
  config = function()
    require('symbols-outline').setup()
  end
}
