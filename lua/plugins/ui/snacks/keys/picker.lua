local function extend(dst, src)
	for i = 1, #src do
		dst[#dst + 1] = src[i]
	end
end

local files = require("plugins.ui.snacks.keys.picker.files")
local buffers = require("plugins.ui.snacks.keys.picker.buffers")
local search = require("plugins.ui.snacks.keys.picker.search")
local meta = require("plugins.ui.snacks.keys.picker.meta")

local keys = {}
extend(keys, files)
extend(keys, buffers)
extend(keys, search)
extend(keys, meta)

return keys
