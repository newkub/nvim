local safe_call = require("plugins.ui.snacks.keys.util").safe_call

return {
	{
		"<leader>si",
		safe_call(function()
			require("snacks").picker.icons()
		end, "Error opening icons picker"),
		desc = "Icons",
	},
	{
		"<leader>uC",
		safe_call(function()
			require("snacks").picker.colorschemes()
		end, "Error opening colorschemes picker"),
		desc = "Colorschemes",
	},
}
