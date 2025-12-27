local safe_call = require("plugins.ui.snacks.keys.util").safe_call

return {
	{
		"<leader>/",
		safe_call(function()
			require("snacks").picker.grep()
		end, "Error opening grep picker"),
		desc = "Grep",
	},
	{
		"<C-f>",
		safe_call(function()
			require("snacks").picker.grep()
		end, "Error opening grep picker"),
		desc = "Grep in Files",
	},
	{
		"<leader>sg",
		safe_call(function()
			require("snacks").picker.grep()
		end, "Error opening grep picker"),
		desc = "Grep",
	},
	{
		"<leader>sB",
		safe_call(function()
			require("snacks").picker.grep_buffers()
		end, "Error opening grep buffers picker"),
		desc = "Grep Open Buffers",
	},
	{
		"<leader>sw",
		safe_call(function()
			require("snacks").picker.grep_word()
		end, "Error opening grep word picker"),
		desc = "Visual selection or word",
		mode = { "n", "x" },
	},
	{
		"<leader>s/",
		safe_call(function()
			require("snacks").picker.search_history()
		end, "Error opening search history picker"),
		desc = "Search History",
	},
}
