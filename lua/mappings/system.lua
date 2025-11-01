-- VS Code style system operations key mappings for Neovim

-- Custom function to toggle/focus terminal
local function toggle_or_focus_terminal()
  -- หา terminal buffer ที่มีอยู่
  local term_bufnr = nil
  local term_winnr = nil
  
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
      term_bufnr = buf
      term_winnr = win
      break
    end
  end
  
  -- ถ้าเจอ terminal window ให้ focus ไป
  if term_winnr then
    vim.api.nvim_set_current_win(term_winnr)
    vim.cmd("startinsert")
  else
    -- ถ้าไม่เจอให้เปิด terminal ใหม่
    require("snacks").terminal()
  end
end

return {
  n = {
    -- Command Palette (VS Code style: F1)
    ["<F1>"] = { function() require("snacks").picker() end, "Pick a Picker" },

    -- Open Terminal (VS Code style: Ctrl+`)
    ["<C-`>"] = { ":terminal pwsh<CR>", "Open Terminal" },

    -- Quit Neovim
    ["<C-c>"] = { function() vim.cmd("q!") end, "Quit Neovim" },

    -- Copy Line
    ["<C-y>"] = { '"+yy', "Copy Line" },
    
    -- Toggle/Focus Terminal
    ["<C-l>"] = { toggle_or_focus_terminal, "Focus Terminal" },
  },

  i = {
    -- Exit to Normal Mode
    ["<C-c>"] = { "<Esc>", "Exit to Normal Mode" },
    
    -- Toggle/Focus Terminal
    ["<C-l>"] = { toggle_or_focus_terminal, "Focus Terminal" },
  },

  v = {
    -- Copy Selection
    ["<C-y>"] = { '"+y', "Copy Selection" },
  },

  t = {
    -- Focus back to editor from terminal
    ["<C-k>"] = { "<C-\\><C-n><C-w>w", "Focus Editor" },
  },
}