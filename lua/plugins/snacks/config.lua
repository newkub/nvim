-- Snacks configuration options
---@type snacks.Config
return {
  bigfile = {},
  dashboard = { 
    enabled = true,
    sections = {
      { section = "header" },
      {
        pane = 2,
        section = "terminal",
        cmd = "ver",
        height = 5,
        padding = 1,
      },
      { 
        section = "keys", 
        gap = 1, 
        padding = 1,
        keys = {
          { "f", "<cmd>lua require('snacks').picker.files()<cr>", "Find File" },
          { "n", "<cmd>enew<cr>", "New File" },
          { "p", "<cmd>lua require('snacks').picker.projects()<cr>", "Projects" },
          { "g", "<cmd>lua require('snacks').picker.git_files()<cr>", "Git Files" },
          { "r", "<cmd>lua require('snacks').picker.recent()<cr>", "Recent Files" },
        }
      },
      { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      {
        pane = 2,
        icon = " ",
        title = "Git Status",
        section = "terminal",
        enabled = function()
          local status, result = pcall(function()
            return require("snacks").git.get_root() ~= nil
          end)
          return status and result
        end,
        cmd = "git status --short --branch --renames",
        height = 5,
        padding = 1,
        ttl = 5 * 60,
        indent = 3,
      },
      { section = "startup" },
    },
  },
  dim = {},
  explorer = { enabled = true },
  gitbrowse = {},
  image = {},
  indent = { enabled = false },
  input = {},
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  picker = { 
    enabled = true,
    hooks = {
      on_error = function(err)
        vim.notify("Picker error: " .. tostring(err), vim.log.levels.ERROR)
      end
    }
  },
  profiler = {},
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = {},
  statuscolumn = { 
    enabled = true,
    git = {
      enabled = true,
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "┆" },
      },
    },
  },
  terminal = {},
  words = { enabled = true },
  styles = {
    notification = {}
  }
}
