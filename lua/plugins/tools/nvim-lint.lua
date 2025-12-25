return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local lint = require("lint")

			local function parse_oxlint_json(output)
				local ok, decoded = pcall(vim.json.decode, output)
				if not ok or type(decoded) ~= "table" then
					return {}
				end
				local diags = {}
				local diagnostics = decoded.diagnostics or decoded
				if type(diagnostics) ~= "table" then
					return {}
				end
				for _, d in ipairs(diagnostics) do
					local span = d.span or {}
					local sev = vim.diagnostic.severity.WARN
					local s = (d.severity or d.level or "")
					if s == "error" or s == "ERROR" then
						sev = vim.diagnostic.severity.ERROR
					elseif s == "info" or s == "INFO" then
						sev = vim.diagnostic.severity.INFO
					elseif s == "hint" or s == "HINT" then
						sev = vim.diagnostic.severity.HINT
					end
					local lnum = math.max((span.start_line or 1) - 1, 0)
					local col = math.max((span.start_col or 1) - 1, 0)
					local end_lnum = math.max((span.end_line or (span.start_line or 1)) - 1, 0)
					local end_col = math.max((span.end_col or (span.start_col or 1)) - 1, 0)
					table.insert(diags, {
						lnum = lnum,
						col = col,
						end_lnum = end_lnum,
						end_col = end_col,
						severity = sev,
						message = tostring(d.message or ""),
						code = d.rule_id or d.code,
						source = "oxlint",
					})
				end
				return diags
			end

			lint.linters.oxlint = {
				cmd = "oxlint",
				args = { "--format", "json", "--stdin", "--stdin-filename", "%filepath" },
				stdin = true,
				ignore_exitcode = true,
				parser = parse_oxlint_json,
			}

			lint.linters.tsc_noemit = {
				cmd = "bunx",
				args = { "--no-install", "tsc", "--noEmit", "--pretty", "false" },
				stdin = false,
				ignore_exitcode = true,
				append_fname = false,
				parser = require("lint.parser").from_errorformat(
					"%f(%l\\,%c): %trror %m",
					{ source = "tsc" }
				),
			}

			lint.linters.vuetsc_noemit = {
				cmd = "bunx",
				args = { "--no-install", "vue-tsc", "--noEmit", "--pretty", "false" },
				stdin = false,
				ignore_exitcode = true,
				append_fname = false,
				parser = require("lint.parser").from_errorformat(
					"%f(%l\\,%c): %trror %m",
					{ source = "vue-tsc" }
				),
			}

			lint.linters_by_ft = {
				javascript = { "oxlint" },
				javascriptreact = { "oxlint" },
				typescript = { "oxlint", "tsc_noemit" },
				typescriptreact = { "oxlint", "tsc_noemit" },
				vue = { "oxlint", "vuetsc_noemit" },
			}

			local group = vim.api.nvim_create_augroup("NvimLint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = group,
				callback = function()
					pcall(function()
						require("lint").try_lint()
					end)
				end,
			})
		end,
	},
}
