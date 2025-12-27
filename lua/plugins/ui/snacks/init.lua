return function()
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			_G.dd = function(...)
				pcall(require("snacks").debug.inspect, ...)
			end
			_G.bt = function()
				pcall(require("snacks").debug.backtrace)
			end

			if vim.fn.has("nvim-0.11") == 1 then
				vim._print = function(_, ...)
					pcall(_G.dd, ...)
				end
			else
				vim.print = _G.dd
			end

			local snacks = require("snacks")
			snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
			snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
			snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
			snacks.toggle.diagnostics():map("<leader>ud")
			snacks.toggle.line_number():map("<leader>ul")
			snacks.toggle
				.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
				:map("<leader>uc")
			snacks.toggle.treesitter():map("<leader>uT")
			snacks.toggle
				.option("background", { off = "light", on = "dark", name = "Dark Background" })
				:map("<leader>ub")
			snacks.toggle.inlay_hints():map("<leader>uh")
			snacks.toggle.indent():map("<leader>ug")
			snacks.toggle.dim():map("<leader>uD")
			snacks.toggle.profiler():map("<leader>pp")
			snacks.toggle.profiler_highlights():map("<leader>ph")
		end,
	})

	vim.api.nvim_create_autocmd("BufWinEnter", {
		pattern = "*",
		callback = function()
			local bufnr = vim.api.nvim_get_current_buf()
			if not vim.api.nvim_buf_is_valid(bufnr) then
				return
			end
		end,
	})

	vim.opt.signcolumn = "yes"

	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "*",
		callback = function()
			local bufname = vim.fn.bufname()
			if bufname:match("dashboard") or bufname:match("alpha") then
				vim.cmd("stopinsert")
			end
		end,
	})
end
