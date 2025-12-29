
local M = {}

function M.get_project_root()
	local root = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })[1]
	if vim.v.shell_error == 0 and root and root ~= "" then
		return root
	end
	return vim.fn.getcwd()
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
	if vim.fn.filereadable(root .. "/bun.lockb") == 1 then
		return "bun"
	end
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

function M.build_task_items(root)
	local items = {}
	local npm_items = get_package_json_scripts(root)
	for i = 1, #npm_items do
		items[#items + 1] = npm_items[i]
	end
	local cargo_items = get_cargo_aliases(root)
	for i = 1, #cargo_items do
		items[#items + 1] = cargo_items[i]
	end
	return items
end

function M.detect_node_runner(root)
	return detect_node_runner(root)
end

return M
