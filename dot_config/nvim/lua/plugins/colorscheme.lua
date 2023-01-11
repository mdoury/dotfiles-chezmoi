return {
	-- Configure catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			term_colors = true,
			-- custom_highlights = function(colors) end,
			integrations = {
				cmp = true,
				dashboard = true,
				gitsigns = true,
				illuminate = true,
				indent_blankline = {
					enabled = true,
					colored_indent_levels = false,
				},
				leap = true,
				lsp_trouble = true,
				markdown = true,
				mason = true,
				mini = true,
				native_lsp = {
					enabled = true,
					virtualtext = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
				},
				navic = {
					enabled = true,
					custom_bg = "#11111B",
				},
				-- neogit = true,
				neotree = true,
				noice = true,
				notify = true,
				symbols_outline = true,
				telescope = true,
				treesitter = true,
				which_key = true,
			},
		},
	},
}
