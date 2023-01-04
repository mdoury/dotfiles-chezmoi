vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

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
  close_if_last_window = true,
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
        nowait = false,
      },
      ['<2-LeftMouse>'] = 'open',
      ['<esc>'] = 'revert_preview',
      ['P'] = {
        'toggle_preview',
        config = {
          use_float = true,
        },
      },
      ['S'] = 'open_split',
      ['s'] = 'open_vsplit',
      ['t'] = 'open_tabnew',
      ['w'] = 'open_with_window_picker',
      ['C'] = 'close_node',
      ['z'] = 'close_all_nodes',
      ['Z'] = 'expand_all_nodes',
      ['a'] = 'add',
      ['A'] = 'add_directory',
      ['d'] = 'delete',
      ['r'] = 'rename',
      ['y'] = 'copy_to_clipboard',
      ['x'] = 'cut_to_clipboard',
      ['p'] = 'paste_from_clipboard',
      ['c'] = 'copy',
      ['m'] = 'move',
      ['q'] = 'close_window',
      ['R'] = 'refresh',
      ['?'] = 'show_help',
      ['<'] = 'prev_source',
      ['>'] = 'next_source',
    },
  },
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false,
    },
    follow_current_file = true,
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
