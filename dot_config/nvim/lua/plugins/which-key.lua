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
}
