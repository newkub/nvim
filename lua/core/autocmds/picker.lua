
local h = require("core.autocmds.helpers")

local M = {}

function M.setup()
	h.augroup("AutoFilePicker", { clear = true })

	h.autocmd("User", {
		group = "AutoFilePicker",
		pattern = "VeryLazy",
		once = true,
		callback = function()
			if vim.fn.argc() ~= 0 then
				return
			end

			local tries = 0
			local did_load_snacks = false
			local function open_picker()
				tries = tries + 1
				local delay = math.min(120 * (2 ^ (tries - 1)), 800)
				if not did_load_snacks then
					did_load_snacks = true
					pcall(function()
						local ok_lazy, lazy = pcall(require, "lazy")
						if ok_lazy and lazy and type(lazy.load) == "function" then
							lazy.load({ plugins = { "snacks.nvim" } })
						end
					end)
				end

				local ok_snacks, snacks = pcall(require, "snacks")
				if ok_snacks and snacks and snacks.picker then
					pcall(function()
						require("core.commands").smart_files()
					end)
					return
				end
				if tries < 4 then
					vim.defer_fn(open_picker, delay)
				end
			end

			vim.defer_fn(open_picker, 120)
		end,
	})
end

return M
