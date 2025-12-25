return {
	"ray-x/lsp_signature.nvim",
	event = "LspAttach",
	opts = {
		bind = true,
		handler_opts = { border = "rounded" },
	},
	config = function(_, opts)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("LspSignatureAttach", { clear = true }),
			callback = function(args)
				require("lsp_signature").on_attach(opts, args.buf)
			end,
		})
	end,
}
