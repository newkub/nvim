return {
	{
		"mikavilpas/yazi.nvim",
		version = "*",
		event = "VeryLazy",
		dependencies = { { "nvim-lua/plenary.nvim", lazy = true } },
		config = function(_, opts)
			require("yazi").setup(opts)

			local augroup = vim.api.nvim_create_augroup("YaziModeRestore", { clear = true })
			vim.api.nvim_create_autocmd("BufLeave", {
				group = augroup,
				pattern = "*",
				callback = function(ev)
					local bt = vim.bo[ev.buf].buftype or ""
					local ft = vim.bo[ev.buf].filetype or ""
					local name = vim.api.nvim_buf_get_name(ev.buf) or ""
					if bt ~= "terminal" and bt ~= "nofile" and bt ~= "prompt" then
						return
					end
					if not ft:match("yazi") and not name:lower():match("yazi") then
						return
					end
					if vim.g._yazi_prev_mode == "i" then
						vim.schedule(function()
							pcall(vim.cmd, "startinsert")
						end)
					end
					vim.g._yazi_prev_mode = nil
				end,
			})
		end,
		opts = {
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
		keys = {
			{
				"<A-m>",
				function()
					local mode = vim.api.nvim_get_mode().mode
					vim.g._yazi_prev_mode = (mode:sub(1, 1) == "i") and "i" or "n"
					vim.cmd("Yazi toggle")
				end,
				mode = { "n", "i", "v", "s", "t", "x" },
				desc = "Yazi (Toggle)",
			},
		},
	},
}
