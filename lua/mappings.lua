-- Custom key mappings for Neovim

-- Note: ESC key behavior is default Neovim behavior
-- Pressing ESC in insert mode will switch to normal mode (no custom mapping needed)

-- Ctrl+T to open terminal with PowerShell
vim.keymap.set("n", "<C-t>", function()
  local status, err = pcall(function()
    vim.cmd("terminal pwsh")
  end)
  if not status then
    vim.notify("Error opening terminal: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Open PowerShell Terminal" })

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

-- Ctrl+P to open file picker
vim.keymap.set({ "n", "i" }, "<C-p>", function()
  local status, err = pcall(function()
    require("snacks").picker.files()
  end)
  if not status then
    vim.notify("Error opening file picker: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "File Picker" })

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

-- Ctrl+C to auto-save and return to home screen (from both normal and insert modes)
vim.keymap.set({ "n", "i" }, "<C-c>", function()
  local status, err = pcall(function()
    -- Check if we're in the home screen/dashboard
    local bufname = vim.fn.bufname()
    if bufname == "" or bufname:match("dashboard") or bufname:match("alpha") then
      -- Quit Neovim completely (force quit if there are unsaved changes)
      vim.cmd("qa!")
    else
      -- Auto-save the current buffer
      vim.cmd("write")
      -- Return to home screen
      require("snacks").dashboard()
    end
  end)
  if not status then
    vim.notify("Error handling Ctrl+C: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Auto-save and Return to Home" })

-- Single ESC to return to home screen (instead of double ESC)
vim.keymap.set("n", "<Esc>", function()
  require("snacks").dashboard()
end, { desc = "ESC to Home Screen" })

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