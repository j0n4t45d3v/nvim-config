local set = vim.opt

set.clipboard = "unnamedplus"
set.number = true
set.relativenumber = true
set.mouse = "a"
set.autoindent = true
set.smartindent = true
set.smarttab = true
set.cursorline = true
set.expandtab = true
set.shiftwidth = 2
set.tabstop = 2
set.encoding = "UTF-8"
set.ruler = true
set.showmatch = true
set.splitright = true
set.splitbelow = true
set.showcmd = true
set.wildmenu = true
set.wildoptions = "pum"
set.termguicolors = true

require("setup")

vim.cmd([[
syntax on
filetype plugin indent on
colorscheme lackluster-hack
]])
