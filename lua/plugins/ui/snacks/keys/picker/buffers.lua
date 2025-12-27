local safe_call = require("plugins.ui.snacks.keys.util").safe_call

return {
	{
		"<leader>,",
		safe_call(function()
			require("snacks").picker.buffers()
		end, "Error opening buffers picker"),
		desc = "Buffers",
	},
	{
		"<leader>fb",
		safe_call(function()
			require("snacks").picker.buffers()
		end, "Error opening buffers picker"),
		desc = "Buffers",
	},
	{
		"<leader>sb",
		safe_call(function()
			require("snacks").picker.lines()
		end, "Error opening lines picker"),
		desc = "Buffer Lines",
	},
}
