local actions = require("mappings.system.actions")

return {
	["<C-l>"] = {
		function()
			local current_win = vim.api.nvim_get_current_win()
			vim.api.nvim_win_hide(current_win)
		end,
		"Hide Terminal",
	},

	["<C-k>"] = { "<C-\\><C-n><C-w>w", "Focus Editor" },
	["<Home>"] = {
		actions.go_home,
		"Go Home",
		{ noremap = true, silent = true },
	},

	[":"] = {
		actions.open_cmdline,
		"Command Line",
		{ noremap = true, silent = true },
	},

	["<F11>"] = { actions.open_floating_pwsh_terminal, "Floating Terminal (pwsh)", { noremap = true, silent = true } },
}
