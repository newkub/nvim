-- VS Code style system operations key mappings for Neovim

-- Custom function to toggle terminal (hide/show)
local function toggle_or_focus_terminal()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  
  -- เช็คว่า cursor อยู่ใน terminal หรือไม่
  if vim.bo[current_buf].buftype == "terminal" then
    -- ถ้าอยู่ใน terminal ให้ซ่อน window (ไม่ลบ buffer)
    vim.api.nvim_win_hide(current_win)
    return
  end
  
  -- หา terminal buffer และ window ที่มีอยู่
  local term_bufnr = nil
  local term_winnr = nil
  
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" and vim.api.nvim_buf_is_valid(buf) then
      term_bufnr = buf
      -- เช็คว่า buffer นี้มี window หรือไม่
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buf then
          term_winnr = win
          break
        end
      end
      break
    end
  end
  
  -- ถ้ามี terminal buffer แต่ไม่มี window (ถูกซ่อนไว้)
  if term_bufnr and not term_winnr then
    -- แสดง terminal buffer ใน split window ด้านล่าง
    vim.cmd("botright split")
    vim.api.nvim_win_set_buf(0, term_bufnr)
    vim.cmd("startinsert")
  elseif term_winnr then
    -- ถ้ามี window อยู่แล้ว ให้ focus ไป
    vim.api.nvim_set_current_win(term_winnr)
    vim.cmd("startinsert")
  else
    -- ถ้าไม่มี terminal เลย ให้สร้างใหม่
    require("snacks").terminal()
  end
end

return {
  n = {
    -- Command Palette (VS Code style: F1)
    ["<F1>"] = { function() require("snacks").picker() end, "Pick a Picker", { noremap = true, silent = true } },

    -- File Pickers
    ["<C-p>"] = { function() require("snacks").picker.files() end, "Pick Files", { noremap = true, silent = true } },
    ["<C-r>"] = { function() require("snacks").picker.recent() end, "Pick Recent Files", { noremap = true, silent = true } },

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
    -- Command Palette (VS Code style: F1)
    ["<F1>"] = { function() require("snacks").picker() end, "Pick a Picker", { noremap = true, silent = true } },
    
    -- File Pickers
    ["<C-p>"] = { function() require("snacks").picker.files() end, "Pick Files", { noremap = true, silent = true } },
    ["<C-r>"] = { function() require("snacks").picker.recent() end, "Pick Recent Files", { noremap = true, silent = true } },
    
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
    -- Toggle terminal (hide)
    ["<C-l>"] = { function()
      local current_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_hide(current_win)
    end, "Hide Terminal" },
    
    -- Focus back to editor from terminal
    ["<C-k>"] = { "<C-\\><C-n><C-w>w", "Focus Editor" },
  },
}