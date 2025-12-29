
local h = require("core.autocmds.helpers")

local M = {}

function M.setup()
	h.augroup("InsertModeOnEnter", { clear = true })
	h.autocmd("BufEnter", {
		group = "InsertModeOnEnter",
		pattern = "*",
		callback = function()
			vim.schedule(function()
				if not h.is_normal_buffer() then
					return
				end
				if vim.b._auto_insert_done then
					return
				end
				local bufname = vim.fn.bufname()
				local buftype = vim.bo.buftype
				if buftype == "" and not h.is_excluded_bufname(bufname) and not bufname:match("term://") then
					if vim.fn.mode() == "n" then
						vim.b._auto_insert_done = true
						vim.cmd("startinsert")
					end
				end
			end)
		end,
	})
end

return M
