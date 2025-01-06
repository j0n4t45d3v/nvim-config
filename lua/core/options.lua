local set = vim.opt

set.clipboard = "unnamedplus"
set.relativenumber = true
set.number = true

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
set.background = "dark"
set.colorcolumn = "80"
set.fillchars = { eob = " " }

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
