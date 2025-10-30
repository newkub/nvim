-- Snacks plugin configuration and initialization
local config = require("plugins.snacks.config")
local keys = require("plugins.snacks.keys")

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = config,
  keys = keys,
  init = function()
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      -- Setup globals for debugging
      _G.dd = function(...)
        local status, result = pcall(function(...)
          require("snacks").debug.inspect(...)
        end, ...)
        if not status then
          vim.notify("Error in debug.inspect: " .. tostring(result), vim.log.levels.ERROR)
        end
      end
      
      _G.bt = function()
        local status, result = pcall(function()
          require("snacks").debug.backtrace()
        end)
        if not status then
          vim.notify("Error in debug.backtrace: " .. tostring(result), vim.log.levels.ERROR)
        end
      end

      -- Override print to use snacks
      if vim.fn.has("nvim-0.11") == 1 then
        vim._print = function(_, ...)
          local status, result = pcall(function(...)
            dd(...)
          end, ...)
          if not status then
            vim.notify("Error in print override: " .. tostring(result), vim.log.levels.ERROR)
          end
        end
      else
        vim.print = _G.dd 
      end

      -- Create toggle mappings
      local snacks_status, snacks = pcall(require, "snacks")
      if snacks_status then
        snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        snacks.toggle.diagnostics():map("<leader>ud")
        snacks.toggle.line_number():map("<leader>ul")
        snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        snacks.toggle.treesitter():map("<leader>uT")
        snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        snacks.toggle.inlay_hints():map("<leader>uh")
        snacks.toggle.indent():map("<leader>ug")
        snacks.toggle.dim():map("<leader>uD")
        snacks.toggle.profiler():map("<leader>pp")
        snacks.toggle.profiler_highlights():map("<leader>ph")
      else
        vim.notify("Error loading snacks for toggle mappings: " .. tostring(snacks), vim.log.levels.ERROR)
      end
    end,
  })
  
  -- Buffer validation
  vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*",
    callback = function()
      local bufnr = vim.api.nvim_get_current_buf()
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end
    end,
  })
  
  -- Enable sign column
  vim.opt.signcolumn = "yes"
  
  -- Exit insert mode on dashboard
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
      local bufname = vim.fn.bufname()
      if bufname:match("dashboard") or bufname:match("alpha") then
        vim.cmd("stopinsert")
      end
    end,
  })
  end
}
