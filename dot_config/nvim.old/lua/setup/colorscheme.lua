-- Colorscheme
vim.opt.termguicolors = true
vim.opt.background = 'dark'

vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = false

-- Load the colorscheme
require('nord').set()
