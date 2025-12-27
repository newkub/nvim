local safe_call = require("plugins.ui.snacks.keys.util").safe_call

return {
	{
		"<leader>sd",
		safe_call(function()
			require("snacks").picker.diagnostics()
		end, "Error opening diagnostics picker"),
		desc = "Diagnostics",
	},
	{
		"<leader>sD",
		safe_call(function()
			require("snacks").picker.diagnostics_buffer()
		end, "Error opening buffer diagnostics picker"),
		desc = "Buffer Diagnostics",
	},
}
