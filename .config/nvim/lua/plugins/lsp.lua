-- ~/.config/nvim/lua/plugins/lsp.lua

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = { border = "rounded" },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "eslint",
          "tailwindcss",
          "cssls",
          "html",
          "jsonls",
          "lua_ls",
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Ortak on_attach keymap'leri
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(event)
          local map = vim.keymap.set
          local opts = { buffer = event.buf }

          map("n", "gd",         vim.lsp.buf.definition,     vim.tbl_extend("force", opts, { desc = "Tanıma git" }))
          map("n", "gD",         vim.lsp.buf.declaration,    vim.tbl_extend("force", opts, { desc = "Bildirime git" }))
          map("n", "gr",         vim.lsp.buf.references,     vim.tbl_extend("force", opts, { desc = "Referanslar" }))
          map("n", "gi",         vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Implementation" }))
          map("n", "K",          vim.lsp.buf.hover,          vim.tbl_extend("force", opts, { desc = "Hover doc" }))
          map("n", "<leader>rn", vim.lsp.buf.rename,         vim.tbl_extend("force", opts, { desc = "Yeniden adlandır" }))
          map("n", "<leader>ca", vim.lsp.buf.code_action,    vim.tbl_extend("force", opts, { desc = "Code action" }))
          map("n", "<leader>d",  vim.diagnostic.open_float,  vim.tbl_extend("force", opts, { desc = "Diagnostic" }))
          map("n", "[d",         vim.diagnostic.goto_prev,   vim.tbl_extend("force", opts, { desc = "Önceki hata" }))
          map("n", "]d",         vim.diagnostic.goto_next,   vim.tbl_extend("force", opts, { desc = "Sonraki hata" }))
        end,
      })

      -- Diagnostic görünümü
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        float = { border = "rounded" },
      })

      -- Yeni API: vim.lsp.config
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayReturnTypeHints = true,
            },
          },
        },
      })

      vim.lsp.config("tailwindcss", {
        capabilities = capabilities,
        filetypes = {
          "html", "css", "javascript", "javascriptreact",
          "typescript", "typescriptreact",
        },
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "cn\\(([^)]*)\\)",   "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "clsx\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "cva\\(([^)]*)\\)",  "[\"'`]([^\"'`]*).*?[\"'`]" },
              },
            },
          },
        },
      })

      vim.lsp.config("eslint", {
        capabilities = capabilities,
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })

      vim.lsp.config("cssls",  { capabilities = capabilities })
      vim.lsp.config("html",   { capabilities = capabilities })
      vim.lsp.config("jsonls", { capabilities = capabilities })
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- Tüm sunucuları etkinleştir
      vim.lsp.enable({
        "ts_ls", "eslint", "tailwindcss",
        "cssls", "html", "jsonls", "lua_ls",
      })
    end,
  },
}
