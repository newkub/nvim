-- Utility functions for key mappings

local M = {}

--- Toggles or focuses the terminal window.
-- If in a terminal, hides it.
-- If a terminal exists but is hidden, shows it.
-- If no terminal exists, creates a new one.
function M.toggle_or_focus_terminal()
	local current_win = vim.api.nvim_get_current_win()
	local current_buf = vim.api.nvim_win_get_buf(current_win)

	if vim.bo[current_buf].buftype == "terminal" then
		vim.api.nvim_win_hide(current_win)
		return
	end

	local term_bufnr = nil
	local term_winnr = nil

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buftype == "terminal" and vim.api.nvim_buf_is_valid(buf) then
			term_bufnr = buf
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				if vim.api.nvim_win_get_buf(win) == buf then
					term_winnr = win
					break
				end
			end
			break
		end
	end

	if term_bufnr and not term_winnr then
		vim.cmd("botright split")
		vim.api.nvim_win_set_buf(0, term_bufnr)
		vim.cmd("startinsert")
	elseif term_winnr then
		vim.api.nvim_set_current_win(term_winnr)
		vim.cmd("startinsert")
	else
		require("snacks").terminal()
	end
end

--- Safely navigates to the dashboard.
-- Saves the current buffer if modified.
-- @param opts table|nil Optional parameters. `opts.force` to force navigation.
function M.safe_dashboard(opts)
	opts = opts or {}
	local bufname = vim.fn.bufname()
	if bufname:match("dashboard") or bufname:match("alpha") then
		return
	end
	if opts.force then
		pcall(require("snacks").dashboard, { force = true })
		return
	end
	if vim.api.nvim_buf_is_valid(0) and vim.api.nvim_buf_get_option(0, "modified") then
		pcall(vim.cmd, "write")
	end
	pcall(require("snacks").dashboard)
end

return M
