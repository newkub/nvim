local maps = {}

maps = vim.tbl_deep_extend("force", maps, require("mappings.normal.file"))
maps = vim.tbl_deep_extend("force", maps, require("mappings.normal.terminal"))
maps = vim.tbl_deep_extend("force", maps, require("mappings.normal.search"))
maps = vim.tbl_deep_extend("force", maps, require("mappings.normal.system"))
maps = vim.tbl_deep_extend("force", maps, require("mappings.normal.editing"))

return maps
