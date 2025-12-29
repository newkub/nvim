
local M = {}

function M.setup()
	require("core.autocmds.general").setup()
	require("core.autocmds.cursor").setup()
	require("core.autocmds.insert").setup()
	require("core.autocmds.picker").setup()
	require("core.autocmds.terminal").setup()
end

return M
