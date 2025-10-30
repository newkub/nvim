-- Autocommands for Neovim

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General settings
augroup("GeneralSettings", { clear = true })
autocmd("VimLeavePre", {
  group = "GeneralSettings",
  pattern = "*",
  callback = function()
    vim.cmd("silent! wa")
  end,
})
autocmd("FocusLost", {
  group = "GeneralSettings",
  pattern = "*",
  callback = function()
    if vim.fn.expand("%") ~= "" then
      vim.cmd("silent! wa")
    end
  end,
})
autocmd("TermClose", {
  group = "GeneralSettings",
  pattern = "*",
  callback = function()
    vim.cmd("silent! wa")
  end,
})

-- Swap file management
augroup("SwapFileManagement", { clear = true })
autocmd("BufWritePre", {
  group = "SwapFileManagement",
  pattern = "*",
  callback = function()
    vim.opt_local.swapfile = false
  end,
})
autocmd("BufWritePost", {
  group = "SwapFileManagement",
  pattern = "*",
  callback = function()
    vim.opt_local.swapfile = true
  end,
})

-- Cursor position
augroup("CursorPosition", { clear = true })
autocmd("BufReadPost", {
  group = "CursorPosition",
  pattern = "*",
  callback = function()
    local bufname = vim.fn.bufname()
    if bufname ~= "" and not bufname:match("dashboard") and not bufname:match("alpha") and not bufname:match("NvimTree") then
      pcall(function()
        local line = vim.fn.line("'\"")
        local col = vim.fn.col("'\"")
        if line > 0 and line <= vim.fn.line("$") then
          vim.api.nvim_win_set_cursor(0, { line, col })
        end
      end)
    end
  end,
})
autocmd("BufWritePre", {
  group = "CursorPosition",
  pattern = "*",
  callback = function()
    pcall(vim.cmd, "silent! mkview")
  end,
})
autocmd("BufReadPre", {
  group = "CursorPosition",
  pattern = "*",
  callback = function()
    pcall(vim.cmd, "silent! loadview")
  end,
})

