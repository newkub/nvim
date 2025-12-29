
local h = require("core.autocmds.helpers")

local M = {}

function M.setup()
	h.augroup("CursorPosition", { clear = true })
	h.autocmd("BufReadPost", {
		group = "CursorPosition",
		pattern = "*",
		callback = function()
			local bufname = vim.fn.bufname()
			if not h.is_excluded_bufname(bufname) then
				if h.is_normal_buffer() and not vim.b._view_loaded then
					vim.b._view_loaded = true
					pcall(vim.cmd, "silent! loadview")
				end
				pcall(function()
					local line = vim.fn.line("'\"")
					local col = vim.fn.col("'\"")
					if line > 0 and line <= vim.fn.line("$") then
						vim.api.nvim_win_set_cursor(0, { line, math.max(col - 1, 0) })
					end
				end)
			end
		end,
	})

	h.autocmd("BufWritePre", {
		group = "CursorPosition",
		pattern = "*",
		callback = function()
			if not h.is_normal_buffer() then
				return
			end
			local ft = vim.bo.filetype or ""
			if ft == "gitcommit" or ft == "gitrebase" or ft == "help" then
				return
			end
			local path = vim.fn.expand("%:p")
			if path ~= "" then
				local size = vim.fn.getfsize(path)
				if type(size) == "number" and size > 1024 * 1024 then
					return
				end
			end
			pcall(vim.cmd, "silent! mkview")
		end,
	})
end

return M
