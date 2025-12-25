return {
	"petertriho/nvim-scrollbar",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("scrollbar").setup({
			hide_if_all_visible = true,
			handle = {
				color = "#6e7681",
			},
			marks = {
				Cursor = { text = " " },
				Search = { text = { "-", "=" } },
				Error = { text = { "-", "=" } },
				Warn = { text = { "-", "=" } },
				Info = { text = { "-", "=" } },
				Hint = { text = { "-", "=" } },
				Misc = { text = { "-", "=" } },
				GitAdd = { text = "┃" },
				GitChange = { text = "┃" },
				GitDelete = { text = "▁" },
			},
		})
	end,
}
