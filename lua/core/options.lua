local set = vim.opt

set.clipboard = "unnamedplus"
set.relativenumber = true
set.number = true

set.mouse = "a"
set.autoindent = true
set.breakindent = true
set.undofile = true
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
set.background = "dark"
set.colorcolumn = "80"
set.fillchars = { eob = " " }
vim.o.showmode = false
--[[ set.list = true
set.listchars = { tab = '» ', trail = '·', nbsp = '␣' } ]]
set.scrolloff = 10
set.hlsearch = true

vim.loader.enable()

vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#ffffff", fg = "NONE", underline = false })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 20 })
	end,
})

-- Set kitty terminal padding to 0 when in nvim
vim.cmd([[
  augroup kitty_mp
  autocmd!
  au VimLeave * :silent !kitty @ set-spacing padding=default margin=default
  au VimEnter * :silent !kitty @ set-spacing padding=0 margin=0 3 0 3
  augroup END
]])
