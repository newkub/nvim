return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
  },
  opts = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    
    return {
      completion = {
        autocomplete = false,
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- ตรวจสอบว่ามี Windsurf suggestion หรือไม่ (ให้ Windsurf จัดการก่อน)
          local has_codeium, codeium_vt = pcall(require, "codeium.virtual_text")
          if has_codeium and codeium_vt and codeium_vt.visible() then
            -- ถ้ามี Windsurf suggestion ให้ fallback (Windsurf จะ handle)
            fallback()
            return
          end
          
          -- ถ้าไม่มี Windsurf suggestion, ตรวจสอบ cmp
          if cmp.visible() then
            -- ถ้า autocomplete เปิดอยู่ -> accept completion
            cmp.confirm({ select = true })
          else
            -- ถ้าไม่มี autocomplete -> เลื่อน cursor ไปยัง word ถัดไป
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-o>w", true, false, true), "n", false)
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "codeium", priority = 1000 },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        format = function(entry, item)
          local icons = require("theme").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          return item
        end,
      },
      experimental = {
        ghost_text = false,
      },
    }
  end,
  config = function(_, opts)
    require("cmp").setup(opts)
  end,
}