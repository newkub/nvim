-- VS Code style system operations key mappings for Neovim

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