local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
local packer = nil
local function init()
  if packer == nil then
    packer = Safe 'packer'
    packer.init {
      profile = {
        enable = true,
      },
      disable_commands = true,
      display = {
        open_fn = function()
          local result, win, buf = Safe('packer.util').float {
            border = {
              { '╭', 'FloatBorder' },
              { '─', 'FloatBorder' },
              { '╮', 'FloatBorder' },
              { '│', 'FloatBorder' },
              { '╯', 'FloatBorder' },
              { '─', 'FloatBorder' },
              { '╰', 'FloatBorder' },
              { '│', 'FloatBorder' },
            },
          }
          vim.api.nvim_win_set_option(win, 'winhighlight', 'NormalFloat:Normal')
          return result, win, buf
        end,
      },
    }
  end

  local use = packer.use
  packer.reset()

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
    cmd = 'BufDel',
    config = function()
      Safe('bufdel').setup {
        quit = false,
      }
    end,
  }

  -- Keymap assistant
  use {
    'folke/which-key.nvim',
    config = function()
      Safe('which-key').setup {}
      Safe 'config.keymaps'
    end,
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
      event = 'User ActuallyEditing',
      requires = 'tpope/vim-repeat',
    },
    {
      'ggandor/flit.nvim',
      config = function()
        Safe('flit').setup {
          labeled_modes = 'nv',
        }
      end,
      event = 'User ActuallyEditing',
    },
  }

  -- Indentation tracking
  use {
    'lukas-reineke/indent-blankline.nvim',
    after = 'nvim-treesitter',
  }

  -- Commenting
  -- use('tomtom/tcomment_vim')
  use {
    'numToStr/Comment.nvim',
    event = 'User ActuallyEditing',
    config = function()
      Safe('Comment').setup {}
    end,
  }

  -- Wrapping/delimiters
  use {
    {
      'machakann/vim-sandwich',
      event = 'User ActuallyEditing',
    },
    {
      'andymass/vim-matchup',
      config = function()
        Safe 'config.matchup'
      end,
      event = 'User ActuallyEditing',
    },
  }

  -- Search
  use { 'romainl/vim-cool' }

  -- Prettification
  use {
    'junegunn/vim-easy-align',
    disable = true,
  }

  -- Undo tree
  use {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  }

  -- Text objects
  use { 'wellle/targets.vim' }

  use { 'nvim-lua/plenary.nvim' }

  -- Window management
  use {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_save_on_switch = 2
			vim.g.tmux_navigator_preserve_zoom = 1
    end,
  }
  use { 'szw/vim-maximizer', cmd = 'MaximizerToggle' }

  -- use { 'inkarkat/vim-ReplaceWithRegister' }

  -- Path navigation
  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    setup = function()
      vim.keymap.set('n', '\\', '<cmd>Neotree toggle<cr>', {
        desc = 'Toggle Neotree',
      })

      -- local wk = Safe 'which-key'
      -- wk.register({
      --   ['\\'] = { '<cmd>Neotree toggle<cr>', 'Toggle Filesystem Tree' },
      -- }, { prefix = '' })
    end,
    config = function()
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      local sign_define = vim.fn.sign_define
      sign_define('DiagnosticSignError', {
        text = ' ',
        texthl = 'DiagnosticSignError',
      })
      sign_define('DiagnosticSignWarn', {
        text = ' ',
        texthl = 'DiagnosticSignWarn',
      })
      sign_define('DiagnosticSignInfo', {
        text = ' ',
        texthl = 'DiagnosticSignInfo',
      })
      sign_define('DiagnosticSignHint', {
        text = '',
        texthl = 'DiagnosticSignHint',
      })

      Safe('neo-tree').setup {
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = 'rounded',
        window = {
          position = 'left',
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ['<space>'] = {
              'toggle_node',
              nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ['<2-LeftMouse>'] = 'open',
            ['<cr>'] = 'open',
            ['<esc>'] = 'revert_preview',
            ['P'] = {
              'toggle_preview',
              config = {
                use_float = true,
              },
            },
            ['S'] = 'open_split',
            ['s'] = 'open_vsplit',
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ['t'] = 'open_tabnew',
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ['w'] = 'open_with_window_picker',
            -- ["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ['C'] = 'close_node',
            ['z'] = 'close_all_nodes',
            -- ["Z"] = "expand_all_nodes",
            ['a'] = {
              'add',
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = 'none', -- "none", "relative", "absolute"
              },
            },
            ['A'] = 'add_directory', -- also accepts the optional config.show_path option like "add".
            ['d'] = 'delete',
            ['r'] = 'rename',
            ['y'] = 'copy_to_clipboard',
            ['x'] = 'cut_to_clipboard',
            ['p'] = 'paste_from_clipboard',
            ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            -- }
            ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ['q'] = 'close_window',
            ['R'] = 'refresh',
            ['?'] = 'show_help',
            ['<'] = 'prev_source',
            ['>'] = 'next_source',
          },
        },
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false, -- only works on Windows for hidden files/directories
          },
          follow_current_file = true, -- This will find and focus the file in the active buffer every
          -- time the current file is changed while the tree is open.
          window = {
            mappings = {
              ['<bs>'] = 'navigate_up',
              ['.'] = 'set_root',
              ['H'] = 'toggle_hidden',
              ['/'] = 'fuzzy_finder',
              ['D'] = 'fuzzy_finder_directory',
              ['f'] = 'filter_on_submit',
              ['<c-x>'] = 'clear_filter',
              ['[g'] = 'prev_git_modified',
              [']g'] = 'next_git_modified',
            },
          },
        },
        buffers = {
          window = {
            mappings = {
              ['bd'] = 'buffer_delete',
              ['<bs>'] = 'navigate_up',
              ['.'] = 'set_root',
            },
          },
        },
        git_status = {
          window = {
            position = 'float',
            mappings = {
              ['A'] = 'git_add_all',
              ['gu'] = 'git_unstage_file',
              ['ga'] = 'git_add_file',
              ['gr'] = 'git_revert_file',
              ['gc'] = 'git_commit',
              ['gp'] = 'git_push',
              ['gg'] = 'git_commit_and_push',
            },
          },
        },
      }
    end,
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- {
      --   -- only needed if you want to use the commands with "_with_window_picker" suffix
      --   's1n7ax/nvim-window-picker',
      --   tag = 'v1.*',
      --   config = function()
      --     Safe('window-picker').setup {
      --       autoselect_one = true,
      --       include_current = false,
      --       filter_rules = {
      --         -- filter using buffer options
      --         bo = {
      --           -- if the file type is one of following, the window will be ignored
      --           filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
      --
      --           -- if the buffer type is one of following, the window will be ignored
      --           buftype = { 'terminal', 'quickfix' },
      --         },
      --       },
      --       other_win_hl_color = '#e35e4f',
      --     }
      --   end,
      --   after = 'neo-tree.nvim',
      -- },
    },
    cmd = 'Neotree',
  }

  -- Highlights
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      {
        'nvim-treesitter/nvim-treesitter-refactor',
        after = 'nvim-treesitter',
      },
      {
        'RRethy/nvim-treesitter-textsubjects',
        after = 'nvim-treesitter',
      },
    },
    run = function()
      local ts_update = Safe('nvim-treesitter.install').update {
        with_sync = true,
      }
      ts_update()
    end,
    event = 'User ActuallyEditing',
    config = [[Safe 'config.treesitter']],
  }

  -- Completion and linting
  use {
    { 'neovim/nvim-lspconfig' },
    {
      'folke/trouble.nvim',
      cmd = { 'Trouble', 'TroubleClose', 'TroubleToggle', 'TroubleRefresh' },
      config = function()
        Safe('trouble').setup {}
      end,
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
      'hrsh7th/cmp-nvim-lsp',
      'onsails/lspkind.nvim',
      { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      'lukas-reineke/cmp-under-comparator',
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
    },
    config = [[require('config.cmp')]],
    event = 'InsertEnter',
    wants = 'LuaSnip',
  }

  -- Colorscheme
  use { 'arcticicestudio/nord-vim', event = 'User ActuallyEditing' }

  -- Pretty UI
  use 'stevearc/dressing.nvim'
  use 'rcarriga/nvim-notify'
  use 'vigoux/notifier.nvim'
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    event = 'BufReadPost',
    config = function()
      Safe('todo-comments').setup {}
    end,
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
      config = function()
        Safe 'config.telescope'
      end,
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
    config = function()
      Safe 'config.mason'
    end,
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
    config = function()
      Safe('nvim-autopairs').setup {
        check_ts = true, -- enable treesitter
        ts_config = {
          lua = { 'string' }, -- don't add pairs in lua string treesitter nodes
          javascript = { 'template_string' }, -- don't add pairs in javscript template_string treesitter nodes
          java = false, -- don't check treesitter on java
        },
      }
    end,
    event = 'User ActuallyEditing',
  }
  use {
    'windwp/nvim-ts-autotag',
    after = 'nvim-treesitter',
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
      config = function()
        Safe('git-conflict').setup()
      end,
      event = 'BufReadPost',
    },
  }

  -- Hovers
  use {
    'lewis6991/hover.nvim',
    event = 'BufReadPost',
    config = function()
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
    end,
  }
  use {
    'DNLHC/glance.nvim',
    cmd = 'Glance',
    config = function()
      Safe('glance').setup {}
    end,
  }

  if packer_bootstrap then
    Safe('packer').sync()
  end
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
