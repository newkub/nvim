return {
	["<C-S-s>"] = {
		function()
			require("snacks").picker.grep()
		end,
		"Grep Search",
		{ noremap = true, silent = true },
	},
	["<C-s>"] = {
		function()
			require("snacks").picker.grep()
		end,
		"Grep Search",
		{ noremap = true, silent = true },
	},
}
