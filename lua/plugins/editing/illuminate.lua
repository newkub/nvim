return {
	"RRethy/vim-illuminate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("illuminate").configure({
			delay = 100,
			filetypes_denylist = {
				"NvimTree",
				"snacks_terminal",
				"terminal",
				"TelescopePrompt",
				"help",
		},
			providers = {
				"lsp",
				"treesitter",
				"regex",
			},
		})
	end,
}
