return {
	-- add zen-mode
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		config = true,
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},
}
