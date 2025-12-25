return {
	"stevearc/overseer.nvim",
	cmd = { "OverseerRun", "OverseerToggle", "OverseerOpen", "OverseerClose", "OverseerQuickAction" },
	keys = {
		{ "<leader>or", "<cmd>OverseerRun<cr>", desc = "Overseer Run" },
		{ "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Overseer Toggle" },
		{ "<leader>oa", "<cmd>OverseerQuickAction<cr>", desc = "Overseer Action" },
		{ "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
	},
	opts = {
		strategy = {
			"toggleterm",
			use_shell = true,
			direction = "vertical",
			size = 80,
		},
	},
	config = function(_, opts)
		require("overseer").setup(opts)
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"akinsho/toggleterm.nvim",
	},
}
