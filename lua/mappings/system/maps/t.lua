local actions = require("mappings.system.actions")

return {
	["<C-l>"] = { actions.toggle_or_focus_terminal, "Toggle/Focus Terminal" },
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
