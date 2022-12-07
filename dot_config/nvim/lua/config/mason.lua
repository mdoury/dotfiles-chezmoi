local mason = safe("mason")
local mason_lspconfig = safe("mason-lspconfig")
local mason_null_ls = safe("mason-null-ls")

-- enable mason
mason.setup({})

mason_lspconfig.setup({
  -- list of servers for mason to install
  ensure_installed = {
		"bashls",
    "cssls",
    "emmet_ls",
    "html",
    "sumneko_lua",
    "tailwindcss",
    "tsserver",
		"vimls",
  },
  -- auto-install configured servers (with lspconfig)
  automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
  -- list of formatters & linters for mason to install
  ensure_installed = {
		-- formatters
		"prettier", -- ts/js formatter
		"shfmt", -- shell formatter
    "stylua", -- lua formatter
		"trim_whitespace", -- trailing whitespace trimmer
		-- linters
    "eslint_d", -- ts/js linter
		"proselint", -- english prose linter
		"shellcheck", -- shell linter
		"selene", -- lua linter
		"vint", -- vim script linter
		-- code actions
		"gitsigns", -- git actions from gitsigns gutter
		"refactoring", -- refactoring actions
  },
  -- auto-install configured formatters & linters (with null-ls)
  automatic_installation = true,
})
