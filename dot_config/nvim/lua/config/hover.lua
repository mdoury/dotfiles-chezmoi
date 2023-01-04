local hover = Safe 'hover'
hover.setup {
  init = function()
    Safe 'hover.providers.lsp'
  end,
}

vim.keymap.set('n', 'K', hover.hover, {
  desc = 'hover.nvim',
})
vim.keymap.set('n', 'gK', hover.hover_select, {
  desc = 'hover.nvim (select)',
})
