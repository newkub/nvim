-- Custom key mappings for Neovim

-- Ctrl+T to open terminal with PowerShell
vim.keymap.set("n", "<C-t>", function()
  vim.cmd("terminal pwsh")
end, { desc = "Open PowerShell Terminal" })

-- Space + e to open file explorer
vim.keymap.set("n", "<leader>e", function()
  require("snacks").explorer()
end, { desc = "File Explorer" })

-- F1 to open file picker
vim.keymap.set("n", "<F1>", function()
  require("snacks").picker()
end, { desc = "File Picker" })

-- Contextual Ctrl+C behavior
vim.keymap.set("n", "<C-c>", function()
  -- Check if we're in the home screen/dashboard
  local bufname = vim.fn.bufname()
  if bufname == "" or bufname:match("dashboard") or bufname:match("alpha") then
    -- Quit Neovim completely (force quit if there are unsaved changes)
    vim.cmd("qa!")
  else
    -- Return to home screen
    require("snacks").dashboard()
  end
end, { desc = "Contextual Exit/Return" })