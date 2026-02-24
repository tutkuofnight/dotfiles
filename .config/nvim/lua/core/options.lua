-- ~/.config/nvim/lua/core/options.lua

local opt = vim.opt

-- Genel
opt.number = true           -- satır numaraları
opt.relativenumber = true   -- göreceli satır numaraları
opt.cursorline = true       -- aktif satırı vurgula
opt.wrap = false            -- satır kaydırmayı kapat
opt.scrolloff = 8           -- imleç kenara yaklaşınca kaydır
opt.signcolumn = "yes"      -- her zaman sign column göster (LSP için)

-- Girintileme
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Arama
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Görsel
opt.termguicolors = true
opt.splitbelow = true
opt.splitright = true

-- Performans
opt.updatetime = 250
opt.timeoutlen = 300

-- Clipboard
opt.clipboard = "unnamedplus"  -- sistem clipboard'u kullan

-- Dosya
opt.swapfile = false
opt.backup = false
opt.undofile = true
