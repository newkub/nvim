-- Autocommands for Neovim
-- Removed automatic explorer opening to respect user preference

-- Enhanced swap file management to prevent E325 warnings
-- Clean up swap files when Neovim exits normally
vim.api.nvim_create_autocmd("VimLeavePre", {
  pattern = "*",
  callback = function()
    -- This will help ensure swap files are properly cleaned up
    vim.cmd("silent! wa")  -- Write all buffers silently
  end,
})

-- Reduce swap file updates to prevent conflicts
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = "*",
  callback = function()
    -- Temporarily disable swap for write operations to prevent conflicts
    vim.opt_local.swapfile = false
  end,
})

vim.api.nvim_create_autocmd({"BufWritePost"}, {
  pattern = "*",
  callback = function()
    -- Re-enable swap after write operations
    vim.opt_local.swapfile = true
  end,
})

-- Additional swap file cleanup on focus lost
vim.api.nvim_create_autocmd({"FocusLost"}, {
  pattern = "*",
  callback = function()
    -- Write all buffers when focus is lost to reduce swap file conflicts
    if vim.fn.expand("%") ~= "" then
      vim.cmd("silent! wa")
    end
  end,
})

-- Handle terminal focus events for better swap file management
vim.api.nvim_create_autocmd({"TermClose"}, {
  pattern = "*",
  callback = function()
    -- Write buffers when terminal closes
    vim.cmd("silent! wa")
  end,
})