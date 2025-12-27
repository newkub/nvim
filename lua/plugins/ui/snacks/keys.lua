local function extend(dst, src)
	for i = 1, #src do
		dst[#dst + 1] = src[i]
	end
end

local picker = require("plugins.ui.snacks.keys.picker")
local git = require("plugins.ui.snacks.keys.git")
local lsp = require("plugins.ui.snacks.keys.lsp")
local terminal = require("plugins.ui.snacks.keys.terminal")
local misc = require("plugins.ui.snacks.keys.misc")

local keys = {}
extend(keys, picker)
extend(keys, git)
extend(keys, lsp)
extend(keys, terminal)
extend(keys, misc)

return keys
