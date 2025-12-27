local safe_call = require("plugins.ui.snacks.keys.util").safe_call

return {
	{
		"<leader>sq",
		safe_call(function()
			require("snacks").picker.qflist()
		end, "Error opening quickfix list picker"),
		desc = "Quickfix List",
	},
	{
		"<leader>sl",
		safe_call(function()
			require("snacks").picker.loclist()
		end, "Error opening location list picker"),
		desc = "Location List",
	},
}
