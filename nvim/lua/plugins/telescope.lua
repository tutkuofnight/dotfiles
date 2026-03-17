-- ~/.config/nvim/lua/plugins/catppuccin.lua

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- diğer pluginlerden önce yükle
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      integrations = {
        neo_tree = true,
        telescope = { enabled = true },
        gitsigns = true,
        cmp = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
