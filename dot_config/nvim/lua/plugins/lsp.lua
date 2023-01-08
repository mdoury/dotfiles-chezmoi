return {

  -- uncomment and add lsp servers with their config to servers below
  {
    "neovim/nvim-lspconfig",
    -- you can do any additional lsp server setup here
    -- return true if you don't want this server to be setup with lspconfig
    -- ---@param server string lsp server name
    -- ---@param opts _.lspconfig.options any options set for the server
    setup_server = function(server, opts)
      -- print(vim.inspect(server))
      return false
    end,
    ---@type lspconfig.options
    servers = {
      tsserver = {},
      jsonls = {},
      sumneko_lua = {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    },
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    config = function()
      local nls = require("null-ls")
      nls.setup({
        sources = {
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          -- nls.builtins.diagnostics.flake8,
        },
      })
    end,
  },

  -- uncomment and add tools to ensure_installed below
  {
    "williamboman/mason.nvim",
    ensure_installed = {
      "prettierd",
      "stylua",
      "shellcheck",
      "shfmt",
      "flake8",
    },
  },
}
