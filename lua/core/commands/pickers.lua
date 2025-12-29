
local M = {}

local path = require("core.commands.path")
local git = require("core.commands.git")
local tasks = require("core.commands.tasks")
local term = require("core.commands.terminal")

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
					path.copy_path_action()
					return
				end
				if item.value == "open_in_github" then
					git.open_in_github_action()
					return
				end
				if item.value == "run_tasks" then
					M.run_tasks_picker()
					return
				end
				if item.value == "gitui" then
					term.gitui_action()
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

	local cwd = tasks.get_project_root()
	if type(snacks.picker.files) == "function" then
		pcall(function()
			snacks.picker.files({ cwd = cwd })
		end)
		return
	end
end

function M.run_tasks_picker()
	local ok_snacks, snacks = pcall(require, "snacks")
	if not ok_snacks or not snacks or not snacks.picker or type(snacks.picker.pick) ~= "function" then
		vim.notify("snacks.picker not available", vim.log.levels.ERROR)
		return
	end

	local root = tasks.get_project_root()
	local items = tasks.build_task_items(root)
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
					local runner = tasks.detect_node_runner(root)
					local cmd = runner .. " run " .. v.name
					term.open_terminal(cmd, root)
					return
				end
				if v.kind == "cargo" then
					term.open_terminal("cargo " .. v.name, root)
					return
				end
			end)
		end,
	})
end

return M
