return {
	["<S-F2>"] = {
		function()
			require("snacks").rename.rename_file()
		end,
		"Rename File",
		{ noremap = true, silent = true },
	},

	["<S-F3>"] = {
		function()
			local file = vim.fn.expand("%:p")
			if file == "" then
				return
			end
			local ok = vim.fn.confirm("Delete file?\n" .. file, "&Yes\n&No", 2)
			if ok ~= 1 then
				return
			end
			vim.cmd("silent! bdelete")
			pcall(function()
				vim.fn.delete(file)
			end)
		end,
		"Delete File",
		{ noremap = true, silent = true },
	},

	["<S-F4>"] = {
		function()
			local src = vim.fn.expand("%:p")
			if src == "" then
				return
			end
			local dst = vim.fn.input("Copy to: ", src)
			if dst == "" or dst == src then
				return
			end
			local uv = vim.uv or vim.loop
			local ok = false
			if uv and uv.fs_copyfile then
				ok = pcall(uv.fs_copyfile, src, dst)
			end
			if not ok then
				vim.notify("Copy failed", vim.log.levels.ERROR)
				return
			end
			vim.notify("Copied to: " .. dst)
		end,
		"Copy File",
		{ noremap = true, silent = true },
	},

	["<S-F5>"] = {
		function()
			local path = vim.fn.expand("%:p")
			if path == "" then
				return
			end
			vim.fn.setreg("+", path)
			vim.notify("Copied path")
		end,
		"Copy Path",
		{ noremap = true, silent = true },
	},
}
