
local h = require("core.autocmds.helpers")

local M = {}

function M.setup()
	h.augroup("TerminalSettings", { clear = true })
	h.autocmd("TermOpen", {
		group = "TerminalSettings",
		pattern = "*",
		callback = function()
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
			vim.opt_local.signcolumn = "no"
			vim.cmd("startinsert")
		end,
	})
end

return M
