
local h = require("core.autocmds.helpers")

local M = {}

function M.setup()
	h.augroup("SwapFileManagement", { clear = true })
	h.autocmd("BufWritePre", {
		group = "SwapFileManagement",
		pattern = "*",
		callback = function()
			vim.opt_local.swapfile = false
		end,
	})
	h.autocmd("BufWritePost", {
		group = "SwapFileManagement",
		pattern = "*",
		callback = function()
			vim.opt_local.swapfile = true
		end,
	})
end

return M
