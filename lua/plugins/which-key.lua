return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
    -- Override the default <leader><space> mapping to do nothing instead of smart picker
    {
      "<leader><space>",
      function()
        -- Do nothing, just consume the keypress
      end,
      desc = "Disable Smart Picker",
    },
  },
}