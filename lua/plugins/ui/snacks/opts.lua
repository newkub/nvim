return {
	bigfile = {},
	dashboard = {
		enabled = true,
		sections = {
			{ section = "header" },
			{
				section = "keys",
				gap = 1,
				padding = 1,
				keys = {
					{ "f", "<cmd>lua require('snacks').picker.files()<cr>", "Find File" },
					{ "n", "<cmd>enew<cr>", "New File" },
					{ "p", "<cmd>lua require('snacks').picker.projects()<cr>", "Projects" },
					{ "g", "<cmd>lua require('snacks').picker.git_files()<cr>", "Git Files" },
					{ "r", "<cmd>lua require('snacks').picker.recent()<cr>", "Recent Files" },
				},
			},
			{ section = "startup" },
		},
	},
	dim = {},
	gh = {},
	git = {},
	gitbrowse = {},
	image = {},
	indent = { enabled = false },
	lazygit = {},
	input = {
		win = {
			b = {
				completion = true,
			},
		},
	},
	notifier = { enabled = true, timeout = 3000 },
	picker = {
		enabled = true,
		ui = "snacks",
		sources = {
			files = { hidden = true, follow = true },
			gh_issue = {},
			gh_pr = {},
		},
		hooks = {
			on_error = function(err)
				vim.notify("Picker error: " .. tostring(err), vim.log.levels.ERROR)
			end,
		},
		win = {
			input = {
				keys = {
					["<C-p>"] = { "picker_files", mode = { "n", "i" } },
					["<C-r>"] = { "picker_recent", mode = { "n", "i" } },
					["<BS>"] = {
						function(picker)
							local ok, word = pcall(function()
								return picker:word()
							end)
							if ok and (word == nil or word == "") then
								pcall(function()
									picker:action("close")
								end)
								return ""
							end
							return "<BS>"
						end,
						mode = "i",
						expr = true,
						desc = "Backspace (close when empty)",
					},
					["<Esc>"] = { "close", mode = { "n", "i" } },
					["<C-c>"] = { "close", mode = { "n", "i" } },
				},
			},
			list = {
				keys = {
					["<Esc>"] = { "close", mode = { "n", "i" } },
					["<C-c>"] = { "close", mode = { "n", "i" } },
				},
			},
			preview = {
				keys = {
					["<Esc>"] = { "close", mode = { "n", "i" } },
					["<C-c>"] = { "close", mode = { "n", "i" } },
				},
			},
		},
	},
	profiler = {},
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = {},
	statuscolumn = {
		enabled = true,
		left = { "mark", "sign" },
		right = { "fold", "git" },
		folds = {
			open = true,
			git_hl = true,
		},
		git = {
			patterns = { "GitSign", "MiniDiffSign" },
		},
		refresh = 50,
	},
	terminal = {
		win = {
			style = "terminal",
		},
		shell = require("core.utils").get_default_shell(),
	},
	words = { enabled = false },
	styles = {
		input = {
			b = {
				completion = true,
			},
		},
		notification = {},
	},
}
