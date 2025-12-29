
local M = {}

M.augroup = vim.api.nvim_create_augroup
M.autocmd = vim.api.nvim_create_autocmd

function M.is_normal_buffer()
	if vim.bo.buftype ~= "" then
		return false
	end
	if vim.fn.expand("%") == "" then
		return false
	end
	return true
end

function M.is_excluded_bufname(bufname)
	if bufname == "" then
		return true
	end
	if bufname:match("dashboard") or bufname:match("alpha") or bufname:match("NvimTree") then
		return true
	end
	return false
end

return M
