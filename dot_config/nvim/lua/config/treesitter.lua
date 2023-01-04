Safe('nvim-treesitter.configs').setup {
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  auto_tag = { enable = true },
  refactor = {
    smart_rename = { enable = true, keymaps = { smart_rename = '<leader>rn' } },
    highlight_definitions = { enable = true },
  },
  ensure_installed = {
    'json',
    'javascript',
    'typescript',
    'tsx',
    'yaml',
    'html',
    'css',
    'markdown',
    'svelte',
    'graphql',
    'bash',
    'lua',
    'vim',
    'dockerfile',
    'gitignore',
		'git_rebase',
  },
  textsubjects = {
    enable = true,
    lookahead = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
      },
    },
  },
  endwise = { enable = true },
}
