return {
  -- override which-key config
  {
    "folke/which-key.nvim",
    -- import/override with your plugins
    opts = {
      key_labels = {
        ["∆"] = "<A-j>",
        ["˚"] = "<A-k>",
      },
    },
  },

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  -- add zen-mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = true,
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
}
