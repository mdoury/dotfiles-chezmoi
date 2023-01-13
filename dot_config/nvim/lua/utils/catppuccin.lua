local M = {}

M.lualine = function(palette)
	local c = require("catppuccin.palettes").get_palette(palette)
	local base = {
		b = { bg = c.teal, fg = c.surface0 },
		c = { bg = c.surface0, fg = c.text },
		x = { bg = c.surface0, fg = c.subtext0 },
		y = { bg = c.maroon, fg = c.surface0 },
		z = { bg = c.rosewater, fg = c.surface0 },
	}
	local modes = {
		normal = { bg = c.teal, fg = c.surface0 },
		insert = { bg = c.flamingo, fg = c.surface0 },
		terminal = { bg = c.flamingo, fg = c.surface0 },
		command = { bg = c.teal, fg = c.surface0 },
		visual = { bg = c.maroon, fg = c.surface0 },
		replace = { bg = c.red, fg = c.surface0 },
		inactive = { bg = c.rosewater, fg = c.surface0 },
	}

	local config = {}
	for mode, theme in pairs(modes) do
		print(theme.bg)
		config[mode] = vim.tbl_extend("force", base, { a = theme })
	end

	config.components = {
		branch = {},
		command = { fg = c.mauve },
		diff = {
			added = { fg = c.teal },
			modified = { fg = c.rosewater },
			removed = { fg = c.maroon },
		},
		filename = function()
			return { gui = vim.bo.modified and "bold" or "" }
		end,
		root = { bg = c.pink, fg = c.surface0 },
		updates = { fg = c.pink },
	}

	return config
end

return M
