local M = {}

local function sys(cmd)
	local ok, out = pcall(vim.fn.system, cmd)
	if not ok then
		return nil
	end
	if vim.v.shell_error ~= 0 then
		return nil
	end
	return vim.trim(out)
end

local function git_info(cwd)
	local inside = sys({ "git", "-C", cwd, "rev-parse", "--is-inside-work-tree" })
	if inside ~= "true" then
		return nil
	end
	local branch = sys({ "git", "-C", cwd, "rev-parse", "--abbrev-ref", "HEAD" }) or "(detached)"
	local dirty = sys({ "git", "-C", cwd, "status", "--porcelain" })
	local clean = dirty == nil or dirty == ""
	return {
		branch = branch,
		clean = clean,
	}
end

local function center(text, width)
	local w = width or vim.o.columns
	local pad = math.max(math.floor((w - #text) / 2), 0)
	return string.rep(" ", pad) .. text
end

local function format_path(cwd)
	return vim.fn.fnamemodify(cwd, ":~")
end

function M.open(opts)
	opts = opts or {}
	local cwd = opts.cwd or vim.fn.getcwd()

	vim.cmd("enew")
	local bufnr = vim.api.nvim_get_current_buf()
	vim.bo[bufnr].buftype = "nofile"
	vim.bo[bufnr].bufhidden = "wipe"
	vim.bo[bufnr].swapfile = false
	vim.bo[bufnr].modifiable = true
	vim.bo[bufnr].filetype = "veerapong_home"

	local width = vim.o.columns
	local g = git_info(cwd)
	local lines = {
		"",
		center("Veerapong", width),
		"",
		center(format_path(cwd), width),
		"",
	}
	if g then
		local status = g.clean and "clean" or "dirty"
		local text = string.format("git: %s (%s)", g.branch, status)
		table.insert(lines, center(text, width))
	else
		table.insert(lines, center("git: (not a repo)", width))
	end
	
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
	vim.bo[bufnr].modifiable = false

	vim.keymap.set("n", "q", function()
		pcall(vim.cmd, "bd")
	end, { buffer = bufnr, silent = true })
end

function M.setup_keymap()
	vim.keymap.set({ "n", "i" }, "<Home>", function()
		require("core.start_screen").open({})
	end, { silent = true })
end

return M
