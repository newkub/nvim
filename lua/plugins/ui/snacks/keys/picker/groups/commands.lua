local safe_call = require("plugins.ui.snacks.keys.util").safe_call

return {
	{
		"<leader>:",
		safe_call(function()
			require("snacks").picker.command_history()
		end, "Error opening command history"),
		desc = "Command History",
	},
	{
		"<leader>sc",
		safe_call(function()
			require("snacks").picker.command_history()
		end, "Error opening command history"),
		desc = "Command History",
	},
	{
		"<leader>sC",
		safe_call(function()
			require("snacks").picker.commands()
		end, "Error opening commands picker"),
		desc = "Commands",
	},
}
