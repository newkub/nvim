
local M = {}

local function normalize_remote_url(url)
	if not url or url == "" then
		return nil
	end
	-- git@github.com:org/repo.git
	local ssh_org_repo = url:match("^git@github%.com:(.+)%.git$")
	if ssh_org_repo then
		return "https://github.com/" .. ssh_org_repo
	end
	-- https://github.com/org/repo.git
	local https_org_repo = url:match("^https://github%.com/(.+)%.git$")
	if https_org_repo then
		return "https://github.com/" .. https_org_repo
	end
	-- https://github.com/org/repo
	local https_plain = url:match("^https://github%.com/.+")
	if https_plain then
		return url
	end
	return nil
end

local function open_url(url)
	if not url or url == "" then
		return
	end
	if vim.ui and type(vim.ui.open) == "function" then
		pcall(vim.ui.open, url)
		return
	end
	pcall(function()
		vim.fn.jobstart({ "cmd.exe", "/c", "start", "", url }, { detach = true })
	end)
end

function M.open_in_github_action()
	local root = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })[1]
	if not root or root == "" then
		vim.notify("Not a git repository", vim.log.levels.WARN)
		return
	end
	local remote = vim.fn.systemlist({ "git", "config", "--get", "remote.origin.url" })[1]
	local repo_url = normalize_remote_url(remote)
	if not repo_url then
		vim.notify("Unsupported remote URL: " .. tostring(remote), vim.log.levels.WARN)
		return
	end
	open_url(repo_url)
end

return M
