local safe_call = require("plugins.ui.snacks.keys.util").safe_call

return {
	{
		"<c-/>",
		safe_call(function()
			require("snacks").terminal()
		end, "Error toggling terminal"),
		desc = "Toggle Terminal",
	},
	{
		"<c-_>",
		safe_call(function()
			require("snacks").terminal()
		end, "Error toggling terminal"),
		desc = "Toggle Terminal",
	},
}
