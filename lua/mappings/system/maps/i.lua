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
			vim.cmd("stopinsert")
		end,
		"Toggle Mode",
		{ noremap = true, silent = true },
	},

	[":"] = {
		actions.open_cmdline,
		"Command Line",
		{ noremap = true, silent = true },
	},

	["<C-x>"] = {
		actions.delete_current_line_keep_insert,
		"Delete Current Line",
		{ noremap = true, silent = true },
	},

	["<C-p>"] = {
		function()
			vim.cmd("stopinsert")
			require("core.commands").smart_files()
		end,
		"File Smart",
		{ noremap = true, silent = true },
	},
	["<C-o>"] = {
		function()
			vim.cmd("stopinsert")
			require("core.commands").commands_picker()
		end,
		"Command Palette",
		{ noremap = true, silent = true },
	},
	["<C-,>"] = { actions.go_home, "Go Home", { noremap = true, silent = true } },

	["<C-S-s>"] = {
		function()
			vim.cmd("stopinsert")
			require("snacks").picker.grep()
		end,
		"Grep Search",
		{ noremap = true, silent = true },
	},
	["<C-s>"] = {
		function()
			vim.cmd("stopinsert")
			require("snacks").picker.grep()
		end,
		"Grep Search",
		{ noremap = true, silent = true },
	},

	["<C-c>"] = { "<cmd>qa!<cr>", "Force Quit Neovim", { noremap = true, silent = true } },

	["<C-l>"] = { actions.toggle_or_focus_terminal, "Toggle/Focus Terminal" },
	["<C-S-Right>"] = { actions.toggle_right_terminal, "Open Right Terminal" },

	["<C-z>"] = { "<Esc>u", "Undo" },
	["<C-S-z>"] = { "<Esc><C-r>", "Redo" },
	["<C-y>"] = { "<Esc><C-r>", "Redo" },

	["<S-Right>"] = { "<Esc>vl<C-g>", "Select Right" },
	["<S-Left>"] = { "<Esc>vh<C-g>", "Select Left" },
	["<S-Up>"] = { "<Esc>vk<C-g>", "Select Up" },
	["<S-Down>"] = { "<Esc>vj<C-g>", "Select Down" },
	["<S-Home>"] = { "<Esc>v^<C-g>", "Select to Start of Line" },
	["<S-End>"] = { "<Esc>v$<C-g>", "Select to End of Line" },
	["<S-C-Left>"] = { "<Esc>vb<C-g>", "Select Word Left" },

	["<Home>"] = {
		actions.go_home,
		"Go Home",
		{ noremap = true, silent = true },
	},
}
