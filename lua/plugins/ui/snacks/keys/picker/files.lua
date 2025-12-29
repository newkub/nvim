local safe_call = require("plugins.ui.snacks.keys.util").safe_call

return {
	{
		"<leader><space>",
		safe_call(function()
			require("snacks").picker.files()
		end, "Error toggling dashboard"),
		desc = "File Picker",
		mode = "n",
	},
	{
		"<C-S-f>",
		safe_call(function()
			require("snacks").picker.files()
		end, "Error opening file picker"),
		desc = "File Picker",
	},
	{
		"<S-f>",
		safe_call(function()
			require("snacks").picker.files()
		end, "Error opening file picker"),
		desc = "File Picker",
	},
	{
		"<leader>fc",
		safe_call(function()
			require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
		end, "Error opening config file picker"),
		desc = "Find Config File",
	},
	{
		"<leader>ff",
		safe_call(function()
			require("snacks").picker.files()
		end, "Error opening file picker"),
		desc = "Find Files",
	},
	{
		"<leader>fg",
		safe_call(function()
			require("snacks").picker.git_files()
		end, "Error opening git files picker"),
		desc = "Find Git Files",
	},
	{
		"<leader>fr",
		safe_call(function()
			require("snacks").picker.recent()
		end, "Error opening recent files picker"),
		desc = "Recent",
	},
	{
		"<C-r>",
		safe_call(function()
			require("snacks").picker.recent()
		end, "Error opening recent files picker"),
		desc = "Recent Files",
	},
}
