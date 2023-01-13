return {
	-- Configure catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			term_colors = true,
			color_overrides = {
				mocha = {
					base = "#000000",
				},
			},
			highlight_overrides = {
				mocha = function(C)
					return {
						TabLineSel = { bg = C.pink },
						NvimTreeNormal = { bg = C.none },
						CmpBorder = { fg = C.surface2 },
						Pmenu = { bg = C.none },
						NormalFloat = { bg = C.none },
						TelescopeBorder = { link = "FloatBorder" },
					}
				end,
			},
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
					custom_bg = "#313244",
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
