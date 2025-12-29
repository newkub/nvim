return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local ver = vim.version and vim.version() or { major = 0, minor = 0, patch = 0 }
			local has_011 = (vim.fn.has("nvim-0.11.0") == 1) or (ver.major == 0 and ver.minor >= 11)
			if not has_011 or not vim.lsp or type(vim.lsp.config) ~= "function" or type(vim.lsp.enable) ~= "function" then
				return
			end

			-- Use the new Nvim 0.11+ API. Do NOT require('lspconfig') to avoid deprecated framework warning.
			local servers = {}
			pcall(function()
				local mlsp = require("mason-lspconfig")
				if mlsp and type(mlsp.get_installed_servers) == "function" then
					servers = mlsp.get_installed_servers()
				end
			end)
			if #servers == 0 then
				servers = { "lua_ls", "ts_ls", "jsonls", "rust_analyzer", "pyright", "bashls", "cssls", "html" }
			end
			for _, server in ipairs(servers) do
				pcall(function()
					vim.lsp.config(server, { capabilities = capabilities })
					vim.lsp.enable(server)
				end)
			end
		end,
	},
}
