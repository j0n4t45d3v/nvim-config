local M = {}
M.key = vim.keymap

function M.opt(desc)
  local default_opt = { silent = true, noremap = true }
  default_opt["desc"] = desc
  return default_opt
end

function M.set_keybind_window()
  local key = M.key
  local opt = M.opt

  -- MOVING IN WINDOWS
  key.set("n", "<C-l>", "<C-w>l", opt("Go to left window"))
  key.set("n", "<C-h>", "<C-w>h", opt("Go to right window"))
  key.set("n", "<C-k>", "<C-w>k", opt("Go to up window"))
  key.set("n", "<C-j>", "<C-w>j", opt("Go to down window"))

  -- MANAGER WINDOWS
  key.set("n", "<leader>sq", "<C-w>q", opt("Switch for down window"))
  key.set("n", "<leader>sv", "<C-w>v", opt("Split vertical window"))
  key.set("n", "<leader>ss", "<C-w>s", opt("Split horizontal window"))

  key.set("n", "<M-S-h>", "<C-w><", opt("Decrement width window"))
  key.set("n", "<M-S-l>", "<C-w>>", opt("Increment width windows"))
  key.set("n", "<M-S-k>", "<C-w>+", opt("Increment height window"))
  key.set("n", "<M-S-j>", "<C-w>-", opt("Decrement height window"))
end

function M.set_keybind_telescope()
  local key = M.key
  local opt = M.opt

  key.set("n", "<leader>ff", "<cmd>Telescope find_files theme=dropdown<cr>", opt("Find Files"))
  key.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", opt("Find Recente Files"))
  key.set("n", "<leader>fl", "<cmd>Telescope live_grep theme=dropdown<cr>", opt("Telescope live grep"))
  key.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", opt("Telescope show keybinds"))
  key.set("n", "<leader>fb", "<cmd>Telescope buffers theme=dropdown<cr>", opt("Telescope buffers"))
  key.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opt("Telescope help tags"))
  key.set("n", "<leader>fc", "<cmd>Telescope colorscheme theme=ivy<cr>", opt("List colorschemes"))
end

function M.set_keybinds()
  vim.g.mapleader = " "
  local key = M.key
  local opt = M.opt

  key.set("n", "<leader>w", "<cmd>:w<cr>", { desc = "save changes in file" })
  key.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
  key.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })

  key.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move block down" })
  key.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move block up" })
  key.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  key.set('n', '+', '<C-a>')
  key.set('n', '-', '<C-x>')

  -- NVIM TREE
  key.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", opt("Open/Close explore"))

  -- FORMAT
  key.set("n", "<leader>lf", vim.lsp.buf.format, opt("Format code"))
  key.set("n", "<leader>la", vim.lsp.buf.code_action, opt("Code actions"))
  key.set("n", "<leader>ld", "<cmd>Telescope diagnostics theme=ivy<cr>", opt("Show Diagnostics"))

  M.set_keybind_window()
  M.set_keybind_telescope()
end

return M
