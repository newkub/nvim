return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		opts = {},
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
		},
	},
}
