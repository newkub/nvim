return {
	{
		"dmtrKovalenko/fff.nvim",
		name = "fff.nvim",
		lazy = false,
		build = function()
			require("fff.download").download_or_build_binary()
		end,
		opts = {
			lazy_sync = true,
		},
	},
}
