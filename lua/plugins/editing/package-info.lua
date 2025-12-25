return {
	"vuki656/package-info.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "MunifTanjim/nui.nvim" },
	config = function()
		require("package-info").setup({
			package_manager = "bun",
		})
	end,
	keys = {
		{ "<leader>ns", function() require("package-info").show() end, desc = "Package Info: Show" },
		{ "<leader>nc", function() require("package-info").hide() end, desc = "Package Info: Hide" },
		{ "<leader>nt", function() require("package-info").toggle() end, desc = "Package Info: Toggle" },
		{ "<leader>nu", function() require("package-info").update() end, desc = "Package Info: Update" },
		{ "<leader>nd", function() require("package-info").delete() end, desc = "Package Info: Delete" },
		{ "<leader>ni", function() require("package-info").install() end, desc = "Package Info: Install" },
		{ "<leader>np", function() require("package-info").change_version() end, desc = "Package Info: Change Version" },
	}
}
