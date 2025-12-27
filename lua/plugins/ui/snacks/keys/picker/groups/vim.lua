local safe_call = require("plugins.ui.snacks.keys.util").safe_call

return {
	{
		"<leader>sa",
		safe_call(function()
			require("snacks").picker.autocmds()
		end, "Error opening autocmds picker"),
		desc = "Autocmds",
	},
	{
		"<leader>sk",
		safe_call(function()
			require("snacks").picker.keymaps()
		end, "Error opening keymaps picker"),
		desc = "Keymaps",
	},
	{
		"<leader>sh",
		safe_call(function()
			require("snacks").picker.help()
		end, "Error opening help picker"),
		desc = "Help Pages",
	},
	{
		"<leader>sH",
		safe_call(function()
			require("snacks").picker.highlights()
		end, "Error opening highlights picker"),
		desc = "Highlights",
	},
	{
		"<leader>sj",
		safe_call(function()
			require("snacks").picker.jumps()
		end, "Error opening jumps picker"),
		desc = "Jumps",
	},
	{
		"<leader>sm",
		safe_call(function()
			require("snacks").picker.marks()
		end, "Error opening marks picker"),
		desc = "Marks",
	},
	{
		'<leader>s"',
		safe_call(function()
			require("snacks").picker.registers()
		end, "Error opening registers picker"),
		desc = "Registers",
	},
	{
		"<leader>su",
		safe_call(function()
			require("snacks").picker.undo()
		end, "Error opening undo history picker"),
		desc = "Undo History",
	},
}
