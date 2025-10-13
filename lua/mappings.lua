-- Custom key mappings for Neovim

-- ============================================================================
-- Helper Functions
-- ============================================================================

-- Helper function to safely navigate to dashboard
local function safe_dashboard(opts)
  opts = opts or {}
  
  -- Check if we're already on the dashboard
  local bufname = vim.fn.bufname()
  if bufname:match("dashboard") or bufname:match("alpha") then
    return
  end
  
  -- If force option is set, skip save check
  if opts.force then
    require("snacks").dashboard({ force = true })
    return
  end
  
  -- Check if current buffer has unsaved changes
  local buf_modified = vim.api.nvim_buf_get_option(0, "modified")
  
  -- If buffer is modified, save it first
  if buf_modified then
    local status, err = pcall(vim.cmd, "write")
    if not status then
      vim.notify("Error saving buffer: " .. tostring(err), vim.log.levels.ERROR)
      return
    end
  end
  
  -- Now navigate to dashboard
  require("snacks").dashboard()
end

-- ============================================================================
-- Editor Navigation & UI
-- ============================================================================

-- Note: ESC key behavior is default Neovim behavior
-- Pressing ESC in insert mode will switch to normal mode (no custom mapping needed)

-- Single ESC to return to home screen (instead of double ESC)
vim.keymap.set("n", "<Esc>", function()
  local status, err = pcall(function()
    safe_dashboard()
  end)
  if not status then
    vim.notify("Error handling ESC: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "ESC to Home Screen" })

-- Ctrl+C to auto-save and return to home screen (from both normal and insert modes)
vim.keymap.set({ "n", "i" }, "<C-c>", function()
  local status, err = pcall(function()
    -- Check if we're in the home screen/dashboard
    local bufname = vim.fn.bufname()
    if bufname == "" or bufname:match("dashboard") or bufname:match("alpha") then
      -- Quit Neovim completely
      vim.cmd("qa")
    else
      -- Auto-save the current buffer and return to home screen
      safe_dashboard()
    end
  end)
  if not status then
    vim.notify("Error handling Ctrl+C: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Auto-save and Return to Home" })

-- Ctrl+Shift+C to force return to dashboard (discard unsaved changes)
vim.keymap.set({ "n", "i" }, "<C-S-c>", function()
  local status, err = pcall(function()
    -- Check if we're in the home screen/dashboard
    local bufname = vim.fn.bufname()
    if bufname == "" or bufname:match("dashboard") or bufname:match("alpha") then
      -- Quit Neovim completely (force quit if there are unsaved changes)
      vim.cmd("qa!")
    else
      -- Return to home screen (force discard changes)
      safe_dashboard({ force = true })
    end
  end)
  if not status then
    vim.notify("Error handling Ctrl+Shift+C: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Force Return to Home" })

-- ============================================================================
-- Text Editing Operations
-- ============================================================================

-- Ctrl+A to select all text (like VS Code)
vim.keymap.set({ "n", "i" }, "<C-a>", function()
  local status, err = pcall(function()
    -- Select all text in the buffer
    vim.cmd("keepjumps normal! ggVG")
  end)
  if not status then
    vim.notify("Error selecting all text: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Select All Text" })

-- Ctrl+Z for undo in normal and insert modes (like VS Code)
vim.keymap.set({ "n", "i" }, "<C-z>", function()
  local status, err = pcall(function()
    -- In insert mode, we need to exit to normal mode first, then undo, then go back to insert
    if vim.api.nvim_get_mode().mode == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>u", true, false, true), "nx", false)
    else
      vim.cmd("undo")
    end
  end)
  if not status then
    vim.notify("Error performing undo: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Undo" })

-- Ctrl+Shift+Z for redo in normal and insert modes (like VS Code)
vim.keymap.set({ "n", "i" }, "<C-S-z>", function()
  local status, err = pcall(function()
    -- In insert mode, we need to exit to normal mode first, then redo, then go back to insert
    if vim.api.nvim_get_mode().mode == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc><C-r>", true, false, true), "nx", false)
    else
      vim.cmd("redo")
    end
  end)
  if not status then
    vim.notify("Error performing redo: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Redo" })

-- Ctrl+Backspace to delete entire word in insert mode
vim.keymap.set("i", "<C-BS>", function()
  local status, err = pcall(function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>", true, false, true), "n", true)
  end)
  if not status then
    vim.notify("Error deleting word: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Delete word backward" })

-- ============================================================================
-- File & Buffer Operations
-- ============================================================================

-- Space + e to open file explorer
vim.keymap.set("n", "<leader>e", function()
  local status, err = pcall(function()
    require("snacks").explorer()
  end)
  if not status then
    vim.notify("Error opening explorer: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "File Explorer" })

-- F1 to open file picker
vim.keymap.set("n", "<F1>", function()
  local status, err = pcall(function()
    require("snacks").picker()
  end)
  if not status then
    vim.notify("Error opening picker: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "File Picker" })

-- Ctrl+R to open recent files picker
vim.keymap.set({ "n", "i" }, "<C-r>", function()
  local status, err = pcall(function()
    require("snacks").picker.recent()
  end)
  if not status then
    vim.notify("Error opening recent files picker: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Recent Files Picker" })

-- Ctrl+P to open smart file picker
vim.keymap.set({ "n", "i" }, "<C-p>", function()
  local status, err = pcall(function()
    require("snacks").picker.smart()
  end)
  if not status then
    vim.notify("Error opening smart file picker: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Smart File Picker" })

-- Ctrl+P+P to switch back to the last visited file (like VS Code)
vim.keymap.set({ "n", "i" }, "<C-p><C-p>", function()
  local status, err = pcall(function()
    -- This uses the built-in Ctrl+^ functionality to switch to the last visited file
    vim.cmd("e #")
  end)
  if not status then
    vim.notify("Error switching to last file: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Switch to Last File", remap = true })

-- ============================================================================
-- Terminal & System Operations
-- ============================================================================

-- Ctrl+T to open terminal with PowerShell
vim.keymap.set("n", "<C-t>", function()
  local status, err = pcall(function()
    vim.cmd("terminal pwsh")
  end)
  if not status then
    vim.notify("Error opening terminal: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Open PowerShell Terminal" })

-- ============================================================================
-- Autocommands
-- ============================================================================

-- Start in insert mode when entering a buffer
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local status, err = pcall(function()
      -- Only start insert mode if we're not in a special buffer
      local bufname = vim.fn.bufname()
      if bufname ~= "" and not bufname:match("dashboard") and not bufname:match("alpha") and not bufname:match("NvimTree") then
        vim.cmd("startinsert")
      end
    end)
    if not status then
      vim.notify("Error starting insert mode: " .. tostring(err), vim.log.levels.ERROR)
    end
  end,
})
