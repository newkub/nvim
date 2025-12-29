
local M = {}

function M.open_terminal(cmd, cwd)
	local ok_snacks, snacks = pcall(require, "snacks")
	if ok_snacks and snacks and snacks.terminal and type(snacks.terminal.open) == "function" then
		pcall(function()
			snacks.terminal.open(cmd, { cwd = cwd, win = { style = "terminal" } })
		end)
		return
	end
	pcall(function()
		vim.cmd("terminal " .. cmd)
	end)
end

function M.gitui_action()
	if vim.fn.executable("gitui") ~= 1 then
		vim.notify("gitui not found in PATH", vim.log.levels.ERROR)
		return
	end
	pcall(function()
		require("snacks").terminal.open("gitui", { win = { style = "terminal" } })
	end)
end

return M
