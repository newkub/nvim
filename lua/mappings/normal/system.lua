local actions = require("mappings.system.actions")

return {
	["<F1>"] = {
		function()
			require("snacks").picker()
		end,
		"Command Palette",
		{ noremap = true, silent = true },
	},

	["<Esc>"] = {
		function()
			vim.cmd("startinsert")
		end,
		"Toggle Mode",
		{ noremap = true, silent = true },
	},

	["<C-p>"] = {
		function()
			require("core.commands").smart_files()
		end,
		"File Smart",
		{ noremap = true, silent = true },
	},
	["<C-o>"] = {
		function()
			require("core.commands").commands_picker()
		end,
		"Command Palette",
		{ noremap = true, silent = true },
	},
	["<C-,>"] = { actions.go_home, "Go Home", { noremap = true, silent = true } },

	["<C-c>"] = { "<cmd>qa!<cr>", "Force Quit Neovim", { noremap = true, silent = true } },

	[":"] = {
		actions.open_cmdline,
		"Command Line",
		{ noremap = true, silent = true },
	},
}
