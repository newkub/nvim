-- VS Code style system operations key mappings for Neovim

return {
  n = {
    -- Open Terminal (VS Code style: Ctrl+`)
    ["<C-`>"] = { ":terminal pwsh<CR>", "Open Terminal" },

    -- Quit Neovim
    ["<C-c>"] = { function() vim.cmd("qa") end, "Quit Neovim" },

    -- Copy Line
    ["<C-y>"] = { '"+yy', "Copy Line" },
  },

  i = {
    -- Exit to Normal Mode
    ["<C-c>"] = { "<Esc>", "Exit to Normal Mode" },
  },

  v = {
    -- Quit Neovim
    ["<C-c>"] = { function() vim.cmd("qa") end, "Quit Neovim" },

    -- Copy Selection
    ["<C-y>"] = { '"+y', "Copy Selection" },
  },
}