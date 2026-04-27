-- =========================================================
-- 🪶 NEOVIM MINIMALISTA 
-- =========================================================

-- ========================
-- 🔧 BASE
-- ========================
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 5

-- ========================
-- 🔍 SEARCH
-- ========================
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- ========================
-- 🎨 THEME
-- ========================

vim.cmd.colorscheme("default")

-- ========================
-- ⌨️ TECLA LEADER
-- ========================
vim.g.mapleader = " "

local keymap = vim.keymap.set

-- salvar / sair (simples e direto)
keymap("n", "<leader>w", ":w<CR>")
keymap("n", "<leader>q", ":q<CR>")

-- melhor navegação de splits
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")

-- copiar linha inteira
keymap("n", "YY", "yy")

-- desmarcar highlight
keymap("n", "<Esc>", ":nohlsearch<CR>")