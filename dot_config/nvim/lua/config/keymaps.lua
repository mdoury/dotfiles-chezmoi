-- Leader/local leader
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]

local wk = Safe 'which-key'
wk.register({
  name = 'Find',
  f = { '<cmd>Telescope find_files theme=get_dropdown<cr>', 'Find File By Name' },
  r = { '<cmd>Telescope oldfiles theme=get_dropdown<cr>', 'Find Recent File' },
  c = { '<cmd>Telescope commands theme=get_dropdown<cr>', 'Find Command' },
  b = { '<cmd>Telescope buffers show_all_buffers=true theme=get_dropdown<cr>', 'Find Buffer' },
  s = { '<cmd>Telescope git_files theme=get_dropdown<cr>', 'Find Git File' },
  g = { '<cmd>Telescope live_grep theme=get_dropdown<cr>', 'Find File By Content' },
}, {
  prefix = '<leader>f',
})

wk.register({
  name = 'Back To Normal',
  ['jk'] = { '<esc>', 'Exit Insert Mode' },
  ['kj'] = { '<esc>', 'Exit Insert Mode' },
}, {
  mode = 'i',
})

wk.register({
  name = 'Back To Normal',
  jk = { '<esc>', 'Exit Visual Mode' },
  kj = { '<esc>', 'Exit Visual Mode' },
}, {
  mode = 'v',
})

wk.register({
  name = 'Close',
  q = { '<cmd>qa<cr>', 'Quit' },
  x = { '<cmd>x!<cr>', 'Save And Quit' },
  d = {
    '<cmd>BufDel<cr>',
    'Delete Buffer',
    nowait = true,
  },
}, {
  prefix = '<leader>',
})

wk.register({
  name = 'Git',
  s = { '<cmd>Neogit<cr>', 'Open Neogit' },
}, {
  prefix = '<leader>g',
})

wk.register({
  name = 'Save',
  ['<c-s>'] = { '<esc><cmd>w<cr>a', 'Save File' },
}, {
  mode = 'i',
})

wk.register {
  name = 'Save',
  ['<leader>s'] = { '<cmd>w<cr>', 'Save' },
  ['<c-s>'] = { '<cmd>w<cr>', 'Save' },
}

wk.register {
  name = 'Tree',
  ['\\'] = { '<cmd>Neotree toggle<cr>', 'Toggle Neotree' },
}

wk.register({
  name = 'Copy/Paste',
  y = { '"+y', 'Yank to clipboard' },
  Y = { '"+y', 'Yank to clipboard' },
  yy = { '"+y', 'Yank to clipboard' },
  p = { '"+p', 'Paste After' },
  P = { '"+P', 'Paste Before' },
}, {
  prefix = '<leader>',
})

wk.register({
  name = 'Copy/Paste',
  y = { '"+y', 'Yank to clipboard' },
  p = { '"+p', 'Paste After' },
  P = { '"+P', 'Paste Before' },
}, {
  mode = 'v',
  prefix = '<leader>',
})

wk.register {
  name = 'Windows',
  ['<c-h>'] = { '<c-w>h', 'Move to left window' },
  ['<c-j>'] = { '<c-w>j', 'Move to bottom window' },
  ['<c-k>'] = { '<c-w>k', 'Move to top window' },
  ['<c-l>'] = { '<c-w>l', 'Move to right window' },
  ['<leader>s'] = {
    h = { '<c-w>n', 'New Horizontal Split' },
    v = { '<c-w>v', 'New Vertical Split' },
    e = { '<c-w>=', 'Reset Splits' },
    w = { '<c-w>c', 'Close Current Split' },
    m = { '<cmd>MaximizerToggle<cr>', 'Maximize Current Split'}
  },
}

wk.register({
  name = 'Tabs',
  t = { ':tabnew<cr>', 'New Tab' },
  w = { ':tabclose<cr>', 'Close Tab' },
  n = { ':tabn<cr>', 'Next Tab' },
  p = { ':tabp<cr>', 'Previous Tab' },
}, {
  prefix = '<leader>t',
})
