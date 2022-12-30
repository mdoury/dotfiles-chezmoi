-- Autocommands
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
autocmd('VimEnter', {
  group = augroup('start_screen', {
    clear = true,
  }),
  once = true,
  callback = function()
    Safe('start').start()
  end,
})
local misc_aucmds = augroup('misc_aucmds', {
  clear = true,
})
autocmd('BufWinEnter', {
  group = misc_aucmds,
  command = 'checktime',
})
autocmd('TextYankPost', {
  group = misc_aucmds,
  callback = function()
    vim.highlight.on_yank()
  end,
})
autocmd('FileType', { group = misc_aucmds, pattern = 'qf', command = 'set nobuflisted' })
vim.cmd [[silent! autocmd! FileExplorer *]]

autocmd('BufReadPost', {
  group = misc_aucmds,
  once = true,
  callback = function()
    Safe 'config.lsp'
  end,
})

-- autocmd('BufReadPre', {
--   group = misc_aucmds,
--   callback = function()
--     if
--       vim.api.nvim_buf_get_option(0, 'modifiable')
--       and vim.api.nvim_buf_get_option(0, 'filetype') ~= 'startify'
--       and vim.api.nvim_buf_get_option(0, 'filetype') ~= 'TelescopePrompt'
--     then
--       vim.cmd [[ doautocmd User ActuallyEditing ]]
--       vim.notify ' Let\'s go!!!!'
--       return true
--     end
--   end,
-- })
