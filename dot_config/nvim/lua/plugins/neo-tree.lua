return {
	-- add neo-tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			default_component_configs = {
				name = {
					use_git_status_colors = false,
				},
				modified = {
					symbol = " ",
					highlight = "NeoTreeModified",
				},
				git_status = {
					symbols = {
						-- change type
						added = " ",
						modified = " ",
						deleted = " ",
						renamed = " ",
						-- status type
						untracked = " ",
						ignored = " ",
						staged = " ",
						unstaged = " ",
						conflict = " ",
					},
				},
				window = {
					mappings = {
						["<leader>gu"] = "git_unstage_file",
						["<leader>ga"] = "git_add_file",
						["<leader>gr"] = "git_revert_file",
						["<leader>gc"] = "git_commit",
						["<leader>gp"] = "git_push",
						["<leader>gg"] = "git_commit_and_push",
					},
				},
			},
		},
	},
}
