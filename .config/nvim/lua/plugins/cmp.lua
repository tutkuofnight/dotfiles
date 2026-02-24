-- ~/.config/nvim/lua/plugins/cmp.lua

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",    -- LSP kaynağı
    "hrsh7th/cmp-buffer",      -- buffer kelimeleri
    "hrsh7th/cmp-path",        -- dosya yolları
    "L3MON4D3/LuaSnip",        -- snippet engine
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets", -- React/TS snippet'ları
    "onsails/lspkind.nvim",    -- VSCode tarzı ikonlar
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"]   = cmp.mapping.select_prev_item(),
        ["<C-j>"]   = cmp.mapping.select_next_item(),
        ["<C-b>"]   = cmp.mapping.scroll_docs(-4),
        ["<C-f>"]   = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"]   = cmp.mapping.abort(),
        ["<CR>"]    = cmp.mapping.confirm({ select = false }),
        -- Tab ile snippet içinde gezin
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
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
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip",  priority = 750 },
        { name = "buffer",   priority = 500 },
        { name = "path",     priority = 250 },
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end,
}
