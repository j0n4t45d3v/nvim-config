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
key.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code actions" })

-- Mapear no modo normal
key.set("n", "<leader>Co", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { noremap = true, silent = true, desc = "Organize Imports"})
key.set("n", "<leader>Cv", "<Cmd>lua require('jdtls').extract_variable()<CR>", { noremap = true, silent = true, desc = "Extract Variable"})
key.set("n", "<leader>Cc", "<Cmd>lua require('jdtls').extract_constant()<CR>", { noremap = true, silent = true, desc = "Extract Constant"})
key.set("n", "<leader>Ct", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", { noremap = true, silent = true, desc = "Test Method" })
key.set("n", "<leader>CT", "<Cmd>lua require'jdtls'.test_class()<CR>", { noremap = true, silent = true, desc = "Test Class" })
key.set("n", "<leader>Cu", "<Cmd>JdtUpdateConfig<CR>", { noremap = true, silent = true , desc = "Update Config"})

-- Mapear no modo visual
key.set("v", "<leader>Cv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { noremap = true, silent = true, desc = "Extract Variable"})
key.set("v", "<leader>Cc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { noremap = true, silent = true, desc = "Extract Constant" })
key.set("v", "<leader>Cm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { noremap = true, silent = true, desc = "Extract Method"})
