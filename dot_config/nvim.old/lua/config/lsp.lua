local lspconfig = Safe 'lspconfig'
local null_ls = Safe 'null-ls'
-- local lightbulb = Safe 'nvim-lightbulb'

local lsp = vim.lsp
local map = vim.keymap.set
local cmd = vim.cmd

-- vim.api.nvim_command 'hi link LightBulbFloatWin YellowFloat'
-- vim.api.nvim_command 'hi link LightBulbVirtualText YellowFloat'

local signs = {
  Error = ' ',
  Warn = ' ',
  Hint = ' ',
  Info = ' ',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

vim.diagnostic.config {
  virtual_lines = {
    only_current_line = true,
  },
  virtual_text = false,
}

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true,
})

local severity = { 'error', 'warn', 'info', 'hint' }

lsp.handlers['window/showMessage'] = function(_, method, params, _)
  vim.notify(method.message, severity[params.type], { title = 'LSP' })
end

local signature = Safe 'lsp_signature'
signature.setup {
  bind = true,
  handler_opts = {
    border = 'single',
  },
}
local keymap_opts = {
  buffer = 0,
  remap = false,
  silent = true,
}

local renamer_loaded = false

local function on_attach(client)
  if not renamer_loaded then
    Safe('renamer').setup {}
    renamer_loaded = true
  end

  signature.on_attach {
    bind = true,
    handler_opts = {
      border = 'single',
    },
  }
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', keymap_opts)
  map('n', 'gd', '<cmd>Glance definitions<CR>', keymap_opts)
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', keymap_opts)
  map('n', 'gi', '<cmd>Glance implementations<CR>', keymap_opts)
  map('n', 'gS', '<cmd>lua vim.lsp.buf.signature_help()<CR>', keymap_opts)
  map('n', 'gTD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', keymap_opts)
  map('n', 'gr', '<cmd>Glance references<CR>', keymap_opts)
  map('n', 'gA', '<cmd>lua vim.lsp.buf.code_action()<CR>', keymap_opts)
  map('v', 'gA', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', keymap_opts)
  map('n', ']e', '<cmd>lua vim.diagnostic.goto_next { float = {scope = "line"} }<cr>', keymap_opts)
  map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev { float = {scope = "line"} }<cr>', keymap_opts)

  if client.server_capabilities.documentFormattingProvider then
    map('n', '<leader>f', '<cmd>lua vim.lsp.buf.format { async = true }<cr>', keymap_opts)
  end

  cmd 'augroup lsp_aucmds'
  if client.server_capabilities.documentHighlightProvider then
    cmd 'au CursorHold <buffer> lua vim.lsp.buf.document_highlight()'
    cmd 'au CursorMoved <buffer> lua vim.lsp.buf.clear_references()'
  end

  -- cmd 'au CursorHold,CursorHoldI <buffer> lua Safe"nvim-lightbulb".update_lightbulb ()'
  -- cmd 'au CursorHold,CursorHoldI <buffer> lua vim.diagnostic.open_float(0, { scope = "line" })'
  cmd 'augroup END'
end

local function prefer_null_ls_fmt(client)
  client.server_capabilities.documentHighlightProvider = false
  client.server_capabilities.documentFormattingProvider = false
  on_attach(client)
end

local servers = {
  bashls = {},
  cssls = {
    cmd = { 'vscode-css-languageserver', '--stdio' },
    filetypes = { 'css', 'scss', 'less', 'sass' },
    root_dir = lspconfig.util.root_pattern('package.json', '.git'),
  },
  html = {
    cmd = { 'vscode-html-languageserver', '--stdio' },
  },
  emmet_ls = {
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
  },
  jsonls = {
    prefer_null_ls = true,
    cmd = { 'vscode-json-languageserver', '--stdio' },
  },
  sumneko_lua = {
    cmd = { 'lua-language-server' },
    prefer_null_ls = true,
    settings = { -- custom settings for lua
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        -- make the language server recognize "vim" global
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          -- make language server aware of runtime files
          library = {
            vim.api.nvim_get_runtime_file('', true),
            [vim.fn.expand '$VIMRUNTIME/lua'] = true,
            [vim.fn.stdpath 'config' .. '/lua'] = true,
          },
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  tsserver = {},
  vimls = {},
}

local client_capabilities = Safe('cmp_nvim_lsp').default_capabilities()
client_capabilities.offsetEncoding = { 'utf-16' }

for server, config in pairs(servers) do
  if config.prefer_null_ls then
    if config.on_attach then
      local old_on_attach = config.on_attach
      config.on_attach = function(client, bufnr)
        old_on_attach(client, bufnr)
        prefer_null_ls_fmt(client)
      end
    else
      config.on_attach = prefer_null_ls_fmt
    end
  elseif not config.on_attach then
    config.on_attach = on_attach
  end
  config.capabilities = vim.tbl_deep_extend('keep', config.capabilities or {}, client_capabilities)
  lspconfig[server].setup(config)
end

-- null-ls setup
local null_fmt = null_ls.builtins.formatting
local null_diag = null_ls.builtins.diagnostics
local null_act = null_ls.builtins.code_actions
null_ls.setup {
  sources = {
    null_diag.proselint,
    null_diag.selene.with {},
    null_diag.shellcheck,
    null_diag.vint,
    null_fmt.prettier,
    null_fmt.shfmt,
    null_fmt.stylua,
    null_fmt.trim_whitespace,
    null_act.gitsigns,
    -- null_act.refactoring.with {
    -- filetypes = { 'javascript', 'typescript', 'lua' },
    -- },
  },
  on_attach = on_attach,
}
