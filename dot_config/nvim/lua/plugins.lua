local packer = nil
local function init()
    if packer == nil then
        packer = safe 'packer'
        packer.init {
            -- profile = {
            --     enable = true
            -- },
            disable_commands = true,
            display = {
                open_fn = function()
                    local result, win, buf = safe('packer.util').float {
                        border = {{'╭', 'FloatBorder'}, {'─', 'FloatBorder'}, {'╮', 'FloatBorder'},
                                  {'│', 'FloatBorder'}, {'╯', 'FloatBorder'}, {'─', 'FloatBorder'},
                                  {'╰', 'FloatBorder'}, {'│', 'FloatBorder'}}
                    }
                    vim.api.nvim_win_set_option(win, 'winhighlight', 'NormalFloat:Normal')
                    return result, win, buf
                end
            }
        }
    end

    local use = packer.use
    -- packer.reset()

    -- Plugin manager
    use('wbthomason/packer.nvim')

    -- Plugin caching
    use('lewis6991/impatient.nvim')

		-- Profiling
		use { 'dstein64/vim-startuptime', cmd = 'StartupTime', config = [[vim.g.startuptime_tries = 15]] }

    -- Async building & commands
    use({
        'ojroques/nvim-bufdel',
        cmd = 'BufDel',
        config = function()
            safe('bufdel').setup({
                quit = false
            })
        end
    })

    -- Keymap assistant
    use({
        'folke/which-key.nvim',
        config = function()
            safe('which-key').setup {}
        end,
        event = 'BufReadPost'
    })

    -- Motions
    use({{
        'chaoren/vim-wordmotion',
        event = 'User ActuallyEditing'
    }, {
        'ggandor/leap.nvim',
        event = 'User ActuallyEditing',
        requires = 'tpope/vim-repeat'
    }, {
        'ggandor/flit.nvim',
        config = function()
            safe('flit').setup({
                labeled_modes = 'nv'
            })
        end,
        event = 'User ActuallyEditing'
    }})

    -- Indentation tracking
    use({
        'lukas-reineke/indent-blankline.nvim',
        after = 'nvim-treesitter'
    })

    -- Commenting
    -- use('tomtom/tcomment_vim')
    use({
        'numToStr/Comment.nvim',
        event = 'User ActuallyEditing',
        config = function()
            safe('Comment').setup({})
        end
    })

    -- Wrapping/delimiters
    use({{
        'machakann/vim-sandwich',
        event = 'User ActuallyEditing'
    }, {
        'andymass/vim-matchup',
        setup = function()
            safe('config.matchup')
        end,
        event = 'User ActuallyEditing'
    }})

    -- Search
    use('romainl/vim-cool')

    -- Prettification
    use({
        'junegunn/vim-easy-align',
        disable = true
    })

    -- Undo tree
    use({
        'mbbill/undotree',
        cmd = 'UndotreeToggle',
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
        end
    })

    -- Text objects
    use({'wellle/targets.vim'})

    use({'nvim-lua/plenary.nvim'})

    use({'bluz71/vim-nightfly-guicolors'})

    use({'christoomey/vim-tmux-navigator'})

    use({'szw/vim-maximizer'})

    use({'inkarkat/vim-ReplaceWithRegister'})

    -- Path navigation
    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        config = function()
            -- Unless you are still migrating, remove the deprecated commands from v1.x
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

            -- If you want icons for diagnostic errors, you'll need to define them somewhere:
            local sign_define = vim.fn.sign_define
            sign_define("DiagnosticSignError", {
                text = " ",
                texthl = "DiagnosticSignError"
            })
            sign_define("DiagnosticSignWarn", {
                text = " ",
                texthl = "DiagnosticSignWarn"
            })
            sign_define("DiagnosticSignInfo", {
                text = " ",
                texthl = "DiagnosticSignInfo"
            })
            sign_define("DiagnosticSignHint", {
                text = "",
                texthl = "DiagnosticSignHint"
            })

            require("neo-tree").setup({
                close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
                popup_border_style = "rounded",
                window = {
                    position = "left",
                    width = 40,
                    mapping_options = {
                        noremap = true,
                        nowait = true
                    },
                    mappings = {
                        ["<space>"] = {
                            "toggle_node",
                            nowait = false -- disable `nowait` if you have existing combos starting with this char that you want to use 
                        },
                        ["<2-LeftMouse>"] = "open",
                        ["<cr>"] = "open",
                        ["<esc>"] = "revert_preview",
                        ["P"] = {
                            "toggle_preview",
                            config = {
                                use_float = true
                            }
                        },
                        ["S"] = "open_split",
                        ["s"] = "open_vsplit",
                        -- ["S"] = "split_with_window_picker",
                        -- ["s"] = "vsplit_with_window_picker",
                        ["t"] = "open_tabnew",
                        -- ["<cr>"] = "open_drop",
                        -- ["t"] = "open_tab_drop",
                        ["w"] = "open_with_window_picker",
                        -- ["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
                        ["C"] = "close_node",
                        ["z"] = "close_all_nodes",
                        -- ["Z"] = "expand_all_nodes",
                        ["a"] = {
                            "add",
                            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                            config = {
                                show_path = "none" -- "none", "relative", "absolute"
                            }
                        },
                        ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
                        ["d"] = "delete",
                        ["r"] = "rename",
                        ["y"] = "copy_to_clipboard",
                        ["x"] = "cut_to_clipboard",
                        ["p"] = "paste_from_clipboard",
                        ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
                        -- ["c"] = {
                        --  "copy",
                        --  config = {
                        --    show_path = "none" -- "none", "relative", "absolute"
                        --  }
                        -- }
                        ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
                        ["q"] = "close_window",
                        ["R"] = "refresh",
                        ["?"] = "show_help",
                        ["<"] = "prev_source",
                        [">"] = "next_source"
                    }
                },
                filesystem = {
                    filtered_items = {
                        visible = false, -- when true, they will just be displayed differently than normal items
                        hide_dotfiles = false,
                        hide_gitignored = false,
                        hide_hidden = false -- only works on Windows for hidden files/directories
                    },
                    follow_current_file = true, -- This will find and focus the file in the active buffer every
                    -- time the current file is changed while the tree is open.
                    window = {
                        mappings = {
                            ["<bs>"] = "navigate_up",
                            ["."] = "set_root",
                            ["H"] = "toggle_hidden",
                            ["/"] = "fuzzy_finder",
                            ["D"] = "fuzzy_finder_directory",
                            ["f"] = "filter_on_submit",
                            ["<c-x>"] = "clear_filter",
                            ["[g"] = "prev_git_modified",
                            ["]g"] = "next_git_modified"
                        }
                    }
                },
                buffers = {
                    window = {
                        mappings = {
                            ["bd"] = "buffer_delete",
                            ["<bs>"] = "navigate_up",
                            ["."] = "set_root"
                        }
                    }
                },
                git_status = {
                    window = {
                        position = "float",
                        mappings = {
                            ["A"] = "git_add_all",
                            ["gu"] = "git_unstage_file",
                            ["ga"] = "git_add_file",
                            ["gr"] = "git_revert_file",
                            ["gc"] = "git_commit",
                            ["gp"] = "git_push",
                            ["gg"] = "git_commit_and_push"
                        }
                    }
                }
            })

        end,
        requires = {'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim', {
            -- only needed if you want to use the commands with "_with_window_picker" suffix
            's1n7ax/nvim-window-picker',
            tag = "v1.*",
            config = function()
                require'window-picker'.setup({
                    autoselect_one = true,
                    include_current = false,
                    filter_rules = {
                        -- filter using buffer options
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = {'neo-tree', "neo-tree-popup", "notify"},

                            -- if the buffer type is one of following, the window will be ignored
                            buftype = {'terminal', "quickfix"}
                        }
                    },
                    other_win_hl_color = '#e35e4f'
                })
            end
        }},
        cmd = "Neotree"
    }

    -- Highlights
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {{
            'nvim-treesitter/nvim-treesitter-refactor',
            after = 'nvim-treesitter'
        }, {
            'RRethy/nvim-treesitter-textsubjects',
            after = 'nvim-treesitter'
        }},
        run = function()
            local ts_update = require('nvim-treesitter.install').update({
                with_sync = true
            })
            ts_update()
        end,
        event = 'User ActuallyEditing',
        config = [[require 'config.treesitter']]
    }

    use({
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            safe('trouble').setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
        cmd = {'Trouble', 'TroubleClose', 'TroubleToggle', 'TroubleRefresh'}
    })

    -- Colorscheme
    use("arcticicestudio/nord-vim")

    -- Pretty UI
    use 'stevearc/dressing.nvim'
    use 'rcarriga/nvim-notify'
    use 'vigoux/notifier.nvim'
    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        event = 'BufReadPost',
        config = function()
            require('todo-comments').setup {}
        end
    }
    use({'nvim-lualine/lualine.nvim'})

    -- Search
    use({{
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzf-native.nvim',
                    'nvim-telescope/telescope-ui-select.nvim'},
        setup = function()
            safe('config.telescope_setup')
        end,
        config = function()
            safe('config.telescope')
        end,
        cmd = 'Telescope',
        module = 'telescope'
    }, {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }, 'crispgm/telescope-heading.nvim'})

    use({
        'hrsh7th/nvim-cmp',
        requires = {'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path'}
    })

    use({
        'L3MON4D3/LuaSnip',
        event = "InsertEnter"
    })
    use({
        'saadparwaiz1/cmp_luasnip',
        event = "InsertEnter"
    })
    use({
        'rafamadriz/friendly-snippets',
        event = "InsertEnter"
    })

    use({
        'williamboman/mason.nvim',
        event = "User ActuallyEditing",
				config = function()
					safe("config.mason")
				end
    })

    use({
        'williamboman/mason-lspconfig.nvim',
        event = "User ActuallyEditing"
    })

    use({
        'neovim/nvim-lspconfig',
    })
    use({
        'hrsh7th/cmp-nvim-lsp',
    })
    use({
        'glepnir/lspsaga.nvim',
        branch = 'main',
    })
    use({
        'jose-elias-alvarez/typescript.nvim',
    })
    use({
        'onsails/lspkind.nvim',
    })

    use({
        'jose-elias-alvarez/null-ls.nvim',
        event = "User ActuallyEditing"
    })
    use({
        'jayp0521/mason-null-ls.nvim',
        event = "User ActuallyEditing"
    })

    use({
        'windwp/nvim-autopairs',
        config = function()
            safe('nvim-autopairs').setup({
                check_ts = true, -- enable treesitter
                ts_config = {
                    lua = {'string'}, -- don't add pairs in lua string treesitter nodes
                    javascript = {'template_string'}, -- don't add pairs in javscript template_string treesitter nodes
                    java = false -- don't check treesitter on java
                }
            })
        end
    })
    use({
        'windwp/nvim-ts-autotag',
        after = 'nvim-treesitter'
    })

    -- Git
    use({{
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = [[safe('config.gitsigns')]],
        event = 'User ActuallyEditing'
    }, {
        'TimUntersberger/neogit',
        cmd = 'Neogit',
        config = [[safe('config.neogit')]]
    }, {
        'akinsho/git-conflict.nvim',
        tag = '*',
        config = function()
            safe('git-conflict').setup()
        end,
        event = 'BufReadPost'
    }})

    -- Hovers
    use({
        'lewis6991/hover.nvim',
        event = 'BufReadPost',
        config = function()
            local hover = safe('hover')
            hover.setup {
                init = function()
                    safe('hover.providers.lsp')
                end
            }

            vim.keymap.set('n', 'K', hover.hover, {
                desc = 'hover.nvim'
            })
            vim.keymap.set('n', 'gK', hover.hover_select, {
                desc = 'hover.nvim (select)'
            })
        end
    })
    use({
        'DNLHC/glance.nvim',
        cmd = 'Glance',
        config = function()
            safe('glance').setup {
                border = {
                    enable = true,
                    top_char = '─',
                    bottom_char = '─'
                },
                theme = {
                    mode = 'brighten'
                },
                indent_lines = {
                    icon = '│'
                }
            }
        end
    })

end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end
})

return plugins
