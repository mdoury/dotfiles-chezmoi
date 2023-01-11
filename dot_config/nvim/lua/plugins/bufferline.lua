return {
	-- set bufferline highlights
	{
		"akinsho/bufferline.nvim",
		opts = {
			highlights = require("catppuccin.groups.integrations.bufferline").get(),
		},
	},
}
