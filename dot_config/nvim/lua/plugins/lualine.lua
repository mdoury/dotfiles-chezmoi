return {
	{
		"nvim-lualine/lualine.nvim",
		-- opts = {
		-- 	theme = "catppuccin",
		-- 	section_separators = { left = "", right = "" },
		-- },
		opts = function(_, opts)
			local icons = require("lazyvim.config").icons
			local C = require("catppuccin.palettes").get_palette()

			local catppuccin = {}
			catppuccin.normal = {
				a = { bg = C.sapphire, fg = C.crust },
				b = { bg = C.teal, fg = C.crust },
				c = { bg = C.crust, fg = C.text },
			}

			catppuccin.insert = {
				a = { bg = C.blue, fg = C.crust },
				b = { bg = C.sky, fg = C.crust },
				c = { bg = C.crust, fg = C.text },
			}

			catppuccin.terminal = {
				a = { bg = C.green, fg = C.crust },
				b = { bg = C.teal, fg = C.crust },
				c = { bg = C.crust, fg = C.text },
			}

			catppuccin.command = {
				a = { bg = C.pink, fg = C.crust },
				b = { bg = C.rosewater, fg = C.crust },
				c = { bg = C.crust, fg = C.text },
			}

			catppuccin.visual = {
				a = { bg = C.lavender, fg = C.crust },
				b = { bg = C.mauve, fg = C.crust },
				c = { bg = C.crust, fg = C.text },
			}

			catppuccin.replace = {
				a = { bg = C.red, fg = C.crust },
				b = { bg = C.flamingo, fg = C.crust },
				c = { bg = C.crust, fg = C.text },
			}

			catppuccin.inactive = {
				a = { bg = C.crust, fg = C.text },
				b = { bg = C.crust, fg = C.crust },
				c = { bg = C.crust, fg = C.text },
			}

			local function fg(name)
				return function()
					---@type {foreground?:number}?
					local hl = vim.api.nvim_get_hl_by_name(name, true)
					return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
				end
			end

			return {
				options = {
					theme = catppuccin,
					globalstatus = true,
					icons_enabled = true,
					disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
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
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{
							"filename",
							path = 0,
							symbols = { modified = "  ", readonly = "", unnamed = "" },
						},
						{
							function()
								return require("nvim-navic").get_location()
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
							color = fg("Statement"),
						},
						{
							function()
								return require("noice").api.status.mode.get()
							end,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.mode.has()
							end,
							color = fg("Constant"),
						},
						{ require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
						},
					},
					lualine_y = {
						{ "progress", separator = "", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 1, right = 1 } },
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
