
local M = {}

function M.get_current_file_path()
	local path = vim.fn.expand("%:p")
	if path == nil or path == "" then
		return nil
	end
	return path
end

function M.copy_path_action()
	local path = M.get_current_file_path()
	if not path then
		vim.notify("No file path", vim.log.levels.WARN)
		return
	end
	vim.fn.setreg("+", path)
	vim.notify("Copied path")
end

return M
