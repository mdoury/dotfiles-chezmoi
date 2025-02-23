local packer = Safe 'setup.packer'

local function config(use)
  -- Plugin manager
  use 'wbthomason/packer.nvim'

  -- Plugin caching
  use 'lewis6991/impatient.nvim'

  -- Profiling
  use {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = [[vim.g.startuptime_tries = 15]],
  }

  -- Async building & commands
  use {
    'ojroques/nvim-bufdel',
    config = [[Safe 'config.bufdel']],
    cmd = 'BufDel',
  }

  -- Keymap assistant
  use {
    'folke/which-key.nvim',
    config = [[Safe 'config.keymaps']],
    event = 'User ActuallyEditing',
  }

  -- Motions
  use {
    {
      'chaoren/vim-wordmotion',
      event = 'User ActuallyEditing',
    },
    {
      'ggandor/leap.nvim',
      requires = 'tpope/vim-repeat',
      event = 'User ActuallyEditing',
    },
    {
      'ggandor/flit.nvim',
      config = [[Safe 'config.flit']],
      event = 'User ActuallyEditing',
    },
  }

  -- Commenting
  use {
    'numToStr/Comment.nvim',
    event = 'User ActuallyEditing',
    config = [[Safe 'config.comment']],
  }

  -- Wrapping/delimiters
  use {
    {
      'machakann/vim-sandwich',
      event = 'User ActuallyEditing',
    },
    {
      'andymass/vim-matchup',
      config = [[Safe 'config.matchup']],
      event = 'User ActuallyEditing',
    },
  }

  -- Search
  use { 'romainl/vim-cool', config = [[vim.g.cool_total_matches = 1]] }

  -- Undo tree
  use {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
  }

  -- Text objects
  use { 'wellle/targets.vim' }

  -- Utility functions
  use { 'nvim-lua/plenary.nvim' }

  -- Split navigation across vim and tmux
  use {
    'christoomey/vim-tmux-navigator',
    config = [[Safe 'config.tmux_navigator']],
  }

  -- Maximize current vim split
  use { 'szw/vim-maximizer', cmd = 'MaximizerToggle' }

  -- Paste without loosing the clipboard content with 'gr{motion}' and 'grr'
  use { 'inkarkat/vim-ReplaceWithRegister' }

  -- Filesystem tree
  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    setup = [[Safe 'setup.neotree']],
    config = [[Safe 'config.neotree']],
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      {
        's1n7ax/nvim-window-picker',
        tag = 'v1.*',
        config = [[Safe 'config.window_picker']],
        after = 'neo-tree.nvim',
      },
    },
    cmd = 'Neotree',
  }

  -- Syntax tree: highlighting, text objects, etc.
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      {
        'nvim-treesitter/nvim-treesitter-refactor',
        after = 'nvim-treesitter',
      },
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
      },
      {
        'RRethy/nvim-treesitter-textsubjects',
        after = 'nvim-treesitter',
      },
      {
        'lukas-reineke/indent-blankline.nvim',
        after = 'nvim-treesitter',
      },
      {
        'windwp/nvim-ts-autotag',
        after = 'nvim-treesitter',
      },
    },
    run = ':TSUpdate',
    event = 'User ActuallyEditing',
    config = [[Safe 'config.treesitter']],
  }

  -- Completion and linting
  use {
    { 'neovim/nvim-lspconfig' },
    {
      'folke/trouble.nvim',
      config = [[Safe 'config.trouble']],
      cmd = { 'Trouble', 'TroubleClose', 'TroubleToggle', 'TroubleRefresh' },
    },
    'ray-x/lsp_signature.nvim',
    {
      'kosayoda/nvim-lightbulb',
      requires = 'antoinemadec/FixCursorHold.nvim',
    },
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'onsails/lspkind.nvim' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'lukas-reineke/cmp-under-comparator' },
    },
    config = [[Safe 'config.cmp']],
    event = 'InsertEnter',
    wants = 'LuaSnip',
  }

  --	Pretty UI
  use { 'stevearc/dressing.nvim' }

  -- Colorscheme
  use { 'shaunsingh/nord.nvim' }

  -- Notifications
  use { 'rcarriga/nvim-notify' }

  -- TODO
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    event = 'BufReadPost',
    config = [[Safe 'config.todo_comments']],
  }

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true,
    },
  }

  -- Search
  use {
    {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzf-native.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
      },
      config = [[Safe 'config.telescope']],
      cmd = 'Telescope',
      module = 'telescope',
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
    'crispgm/telescope-heading.nvim',
  }

  use {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
  }
  use {
    'rafamadriz/friendly-snippets',
    event = 'InsertEnter',
  }

  use {
    'williamboman/mason.nvim',
    event = 'User ActuallyEditing',
    config = [[Safe 'config.mason']],
    requires = {
      { 'williamboman/mason-lspconfig.nvim', after = 'mason.nvim' },
      { 'jose-elias-alvarez/null-ls.nvim', after = 'mason.nvim' },
      { 'jayp0521/mason-null-ls.nvim', after = 'mason.nvim' },
    },
  }

  -- use {
  --   'glepnir/lspsaga.nvim',
  --   branch = 'main',
  --   config = function()
  --     local saga = Safe 'lspsaga'
  --     saga.init_lsp_saga {}
  --   end,
  -- }
  --
  use { 'jose-elias-alvarez/typescript.nvim' }

  use {
    'filipdutescu/renamer.nvim',
    branch = 'master',
    requires = { { 'nvim-lua/plenary.nvim' } },
    module = 'renamer',
    event = 'User ActuallyEditing',
  }

  use {
    'windwp/nvim-autopairs',
    config = [[Safe 'config.autopairs']],
    event = 'User ActuallyEditing',
  }

  -- Git
  use {
    {
      'lewis6991/gitsigns.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = [[Safe('config.gitsigns')]],
      event = 'User ActuallyEditing',
    },
    {
      'TimUntersberger/neogit',
      cmd = 'Neogit',
      config = [[Safe('config.neogit')]],
      requires = {
        { 'nvim-lua/plenary.nvim' },
        {
          'sindrets/diffview.nvim',
          after = 'neogit',
          opt = true,
        },
      },
    },
    {
      'akinsho/git-conflict.nvim',
      tag = '*',
      config = [[Safe 'config.git_conflict']],
      event = 'BufReadPost',
    },
  }

  -- Hovers
  use {
    'lewis6991/hover.nvim',
    event = 'BufReadPost',
    config = [[Safe 'config.hover']],
  }
  use {
    'DNLHC/glance.nvim',
    cmd = 'Glance',
    config = [[Safe 'config.glance']],
  }

  if packer.bootstrap then
    packer.sync()
  end
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    config(packer.use)
    return packer[key]
  end,
})

return plugins
