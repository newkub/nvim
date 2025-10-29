return {
  "Exafunction/windsurf.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  event = "BufEnter",
  config = function()
    require("codeium").setup({
      enable_chat = true,
      virtual_text = {
        enabled = true,
        manual = false,
        idle_delay = 75,
        map_keys = false,
      },
    })
  end,
}
