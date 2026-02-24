-- ~/.config/nvim/lua/core/keymaps.lua

local map = vim.keymap.set

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Genel
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Kaydet" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Kapat" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- Pencere navigasyonu (Ctrl + hjkl)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Buffer navigasyonu
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Sonraki buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Önceki buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Buffer kapat" })

-- Indent'i visual modda koru
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Satırı taşı (Alt + jk)
map("v", "<A-j>", ":m '>+1<cr>gv=gv")
map("v", "<A-k>", ":m '<-2<cr>gv=gv")

-- File tree
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Dosya ağacı" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Dosya bul" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "İçerik ara" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffer'lar" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Yardım" })

-- Git
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Git blame" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Git diff" })
map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
map("n", "]g", "<cmd>Gitsigns next_hunk<cr>", { desc = "Sonraki hunk" })
map("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Önceki hunk" })
