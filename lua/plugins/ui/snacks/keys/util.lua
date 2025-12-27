local M = {}

function M.safe_call(fn, error_msg)
	return function()
		local status, err = pcall(fn)
		if not status then
			vim.notify((error_msg or "Error") .. ": " .. tostring(err), vim.log.levels.ERROR)
		end
	end
end

return M
