return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false,
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
	opts = {
		instructions_file = "avante.md",
		provider = "openai",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"folke/snacks.nvim",
		"nvim-tree/nvim-web-devicons",
	},
}
