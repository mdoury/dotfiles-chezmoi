return {
	{
		"nvim-lualine/lualine.nvim",
		opts = function()
			local icons = require("lazyvim.config").icons
			local theme = require("utils.catppuccin").lualine("mocha")

			return {
				options = {
					theme = theme,
					globalstatus = true,
					icons_enabled = true,
					disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
					section_separators = { left = "", right = "" },
					component_separators = "",
				},
				sections = {
					lualine_a = { { "mode", icon = "" } },
					lualine_b = {},
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{
							function()
								return require("nvim-navic").get_location():sub(1, -3)
							end,
							cond = function()
								return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
							end,
						},
					},
					lualine_x = {
						{
							function()
								return require("noice").api.status.command.get()
							end,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.command.has()
							end,
							color = theme.components.command,
						},
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = theme.components.updates,
						},
						{
							"diff",
							diff_color = theme.components.diff,
							symbols = icons.git,
						},
						{
							"branch",
							icon = "",
							color = theme.components.branch,
							separator = { left = "" },
						},
					},
					lualine_y = {
						-- { "progress", separator = "", padding = { left = 1, right = 0 } },
						-- { "location", padding = { left = 1, right = 1 } },
						{ "filetype", icon_only = true, colored = false, separator = "", padding = { left = 1, right = 0 } },
						{
							"filename",
							color = theme.components.filename,
							file_status = false,
						},
						{
							function()
								return " " .. vim.fn.fnamemodify(require("lazyvim.util").get_root(), ":t")
							end,
							color = theme.components.root,
							separator = { left = "" },
						},
					},
					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
				},
			}
		end,
	},
}
