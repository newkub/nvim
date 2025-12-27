local actions = require("mappings.system.actions")

return {
	["<Esc>"] = { "i", "Toggle Insert Mode", { noremap = true, silent = true } },

	["<C-z>"] = { "u", "Undo" },
	["<C-S-z>"] = { "<C-r>", "Redo" },
	["<C-y>"] = { "<C-r>", "Redo" },

	["<Home>"] = {
		actions.go_home,
		"Go Home",
		{ noremap = true, silent = true },
	},
}
