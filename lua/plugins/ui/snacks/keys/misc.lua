local safe_call = require("plugins.ui.snacks.keys.util").safe_call

return {
	{
		"<leader>un",
		safe_call(function()
			require("snacks").notifier.hide()
		end, "Error hiding notifications"),
		desc = "Dismiss All Notifications",
	},
	{
		"<leader>ps",
		safe_call(function()
			require("snacks").profiler.scratch()
		end, "Error opening profiler scratch buffer"),
		desc = "Profiler Scratch Buffer",
	},
	{
		"<leader>pm",
		safe_call(function()
			vim.cmd("Mason")
		end, "Error opening Mason"),
		desc = "Open Mason Dashboard",
	},
	{
		"<leader>z",
		safe_call(function()
			require("snacks").zen()
		end, "Error toggling zen mode"),
		desc = "Toggle Zen Mode",
	},
	{
		"<leader>Z",
		safe_call(function()
			require("snacks").zen.zoom()
		end, "Error toggling zoom"),
		desc = "Toggle Zoom",
	},
	{
		"<leader>.",
		safe_call(function()
			require("snacks").scratch()
		end, "Error toggling scratch buffer"),
		desc = "Toggle Scratch Buffer",
	},
	{
		"<leader>S",
		safe_call(function()
			require("snacks").scratch.select()
		end, "Error selecting scratch buffer"),
		desc = "Select Scratch Buffer",
	},
	{
		"<leader>n",
		safe_call(function()
			require("snacks").notifier.show_history()
		end, "Error showing notification history"),
		desc = "Notification History",
	},
	{
		"<leader>bd",
		safe_call(function()
			require("snacks").bufdelete()
		end, "Error deleting buffer"),
		desc = "Delete Buffer",
	},
	{
		"<leader>cR",
		safe_call(function()
			require("snacks").rename.rename_file()
		end, "Error renaming file"),
		desc = "Rename File",
	},
	{
		"][",
		safe_call(function()
			require("snacks").words.jump(vim.v.count1)
		end, "Error jumping to next reference"),
		desc = "Next Reference",
		mode = { "n", "t" },
	},
	{
		"[[",
		safe_call(function()
			require("snacks").words.jump(-vim.v.count1)
		end, "Error jumping to previous reference"),
		desc = "Prev Reference",
		mode = { "n", "t" },
	},
	{
		"<leader>N",
		desc = "Neovim News",
		safe_call(function()
			require("snacks").win({
				file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
				width = 0.6,
				height = 0.6,
				wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3 },
			})
		end, "Error opening Neovim news"),
	},
}
