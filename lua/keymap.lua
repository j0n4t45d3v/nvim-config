vim.g.mapleader = " "
local key = vim.keymap

key.set("n", "<leader>w", "<cmd>:w<cr>", { desc = "save changes in file" })
key.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
key.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })

key.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move block down" })
key.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move block up" })

-- NEO TREE
-- key.set("n", "<leader>e", "<cmd>:Neotree toggle<cr>", { desc = "Open/Close explore" })
key.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Open/Close explore", noremap = true, silent = true })

-- TELESCOPE
local telescope = require("telescope.builtin")

key.set("n", "<leader>ff", telescope.find_files, { desc = "Find Files" })
key.set("n", "<leader>fl", telescope.live_grep, { desc = "Telescope live grep" })
key.set("n", "<leader>fk", telescope.keymaps, { desc = "Telescope show keybinds" })
key.set("n", "<leader>fb", telescope.buffers, { desc = "Telescope buffers" })
key.set("n", "<leader>fh", telescope.help_tags, { desc = "Telescope help tags" })
key.set("n", "<leader>fc", telescope.colorscheme, { desc = "List colorschemes" })
-- FORMAT
key.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format code" })
key.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Teste" })
