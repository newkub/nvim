local M = {}

local function get_current_file_path()
	local path = vim.fn.expand("%:p")
	if path == nil or path == "" then
		return nil
	end
	return path
end

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

local function get_project_root()
	local root = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })[1]
	if vim.v.shell_error == 0 and root and root ~= "" then
		return root
	end
	return vim.fn.getcwd()
end

local function open_terminal(cmd, cwd)
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

local function copy_path_action()
	local path = get_current_file_path()
	if not path then
		vim.notify("No file path", vim.log.levels.WARN)
		return
	end
	vim.fn.setreg("+", path)
	vim.notify("Copied path")
end

local function open_in_github_action()
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

local function gitui_action()
	if vim.fn.executable("gitui") ~= 1 then
		vim.notify("gitui not found in PATH", vim.log.levels.ERROR)
		return
	end
	pcall(function()
		require("snacks").terminal.open("gitui", { win = { style = "terminal" } })
	end)
end

function M.actions_picker()
	local ok_snacks, snacks = pcall(require, "snacks")
	if not ok_snacks or not snacks or not snacks.picker or type(snacks.picker.pick) ~= "function" then
		vim.notify("snacks.picker not available", vim.log.levels.ERROR)
		return
	end

	snacks.picker.pick({
		source = "actions",
		title = "Actions",
		items = {
			{ text = "Copy Path", value = "copy_path" },
			{ text = "Open in GitHub", value = "open_in_github" },
			{ text = "Run Task", value = "run_tasks" },
			{ text = "GitUI", value = "gitui" },
		},
		confirm = function(picker, item)
			picker:close()
			if not item or not item.value then
				return
			end
			vim.schedule(function()
				if item.value == "copy_path" then
					copy_path_action()
					return
				end
				if item.value == "open_in_github" then
					open_in_github_action()
					return
				end
				if item.value == "run_tasks" then
					M.run_tasks_picker()
					return
				end
				if item.value == "gitui" then
					gitui_action()
					return
				end
			end)
		end,
	})
end

function M.commands_picker()
	local ok_snacks, snacks = pcall(require, "snacks")
	if not ok_snacks or not snacks or not snacks.picker then
		vim.notify("snacks.picker not available", vim.log.levels.ERROR)
		return
	end

	if type(snacks.picker.commands) == "function" then
		pcall(function()
			snacks.picker.commands({
				confirm = function(picker, item)
					picker:close()
					if not item then
						return
					end
					local cmd = item.cmd or item.text or item.value
					if type(cmd) ~= "string" or cmd == "" then
						return
					end
					vim.schedule(function()
						pcall(vim.cmd, cmd)
					end)
				end,
			})
		end)
		return
	end

	if type(snacks.picker) == "function" then
		pcall(function()
			snacks.picker()
		end)
		return
	end
end

function M.smart_files()
	local ok_snacks, snacks = pcall(require, "snacks")
	if not ok_snacks or not snacks or not snacks.picker then
		vim.notify("snacks.picker not available", vim.log.levels.ERROR)
		return
	end

	local cwd = get_project_root()
	if type(snacks.picker.files) == "function" then
		pcall(function()
			snacks.picker.files({ cwd = cwd })
		end)
		return
	end
end

local function read_json_file(path)
	local ok, lines = pcall(vim.fn.readfile, path)
	if not ok or not lines then
		return nil
	end
	local content = table.concat(lines, "\n")
	local ok_decode, obj = pcall(vim.json.decode, content)
	if not ok_decode then
		return nil
	end
	return obj
end

local function read_file_lines(path)
	local ok, lines = pcall(vim.fn.readfile, path)
	if not ok then
		return nil
	end
	return lines
end

local function detect_node_runner(root)
	if vim.fn.filereadable(root .. "/pnpm-lock.yaml") == 1 then
		return "pnpm"
	end
	if vim.fn.filereadable(root .. "/yarn.lock") == 1 then
		return "yarn"
	end
	if vim.fn.filereadable(root .. "/package-lock.json") == 1 then
		return "npm"
	end
	return "npm"
end

local function get_package_json_scripts(root)
	local path = root .. "/package.json"
	if vim.fn.filereadable(path) ~= 1 then
		return {}
	end
	local obj = read_json_file(path)
	if not obj or type(obj) ~= "table" then
		return {}
	end
	local scripts = obj.scripts
	if type(scripts) ~= "table" then
		return {}
	end
	local items = {}
	for name, script in pairs(scripts) do
		items[#items + 1] = {
			text = "npm:" .. tostring(name),
			value = { kind = "npm", name = tostring(name), script = tostring(script or "") },
		}
	end
	table.sort(items, function(a, b)
		return a.text < b.text
	end)
	return items
end

local function get_cargo_aliases(root)
	local path = root .. "/Cargo.toml"
	if vim.fn.filereadable(path) ~= 1 then
		return {}
	end
	local lines = read_file_lines(path)
	if not lines then
		return {}
	end
	local in_alias = false
	local items = {}
	for _, line in ipairs(lines) do
		local trimmed = line:gsub("^%s+", ""):gsub("%s+$", "")
		if trimmed:match("^%[alias%]$") then
			in_alias = true
		elseif in_alias and trimmed:match("^%[") then
			in_alias = false
		elseif in_alias then
			local key, val = trimmed:match('^(%S+)%s*=%s*"(.*)"%s*$')
			if key and val then
				items[#items + 1] = {
					text = "cargo:" .. tostring(key),
					value = { kind = "cargo", name = tostring(key), cmd = tostring(val) },
				}
			end
		end
	end
	table.sort(items, function(a, b)
		return a.text < b.text
	end)
	return items
end

function M.run_tasks_picker()
	local ok_snacks, snacks = pcall(require, "snacks")
	if not ok_snacks or not snacks or not snacks.picker or type(snacks.picker.pick) ~= "function" then
		vim.notify("snacks.picker not available", vim.log.levels.ERROR)
		return
	end

	local root = get_project_root()
	local items = {}
	local npm_items = get_package_json_scripts(root)
	for i = 1, #npm_items do
		items[#items + 1] = npm_items[i]
	end
	local cargo_items = get_cargo_aliases(root)
	for i = 1, #cargo_items do
		items[#items + 1] = cargo_items[i]
	end

	if #items == 0 then
		vim.notify("No tasks found (package.json scripts / Cargo.toml [alias])", vim.log.levels.WARN)
		return
	end

	snacks.picker.pick({
		source = "run_tasks",
		title = "Run Task",
		items = items,
		confirm = function(picker, item)
			picker:close()
			if not item or not item.value or type(item.value) ~= "table" then
				return
			end
			vim.schedule(function()
				local v = item.value
				if v.kind == "npm" then
					local runner = detect_node_runner(root)
					local cmd = runner .. " run " .. v.name
					open_terminal(cmd, root)
					return
				end
				if v.kind == "cargo" then
					open_terminal("cargo " .. v.name, root)
					return
				end
			end)
		end,
	})
end

function M.setup()
	vim.api.nvim_create_user_command("GitUI", function()
		gitui_action()
	end, { desc = "Open gitui" })

	vim.api.nvim_create_user_command("CopyPath", function()
		copy_path_action()
	end, { desc = "Copy current file path" })

	vim.api.nvim_create_user_command("OpenInGitHub", function()
		open_in_github_action()
	end, { desc = "Open GitHub repository" })

	vim.api.nvim_create_user_command("Actions", function()
		M.actions_picker()
	end, { desc = "Actions menu" })

	vim.api.nvim_create_user_command("SmartFiles", function()
		M.smart_files()
	end, { desc = "Smart file picker" })

	vim.api.nvim_create_user_command("RunTasks", function()
		M.run_tasks_picker()
	end, { desc = "Run tasks (package.json / Cargo.toml)" })
end

return M
