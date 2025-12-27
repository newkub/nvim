local actions = require("mappings.system.actions")

return {
	[":"] = {
		actions.open_cmdline,
		"Command Line",
		{ noremap = true, silent = true },
	},
}
