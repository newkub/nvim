-- VS Code style system operations key mappings for Neovim

local function toggle_or_focus_terminal()
	require("snacks").terminal.toggle(nil, { win = { style = "terminal" } })
end

local function toggle_right_terminal()
	require("snacks").terminal.toggle(nil, { win = { position = "right", style = "terminal" } })
end

local function open_floating_pwsh_terminal()
	pcall(function()
		require("snacks").terminal.open("pwsh", { win = { style = "float" } })
	end)
end

local function go_home()
	vim.schedule(function()
		local mode = vim.api.nvim_get_mode().mode
		if mode == "t" then
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
		elseif mode:sub(1, 1) == "i" then
			vim.cmd("stopinsert")
		elseif mode == "v" or mode == "V" or mode == "\22" or mode == "s" or mode == "S" or mode == "\19" then
			vim.cmd("normal! <Esc>")
		end

		pcall(function()
			require("snacks").picker.close()
		end)
		pcall(function()
			vim.cmd("silent! cclose")
		end)
		pcall(function()
			vim.cmd("silent! lclose")
		end)
		pcall(function()
			vim.cmd("silent! noautocmd wincmd o")
		end)
		pcall(function()
			require("snacks").dashboard()
		end)
	end)
end

local function open_cmdline()
	vim.schedule(function()
		local mode = vim.api.nvim_get_mode().mode
		if mode == "t" then
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
		elseif mode:sub(1, 1) == "i" then
			vim.cmd("stopinsert")
		elseif mode == "v" or mode == "V" or mode == "\22" or mode == "s" or mode == "S" or mode == "\19" then
			vim.cmd("normal! <Esc>")
		end

		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":", true, false, true), "n", false)
	end)
end

local function delete_current_line_keep_insert()
	local pos = vim.api.nvim_win_get_cursor(0)
	local row = pos[1]
	local col = pos[2]
	vim.api.nvim_buf_set_lines(0, row - 1, row, false, {})
	local last_row = vim.api.nvim_buf_line_count(0)
	local target_row = math.min(row, last_row)
	local target_line = vim.api.nvim_buf_get_lines(0, target_row - 1, target_row, false)[1] or ""
	local target_col = math.min(col, math.max(#target_line - 1, 0))
	vim.api.nvim_win_set_cursor(0, { target_row, target_col })
	vim.cmd("startinsert")
end

return {
    n = {
        -- Command Palette (VS Code style: F1)
        ["<F1>"] = {
            function()
                require("snacks").picker()
            end,
            "Command Palette",
            { noremap = true, silent = true },
        },

        ["<Esc>"] = { "i", "Toggle Insert Mode", { noremap = true, silent = true } },

        -- Rename File (VS Code style: Shift+F2)
        ["<S-F2>"] = {
            function()
                require("snacks").rename.rename_file()
            end,
            "Rename File",
            { noremap = true, silent = true },
        },

        -- Delete File (VS Code style: Shift+F3)
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

        -- Copy File (VS Code style: Shift+F4)
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

        -- Copy Path (VS Code style: Shift+F5)
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

        -- Open Terminal (VS Code style: Ctrl+`)
        ["<C-`>"] = { function() vim.cmd("terminal " .. require("core.utils").get_default_shell()) end, "Open Terminal" },

        -- Quit Neovim (safer version)
        ["<C-c>"] = { "<cmd>qa!<cr>", "Force Quit Neovim", { noremap = true, silent = true } },

        -- Toggle/Focus Terminal
        ["<C-l>"] = { toggle_or_focus_terminal, "Toggle/Focus Terminal" },
        ["<C-S-Right>"] = { toggle_right_terminal, "Open Right Terminal" },

        -- Undo/Redo (Standard Vim keys)
        ["<C-z>"] = { "u", "Undo" },
        ["<C-S-z>"] = { "<C-r>", "Redo" },
        ["<C-y>"] = { "<C-r>", "Redo" }, -- Alternative for Redo

        -- Grep Search
        ["<C-S-s>"] = {
            function()
                require("snacks").picker.grep()
            end,
            "Grep Search",
            { noremap = true, silent = true },
        },
        ["<C-s>"] = {
            function()
                require("snacks").picker.grep()
            end,
            "Grep Search",
            { noremap = true, silent = true },
        },
		["<Home>"] = {
			go_home,
			"Go Home",
			{ noremap = true, silent = true },
		},

		[":"] = {
			open_cmdline,
			"Command Line",
			{ noremap = true, silent = true },
		},
    },

    i = {
        -- Command Palette
        ["<F1>"] = {
            function()
                require("snacks").picker()
            end,
            "Command Palette",
            { noremap = true, silent = true },
        },

        ["<Esc>"] = { "<Nop>", "Disable Escape", { noremap = true, silent = true } },

        [":"] = {
            open_cmdline,
            "Command Line",
            { noremap = true, silent = true },
        },

        ["<C-x>"] = {
            delete_current_line_keep_insert,
            "Delete Current Line",
            { noremap = true, silent = true },
        },

        ["<Tab>"] = {
            function()
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
            end,
            "Tab: Accept Codeium or Next Word",
            { noremap = true, silent = true, expr = true, replace_keycodes = true },
        },

        -- File Picker
        ["<C-p>"] = {
            function()
                vim.cmd("stopinsert")
                require("snacks").picker.files()
            end,
            "File Picker",
            { noremap = true, silent = true },
        },

        -- Grep Search
        ["<C-S-s>"] = {
            function()
                vim.cmd("stopinsert")
                require("snacks").picker.grep()
            end,
            "Grep Search",
            { noremap = true, silent = true },
        },
        ["<C-s>"] = {
            function()
                vim.cmd("stopinsert")
                require("snacks").picker.grep()
            end,
            "Grep Search",
            { noremap = true, silent = true },
        },

        -- Quit Neovim
        ["<C-c>"] = { "<cmd>qa!<cr>", "Force Quit Neovim", { noremap = true, silent = true } },

        -- Toggle/Focus Terminal
        ["<C-l>"] = { toggle_or_focus_terminal, "Toggle/Focus Terminal" },
        ["<C-S-Right>"] = { toggle_right_terminal, "Open Right Terminal" },

        -- Undo/Redo
        ["<C-z>"] = { "<Esc>u", "Undo" },
        ["<C-S-z>"] = { "<Esc><C-r>", "Redo" },
        ["<C-y>"] = { "<Esc><C-r>", "Redo" },

        -- VS Code style text selection with Shift+Arrow keys
        ["<S-Right>"] = { "<Esc>vl<C-g>", "Select Right" },
        ["<S-Left>"] = { "<Esc>vh<C-g>", "Select Left" },
        ["<S-Up>"] = { "<Esc>vk<C-g>", "Select Up" },
        ["<S-Down>"] = { "<Esc>vj<C-g>", "Select Down" },
        ["<S-Home>"] = { "<Esc>v^<C-g>", "Select to Start of Line" },
        ["<S-End>"] = { "<Esc>v$<C-g>", "Select to End of Line" },
        ["<S-C-Left>"] = { "<Esc>vb<C-g>", "Select Word Left" },

		["<Home>"] = {
			go_home,
			"Go Home",
			{ noremap = true, silent = true },
		},
    },

    v = {
        -- Extend selection with Shift+Arrow keys
        ["<S-Right>"] = { "l<C-g>", "Extend Selection Right" },
        ["<S-Left>"] = { "h<C-g>", "Extend Selection Left" },
        ["<S-Up>"] = { "k<C-g>", "Extend Selection Up" },
        ["<S-Down>"] = { "j<C-g>", "Extend Selection Down" },
        ["<S-Home>"] = { "^<C-g>", "Extend Selection to Start of Line" },
        ["<S-End>"] = { "$<C-g>", "Extend Selection to End of Line" },
        ["<S-C-Right>"] = { "w<C-g>", "Extend Selection Word Right" },
        ["<S-C-Left>"] = { "b<C-g>", "Extend Selection Word Left" },
		["<Home>"] = {
			go_home,
			"Go Home",
			{ noremap = true, silent = true },
		},

		[":"] = {
			open_cmdline,
			"Command Line",
			{ noremap = true, silent = true },
		},
    },

	x = {
		[":"] = {
			open_cmdline,
			"Command Line",
			{ noremap = true, silent = true },
		},
	},

    s = {
        -- Extend selection in Select mode
        ["<S-Right>"] = { "<Right>", "Extend Selection Right" },
        ["<S-Left>"] = { "<Left>", "Extend Selection Left" },
        ["<S-Up>"] = { "<Up>", "Extend Selection Up" },
        ["<S-Down>"] = { "<Down>", "Extend Selection Down" },
        ["<S-Home>"] = { "<Home>", "Extend Selection to Start of Line" },
        ["<S-End>"] = { "<End>", "Extend Selection to End of Line" },
        ["<S-C-Right>"] = { "<C-Right>", "Extend Selection Word Right" },
        ["<S-C-Left>"] = { "<C-Left>", "Extend Selection Word Left" },

        -- Cancel selection and return to insert mode
        ["<Right>"] = { "<Esc>i<Right>", "Cancel Selection and Move Right" },
        ["<Left>"] = { "<Esc>i<Left>", "Cancel Selection and Move Left" },
        ["<Up>"] = { "<Esc>i<Up>", "Cancel Selection and Move Up" },
        ["<Down>"] = { "<Esc>i<Down>", "Cancel Selection and Move Down" },
        ["<Home>"] = { "<Esc>i<Home>", "Cancel Selection and Move to Start" },
        ["<End>"] = { "<Esc>i<End>", "Cancel Selection and Move to End" },

        ["<Home>"] = {
            go_home,
            "Go Home",
            { noremap = true, silent = true },
        },

        [":"] = {
            open_cmdline,
            "Command Line",
            { noremap = true, silent = true },
        },
    },

    t = {
        -- Hide Terminal
        ["<C-l>"] = {
            function()
                local current_win = vim.api.nvim_get_current_win()
                vim.api.nvim_win_hide(current_win)
            end,
            "Hide Terminal",
        },

        -- Focus back to editor
        ["<C-k>"] = { "<C-\\><C-n><C-w>w", "Focus Editor" },
		["<Home>"] = {
			go_home,
			"Go Home",
			{ noremap = true, silent = true },
		},

		[":"] = {
			open_cmdline,
			"Command Line",
			{ noremap = true, silent = true },
		},

		["<F11>"] = { open_floating_pwsh_terminal, "Floating Terminal (pwsh)", { noremap = true, silent = true } },
    },
}
