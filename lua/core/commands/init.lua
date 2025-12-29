
local M = {}

local pickers = require("core.commands.pickers")

function M.actions_picker()
	return pickers.actions_picker()
end

function M.commands_picker()
	return pickers.commands_picker()
end

function M.smart_files()
	return pickers.smart_files()
end

function M.run_tasks_picker()
	return pickers.run_tasks_picker()
end

function M.setup()
	vim.api.nvim_create_user_command("Actions", function()
		M.actions_picker()
	end, { desc = "Actions menu" })

	vim.api.nvim_create_user_command("SmartFiles", function()
		M.smart_files()
	end, { desc = "Smart file picker" })

	vim.api.nvim_create_user_command("RunTasks", function()
		M.run_tasks_picker()
	end, { desc = "Run tasks (package.json / Cargo.toml)" })

	vim.api.nvim_create_user_command("Commands", function()
		M.commands_picker()
	end, { desc = "Commands picker" })
end

return M
