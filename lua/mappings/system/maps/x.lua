local actions = require("mappings.system.actions")

return {
	["<Esc>"] = { "<Esc>i", "Toggle Mode" },
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

	[":"] = {
		actions.open_cmdline,
		"Command Line",
		{ noremap = true, silent = true },
	},
}
