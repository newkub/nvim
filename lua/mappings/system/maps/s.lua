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

	["<S-Right>"] = { "<Right>", "Extend Selection Right" },
	["<S-Left>"] = { "<Left>", "Extend Selection Left" },
	["<S-Up>"] = { "<Up>", "Extend Selection Up" },
	["<S-Down>"] = { "<Down>", "Extend Selection Down" },
	["<S-Home>"] = { "<Home>", "Extend Selection to Start of Line" },
	["<S-End>"] = { "<End>", "Extend Selection to End of Line" },
	["<S-C-Right>"] = { "<C-Right>", "Extend Selection Word Right" },
	["<S-C-Left>"] = { "<C-Left>", "Extend Selection Word Left" },

	["<Right>"] = { "<Esc>i<Right>", "Cancel Selection and Move Right" },
	["<Left>"] = { "<Esc>i<Left>", "Cancel Selection and Move Left" },
	["<Up>"] = { "<Esc>i<Up>", "Cancel Selection and Move Up" },
	["<Down>"] = { "<Esc>i<Down>", "Cancel Selection and Move Down" },
	["<End>"] = { "<Esc>i<End>", "Cancel Selection and Move to End" },

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
}
