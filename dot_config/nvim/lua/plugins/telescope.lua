return {
	-- change some telescope options and add telescope-fzf-native
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
		keys = {
			-- add a keymap to browse plugin files
			{
				"<leader>fp",
				function()
					require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
				end,
				desc = "Find Plugin File",
			},
		},
		-- change some options
		opts = {
			defaults = {
				-- trim indentation for file grep
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--trim",
				},
				mappings = {
					i = {
						-- close on <esc>, jk goes to normal mode
						["<esc>"] = function(...)
							require("telescope.actions").close(...)
						end,
					},
				},
				-- winblend = 0,
			},
		},
		-- apply the config and additionally load fzf-native
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
		end,
	},
}
