local M = {}
local navic = require("nvim-navic")

local lsp_helpers = function(buffer)
  -- Helper para facilitar os mapeamentos
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(buffer, ...)
  end

  -- Go-to definição
  buf_set_keymap(
    "n",
    "gd",
    "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>",
    { noremap = true, silent = true, desc = "Go to definition" }
  )

  -- Go-to declaração
  buf_set_keymap(
    "n",
    "gD",
    "<cmd>lua vim.lsp.buf.declaration()<CR>",
    { noremap = true, silent = true, desc = "Go to declaration" }
  )

  -- Go-to implementação
  buf_set_keymap(
    "n",
    "gi",
    "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>",
    { noremap = true, silent = true, desc = "Go to implementation" }
  )

  -- Go-to tipo
  buf_set_keymap(
    "n",
    "gt",
    "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>",
    { noremap = true, silent = true, desc = "Go to type definition" }
  )

  buf_set_keymap(
    "n",
    "<leader>lr",
    "<cmd>lua vim.lsp.buf.rename()<CR>",
    { noremap = true, silent = true, desc = "Rename" }
  )
  -- Mostrar referências
  buf_set_keymap(
    "n",
    "gr",
    "<cmd>lua require('telescope.builtin').lsp_references()<CR>",
    { noremap = true, silent = true, desc = "Show references" }
  )

  -- Hover (ajuda)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true, desc = "Helper" })

  -- Exibir assinatura (documentação inline)
  buf_set_keymap(
    "n",
    "<leader>sh",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    { noremap = true, silent = true, desc = "Show signature help" }
  )
end

local attach = function(client, buffer)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, buffer)
  end
  lsp_helpers(buffer)
end

local capabilities = function(server)
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  return vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
end

M.default_on_attach = attach
M.lsp_keybinds = lsp_helpers
M.default_capabilities = capabilities
return M
