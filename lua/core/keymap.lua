vim.g.mapleader = " "
local key = vim.keymap
local opt = function(desc)
  local default_opt = { silent = true, noremap = true }
  default_opt["desc"] = desc
  return default_opt
end

key.set("n", "<leader>w", "<cmd>:w<cr>", { desc = "save changes in file" })
key.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
key.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })

key.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move block down" })
key.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move block up" })

-- MOVING IN WINDOWS
key.set("n", "<C-l>", "<C-w>l", opt("Go to left window"))
key.set("n", "<C-h>", "<C-w>h", opt("Go to right window"))
key.set("n", "<C-k>", "<C-w>k", opt("Go to up window"))
key.set("n", "<C-j>", "<C-w>j", opt("Go to down window"))

-- MANAGER WINDOWS
key.set("n", "<leader>sq", "<C-w>q", opt("Switch for down window"))
key.set("n", "<leader>sv", "<C-w>v", opt("Split vertical window"))
key.set("n", "<leader>ss", "<C-w>s", opt("Split horizontal window"))

key.set("n", "<M-h>", "<C-w><", opt("Decrement width window"))
key.set("n", "<M-l>", "<C-w>>", opt("Increment width windows"))
key.set("n", "<M-k>", "<C-w>+", opt("Increment height window"))
key.set("n", "<M-j>", "<C-w>-", opt("Decrement height window"))

-- NVIM TREE
key.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", opt("Open/Close explore"))

-- TELESCOPE

key.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opt("Find Files"))
key.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", opt("Find Recente Files"))
key.set("n", "<leader>fl", "<cmd>Telescope live_grep<cr>", opt("Telescope live grep"))
key.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", opt("Telescope show keybinds"))
key.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opt("Telescope buffers"))
key.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opt("Telescope help tags"))
key.set("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", opt("List colorschemes"))
-- FORMAT
key.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format code" })
key.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code actions" })

-- Mapear no modo normal
key.set(
  "n",
  "<leader>Jo",
  "<Cmd>lua require'jdtls'.organize_imports()<CR>",
  { noremap = true, silent = true, desc = "Organize Imports" }
)
key.set(
  "n",
  "<leader>Jv",
  "<Cmd>lua require('jdtls').extract_variable()<CR>",
  { noremap = true, silent = true, desc = "Extract Variable" }
)
key.set(
  "n",
  "<leader>JC",
  "<Cmd>lua require('jdtls').extract_constant()<CR>",
  { noremap = true, silent = true, desc = "Extract Constant" }
)
key.set(
  "n",
  "<leader>Jt",
  "<Cmd>lua require'jdtls'.test_nearest_method()<CR>",
  { noremap = true, silent = true, desc = "Test Method" }
)
key.set(
  "n",
  "<leader>JT",
  "<Cmd>lua require'jdtls'.test_class()<CR>",
  { noremap = true, silent = true, desc = "Test Class" }
)
key.set("n", "<leader>Ju", "<Cmd>JdtUpdateConfig<CR>", { noremap = true, silent = true, desc = "Update Config" })

-- Mapear no modo visual
key.set(
  "v",
  "<leader>Cv",
  "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
  { noremap = true, silent = true, desc = "Extract Variable" }
)
key.set(
  "v",
  "<leader>Cc",
  "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
  { noremap = true, silent = true, desc = "Extract Constant" }
)
key.set(
  "v",
  "<leader>Cm",
  "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
  { noremap = true, silent = true, desc = "Extract Method" }
)

--TESTS
key.set("n", "<leader>tr", function()
  require("neotest").run.run()
end, opt("Run Test"))

key.set("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, opt("Run Tests In File"))

key.set("n", "<leader>tp", function()
  require("neotest").run.run(vim.loop.cwd())
end, opt("Run Test in project"))

key.set("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, opt("Run Tests In File"))

key.set("n", "<leader>td", function()
  require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap", suite = false })
end, opt("Run Tests in file debug mode"))

key.set("n", "<leader>tr", function()
  require("neotest").run.stop()
end, opt("Stop Test"))

key.set("n", "<leader>to", function()
  require("neotest").output_panel.toggle()
end, opt("Output test"))

key.set("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, opt("Summary tests"))
