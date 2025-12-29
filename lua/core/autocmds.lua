-- Autocommands for Neovim

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function is_normal_buffer()
	if vim.bo.buftype ~= "" then
		return false
	end
	if vim.fn.expand("%") == "" then
		return false
	end
	return true
end

local function is_excluded_bufname(bufname)
	if bufname == "" then
		return true
	end
	if bufname:match("dashboard") or bufname:match("alpha") or bufname:match("NvimTree") then
		return true
	end
	return false
end

-- General settings
augroup("GeneralSettings", { clear = true })
-- autocmd("VimLeavePre", {
--   group = "GeneralSettings",
--   pattern = "*",
--   callback = function()
--     vim.cmd("silent! wa")
--   end,
-- })
-- autocmd("FocusLost", {
-- 	group = "GeneralSettings",
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.fn.expand("%") ~= "" then
-- 			vim.cmd("silent! wa")
-- 		end
-- 	end,
-- })
-- autocmd("TermClose", {
-- 	group = "GeneralSettings",
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.cmd("silent! wa")
-- 	end,
-- })

autocmd({ "FocusLost", "VimLeavePre" }, {
	group = "GeneralSettings",
	pattern = "*",
	callback = function()
		if not is_normal_buffer() then
			return
		end
		vim.cmd("silent! wall")
	end,
})

-- Swap file management
augroup("SwapFileManagement", { clear = true })
autocmd("BufWritePre", {
	group = "SwapFileManagement",
	pattern = "*",
	callback = function()
		vim.opt_local.swapfile = false
	end,
})
autocmd("BufWritePost", {
	group = "SwapFileManagement",
	pattern = "*",
	callback = function()
		vim.opt_local.swapfile = true
	end,
})

-- Cursor position
augroup("CursorPosition", { clear = true })
autocmd("BufReadPost", {
	group = "CursorPosition",
	pattern = "*",
	callback = function()
		local bufname = vim.fn.bufname()
		if not is_excluded_bufname(bufname) then
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
autocmd("BufWritePre", {
	group = "CursorPosition",
	pattern = "*",
	callback = function()
		if not is_normal_buffer() then
			return
		end
		pcall(vim.cmd, "silent! mkview")
	end,
})
autocmd("BufWinEnter", {
	group = "CursorPosition",
	pattern = "*",
	callback = function()
		if not is_normal_buffer() then
			return
		end
		pcall(vim.cmd, "silent! loadview")
	end,
})

-- NOTE: CodeiumTabAccept was removed/disabled to avoid AI/word suggestions.

-- Insert mode on enter
augroup("InsertModeOnEnter", { clear = true })
autocmd("BufEnter", {
	group = "InsertModeOnEnter",
	pattern = "*",
	callback = function()
		-- ใช้ vim.schedule เพื่อหน่วงเวลาให้ buffer พร้อมก่อน
		vim.schedule(function()
			if not is_normal_buffer() then
				return
			end
			if vim.b._auto_insert_done then
				return
			end
			local bufname = vim.fn.bufname()
			local buftype = vim.bo.buftype
			-- เข้า insert mode เมื่อเปิดไฟล์ปกติเท่านั้น
			if
				buftype == ""
				and not is_excluded_bufname(bufname)
				and not bufname:match("term://")
			then
				-- เช็คว่ายังอยู่ใน normal mode
				if vim.fn.mode() == "n" then
					vim.b._auto_insert_done = true
					vim.cmd("startinsert")
				end
			end
		end)
	end,
})

-- Auto file picker
augroup("AutoFilePicker", { clear = true })

autocmd("VimEnter", {
	group = "AutoFilePicker",
	pattern = "*",
	once = true,
	callback = function()
		if vim.fn.argc() ~= 0 then
			return
		end
		return
	end,
})

autocmd("User", {
	group = "AutoFilePicker",
	pattern = "VeryLazy",
	once = true,
	callback = function()
		if vim.fn.argc() ~= 0 then
			return
		end

		local tries = 0
		local did_load_snacks = false
		local function open_picker()
			tries = tries + 1
			if not did_load_snacks then
				did_load_snacks = true
				pcall(function()
					local ok_lazy, lazy = pcall(require, "lazy")
					if ok_lazy and lazy and type(lazy.load) == "function" then
						lazy.load({ plugins = { "snacks.nvim" } })
					end
				end)
			end

			local ok_snacks, snacks = pcall(require, "snacks")
			if ok_snacks and snacks and snacks.picker then
				pcall(function()
					require("core.commands").smart_files()
				end)
				return
			end
			if tries < 10 then
				vim.defer_fn(open_picker, 120)
			end
		end

		vim.defer_fn(open_picker, 120)
	end,
})

-- Terminal settings
augroup("TerminalSettings", { clear = true })
autocmd("TermOpen", {
	group = "TerminalSettings",
	pattern = "*",
	callback = function()
		-- ปิด line numbers ใน terminal
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"

		-- ตั้งค่าให้ terminal เข้า insert mode อัตโนมัติ
		vim.cmd("startinsert")
	end,
})
