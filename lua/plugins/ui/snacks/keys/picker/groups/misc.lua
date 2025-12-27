local safe_call = require("plugins.ui.snacks.keys.util").safe_call

return {
	{
		"<leader>sp",
		safe_call(function()
			require("snacks").picker.lazy()
		end, "Error opening lazy picker"),
		desc = "Search for Plugin Spec",
	},
	{
		"<leader>sR",
		safe_call(function()
			require("snacks").picker.resume()
		end, "Error opening resume picker"),
		desc = "Resume",
	},
}
