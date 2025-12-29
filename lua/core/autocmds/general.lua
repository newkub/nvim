
local h = require("core.autocmds.helpers")

local M = {}

function M.setup()
	h.augroup("GeneralSettings", { clear = true })
	h.autocmd({ "FocusLost", "VimLeavePre" }, {
		group = "GeneralSettings",
		pattern = "*",
		callback = function()
			if not h.is_normal_buffer() then
				return
			end
			if vim.bo.modified then
				pcall(vim.cmd, "silent! write")
			end
		end,
	})
end

return M
