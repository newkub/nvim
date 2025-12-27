local actions = require("mappings.system.actions")

return {
	["<C-`>"] = {
		function()
			vim.cmd("terminal " .. require("core.utils").get_default_shell())
		end,
		"Open Terminal",
	},

	["<C-l>"] = { actions.toggle_or_focus_terminal, "Toggle/Focus Terminal" },
	["<C-S-Right>"] = { actions.toggle_right_terminal, "Open Right Terminal" },
}
