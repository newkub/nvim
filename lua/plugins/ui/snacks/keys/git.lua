local safe_call = require("plugins.ui.snacks.keys.util").safe_call

return {
	{
		"<leader>gb",
		safe_call(function()
			require("snacks").picker.git_branches()
		end, "Error opening git branches picker"),
		desc = "Git Branches",
	},
	{
		"<leader>gl",
		safe_call(function()
			require("snacks").picker.git_log()
		end, "Error opening git log picker"),
		desc = "Git Log",
	},
	{
		"<leader>gL",
		safe_call(function()
			require("snacks").picker.git_log_line()
		end, "Error opening git log line picker"),
		desc = "Git Log Line",
	},
	{
		"<leader>gs",
		safe_call(function()
			require("snacks").picker.git_status()
		end, "Error opening git status picker"),
		desc = "Git Status",
	},
	{
		"<leader>gS",
		safe_call(function()
			require("snacks").picker.git_stash()
		end, "Error opening git stash picker"),
		desc = "Git Stash",
	},
	{
		"<leader>gd",
		safe_call(function()
			require("snacks").picker.git_diff()
		end, "Error opening git diff picker"),
		desc = "Git Diff (Hunks)",
	},
	{
		"<leader>gg",
		safe_call(function()
			require("snacks").lazygit.open()
		end, "Error opening lazygit"),
		desc = "Lazygit",
	},
	{
		"<leader>gi",
		safe_call(function()
			require("snacks").picker.gh_issue()
		end, "Error opening GitHub issues picker"),
		desc = "GitHub Issues (open)",
	},
	{
		"<leader>gI",
		safe_call(function()
			require("snacks").picker.gh_issue({ state = "all" })
		end, "Error opening GitHub issues picker"),
		desc = "GitHub Issues (all)",
	},
	{
		"<leader>gp",
		safe_call(function()
			require("snacks").picker.gh_pr()
		end, "Error opening GitHub pull requests picker"),
		desc = "GitHub Pull Requests (open)",
	},
	{
		"<leader>gP",
		safe_call(function()
			require("snacks").picker.gh_pr({ state = "all" })
		end, "Error opening GitHub pull requests picker"),
		desc = "GitHub Pull Requests (all)",
	},
	{
		"<leader>gf",
		safe_call(function()
			require("snacks").picker.git_log_file()
		end, "Error opening git log file picker"),
		desc = "Git Log File",
	},
	{
		"<leader>gB",
		safe_call(function()
			require("snacks").gitbrowse()
		end, "Error browsing git"),
		desc = "Git Browse",
		mode = { "n", "v" },
	},
	{
		"<leader>gK",
		safe_call(function()
			require("snacks").git.blame_line()
		end, "Error running git blame"),
		desc = "Git Blame Line",
		mode = { "n", "v" },
	},
}
