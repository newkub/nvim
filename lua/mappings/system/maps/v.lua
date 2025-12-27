local actions = require("mappings.system.actions")

return {
	["<S-Right>"] = { "l<C-g>", "Extend Selection Right" },
	["<S-Left>"] = { "h<C-g>", "Extend Selection Left" },
	["<S-Up>"] = { "k<C-g>", "Extend Selection Up" },
	["<S-Down>"] = { "j<C-g>", "Extend Selection Down" },
	["<S-Home>"] = { "^<C-g>", "Extend Selection to Start of Line" },
	["<S-End>"] = { "$<C-g>", "Extend Selection to End of Line" },
	["<S-C-Right>"] = { "w<C-g>", "Extend Selection Word Right" },
	["<S-C-Left>"] = { "b<C-g>", "Extend Selection Word Left" },
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
