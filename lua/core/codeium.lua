local M = {}

function M.accept_or_tab()
	local ok_vt, vt = pcall(require, "codeium.virtual_text")
	if ok_vt and vt and type(vt.accept) == "function" then
		local ok_accept, accepted = pcall(vt.accept)
		if ok_accept and type(accepted) == "string" and accepted ~= "" then
			return accepted
		end
	end

	local ok_fn, accepted_fn = pcall(function()
		return vim.fn["codeium#Accept"]("")
	end)
	if ok_fn and type(accepted_fn) == "string" and accepted_fn ~= "" then
		return accepted_fn
	end

	return "<Tab>"
end

function M.setup_tab_mapping()
	if vim.g._codeium_tab_accept_mapped then
		return
	end
	vim.g._codeium_tab_accept_mapped = true

	vim.keymap.set("i", "<Tab>", M.accept_or_tab, {
		noremap = true,
		silent = true,
		expr = true,
		replace_keycodes = true,
	})
end

return M
