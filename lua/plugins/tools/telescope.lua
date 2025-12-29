return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = function()
			return {
				defaults = {},
				extensions = {
					git_file_history = {},
				},
			}
		end,
		config = function(_, opts)
			local ok, telescope = pcall(require, "telescope")
			if not ok then
				return
			end
			telescope.setup(opts)
			pcall(telescope.load_extension, "git_file_history")
		end,
	},
	{
		"isak102/telescope-git-file-history.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
}
