local M = {}

function M.toggle_or_focus_terminal()
	require("snacks").terminal.toggle(nil, { win = { style = "terminal" } })
end

function M.toggle_right_terminal()
	require("snacks").terminal.toggle(nil, { win = { position = "right", style = "terminal" } })
end

function M.open_floating_pwsh_terminal()
	pcall(function()
		require("snacks").terminal.open("pwsh", { win = { style = "float" } })
	end)
end

function M.go_home()
	vim.schedule(function()
		local mode = vim.api.nvim_get_mode().mode
		if mode == "t" then
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
		elseif mode:sub(1, 1) == "i" then
			vim.cmd("stopinsert")
		elseif mode == "v" or mode == "V" or mode == "\22" or mode == "s" or mode == "S" or mode == "\19" then
			vim.cmd("normal! <Esc>")
		end

		pcall(function()
			require("snacks").picker.close()
		end)
		pcall(function()
			vim.cmd("silent! cclose")
		end)
		pcall(function()
			vim.cmd("silent! lclose")
		end)
		pcall(function()
			vim.cmd("silent! noautocmd wincmd o")
		end)
		pcall(function()
			require("snacks").dashboard()
		end)
	end)
end

function M.open_cmdline()
	local ft = vim.bo.filetype or ""
	local bt = vim.bo.buftype or ""
	local name = vim.fn.bufname() or ""
	if bt == "prompt" or bt == "nofile" then
		return
	end
	if ft:match("snacks") or name:lower():match("snacks") then
		return
	end

	vim.schedule(function()
		local mode = vim.api.nvim_get_mode().mode
		if mode == "t" then
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
		elseif mode:sub(1, 1) == "i" then
			vim.cmd("stopinsert")
		elseif mode == "v" or mode == "V" or mode == "\22" or mode == "s" or mode == "S" or mode == "\19" then
			vim.cmd("normal! <Esc>")
		end

		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":", true, false, true), "n", false)
	end)
end

function M.delete_current_line_keep_insert()
	local pos = vim.api.nvim_win_get_cursor(0)
	local row = pos[1]
	local col = pos[2]
	vim.api.nvim_buf_set_lines(0, row - 1, row, false, {})
	local last_row = vim.api.nvim_buf_line_count(0)
	local target_row = math.min(row, last_row)
	local target_line = vim.api.nvim_buf_get_lines(0, target_row - 1, target_row, false)[1] or ""
	local target_col = math.min(col, math.max(#target_line - 1, 0))
	vim.api.nvim_win_set_cursor(0, { target_row, target_col })
	vim.cmd("startinsert")
end

return M
