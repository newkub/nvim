-- VS Code style system operations key mappings for Neovim

return {
  n = {
    -- Open Terminal (VS Code style: Ctrl+`)
    ["<C-`>"] = { ":terminal pwsh<CR>", "Open Terminal" },

    -- Quit Neovim
    ["<C-c>"] = { function() vim.notify("Press :qa to quit Neovim", vim.log.levels.INFO, { title = "System" }) end, "Show Quit Hint" },

    -- Copy Line
    ["<C-y>"] = { '"+yy', "Copy Line" },
  },

  i = {
    -- Exit to Normal Mode
    ["<C-c>"] = { "<Esc>", "Exit to Normal Mode" },
  },

  v = {
    -- Copy Selection
    ["<C-y>"] = { '"+y', "Copy Selection" },
  },
}