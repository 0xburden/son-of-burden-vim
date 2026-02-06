-- ===========================
-- Core Options
-- ===========================

-- Neovim defaults to nocompatible, no need to set
vim.opt.termguicolors = true

-- Leader key
vim.g.mapleader = ";"
vim.g.maplocalleader = "\\"

-- ===========================
-- UI & Display
-- ===========================

vim.opt.showmode = true
vim.opt.showmatch = true
vim.opt.ruler = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 3
vim.opt.showcmd = true
vim.opt.ttyfast = true
vim.opt.hidden = true

-- Wildmenu (command completion)
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

-- ===========================
-- Splitting
-- ===========================

vim.opt.splitbelow = true
vim.opt.splitright = true

-- ===========================
-- Indentation
-- ===========================

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.shiftround = true

-- ===========================
-- Search
-- ===========================

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ===========================
-- Backspace
-- ===========================

vim.opt.backspace = "indent,eol,start"

-- ===========================
-- Completion
-- ===========================

vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.omnifunc = "syntaxcomplete#Complete"

-- ===========================
-- Netrw Settings
-- ===========================

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 20
vim.g.netrw_browse_split = 4
vim.g.netrw_localrmdir = "rm -rf"

-- ===========================
-- Pear Tree
-- ===========================

vim.g.pear_tree_smart_openers = 0
vim.g.pear_tree_smart_closers = 0
vim.g.pear_tree_smart_backspace = 0

-- ===========================
-- Theme & Colors
-- ===========================

vim.opt.background = "dark"
vim.g.ayudark = "dark"

-- File type fixes
vim.cmd([[au BufRead,BufNewFile *.astro set filetype=html]])
