local actions = require("mappings.system.actions")

return {
	["<F1>"] = {
		function()
			require("snacks").picker()
		end,
		"Command Palette",
		{ noremap = true, silent = true },
	},

	["<C-c>"] = { "<cmd>qa!<cr>", "Force Quit Neovim", { noremap = true, silent = true } },

	[":"] = {
		actions.open_cmdline,
		"Command Line",
		{ noremap = true, silent = true },
	},
}
