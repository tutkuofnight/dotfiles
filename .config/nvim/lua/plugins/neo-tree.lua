-- ~/.config/nvim/lua/plugins/neo-tree.lua

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Ok tuşlarını Neo-tree için ayarla
    vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn",  { text = " ", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo",  { text = " ", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint",  { text = "󰌵 ", texthl = "DiagnosticSignHint" })

    require("neo-tree").setup({
      close_if_last_window = false,   -- sidebar açıkken son dosyayı kapatınca nvim kapanmasın
      popup_border_style = "rounded",

      window = {
        position = "left",            -- IDE gibi solda sabit
        width = 35,
        mappings = {
          ["<space>"] = "none",       -- leader tuşunu neo-tree'ye kaptırma
          ["l"] = "open",             -- l ile dosyayı aç
          ["h"] = "close_node",       -- h ile klasörü kapat
          ["H"] = "toggle_hidden",    -- H ile gizli dosyaları göster/gizle
          ["/"] = "fuzzy_finder",     -- / ile tree içinde ara
        },
      },

      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,      -- .env, .gitignore gibi dosyaları göster
          hide_gitignored = true,
          hide_by_name = { "node_modules", ".git" },
          never_show = { ".DS_Store" },
        },
        follow_current_file = {
          enabled = true,             -- aktif dosyayı tree'de otomatik göster
          leave_dirs_open = true,
        },
        use_libuv_file_watcher = true, -- dosya sistemi değişikliklerini otomatik yansıt
      },

      default_component_configs = {
        indent = {
          indent_size = 2,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰜌",
        },
        git_status = {
          symbols = {
            added     = "",
            modified  = "",
            deleted   = "✖",
            renamed   = "󰁕",
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          },
        },
      },

      event_handlers = {
        -- Dosyayı açınca editöre odaklan (tree'de kalma)
        {
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute({ action = "focus" })
            vim.cmd("wincmd p")
          end,
        },
      },
    })
  end,
}
