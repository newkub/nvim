local function extend(dst, src)
	for i = 1, #src do
		dst[#dst + 1] = src[i]
	end
end

local commands = require("plugins.ui.snacks.keys.picker.groups.commands")
local lists = require("plugins.ui.snacks.keys.picker.groups.lists")
local misc = require("plugins.ui.snacks.keys.picker.groups.misc")
local diagnostics = require("plugins.ui.snacks.keys.picker.groups.diagnostics")
local ui = require("plugins.ui.snacks.keys.picker.groups.ui")
local vim = require("plugins.ui.snacks.keys.picker.groups.vim")

local keys = {}
extend(keys, commands)
extend(keys, lists)
extend(keys, misc)
extend(keys, diagnostics)
extend(keys, ui)
extend(keys, vim)

return keys
