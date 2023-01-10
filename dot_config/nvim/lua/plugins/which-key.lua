return {

  -- which-key
  {
    "folke/which-key.nvim",
    dev = true,
    branch = "hide-with-desc",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      key_labels = { ["<leader>"] = "SPC" },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>h"] = { name = "+help" },
        ["<leader>n"] = { name = "+noice" },
        ["<leader>o"] = { name = "+open" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>t"] = { name = "+toggle" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader><tab>"] = { name = "+tabs" },
      })
    end,
  },
}
