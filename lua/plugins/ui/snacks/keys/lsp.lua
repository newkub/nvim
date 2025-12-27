local safe_call = require("plugins.ui.snacks.keys.util").safe_call

return {
	{
		"gd",
		safe_call(function()
			require("snacks").picker.lsp_definitions()
		end, "Error opening LSP definitions picker"),
		desc = "Goto Definition",
	},
	{
		"gD",
		safe_call(function()
			require("snacks").picker.lsp_declarations()
		end, "Error opening LSP declarations picker"),
		desc = "Goto Declaration",
	},
	{
		"gr",
		safe_call(function()
			require("snacks").picker.lsp_references()
		end, "Error opening LSP references picker"),
		nowait = true,
		desc = "References",
	},
	{
		"gI",
		safe_call(function()
			require("snacks").picker.lsp_implementations()
		end, "Error opening LSP implementations picker"),
		desc = "Goto Implementation",
	},
	{
		"gy",
		safe_call(function()
			require("snacks").picker.lsp_type_definitions()
		end, "Error opening LSP type definitions picker"),
		desc = "Goto T[y]pe Definition",
	},
	{
		"<leader>ss",
		safe_call(function()
			require("snacks").picker.lsp_symbols()
		end, "Error opening LSP symbols picker"),
		desc = "LSP Symbols",
	},
	{
		"<leader>sS",
		safe_call(function()
			require("snacks").picker.lsp_workspace_symbols()
		end, "Error opening LSP workspace symbols picker"),
		desc = "LSP Workspace Symbols",
	},
}
