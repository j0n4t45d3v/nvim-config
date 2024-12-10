return {
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local servers = require("lspservers")
      servers.intelephense.root_dir = lspconfig.util.root_pattern("compose.json", ".git/", "*.php")

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua",
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      local navic = require("nvim-navic")
      require("mason-lspconfig").setup({
        ensure_installed = { "jdtls" },
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            server.on_attach = function(client, buffer)
              if client.server_capabilities.documentSymbolProvider then
                navic.attach(client, buffer)
              end
              -- Helper para facilitar os mapeamentos
              local function buf_set_keymap(...)
                vim.api.nvim_buf_set_keymap(buffer, ...)
              end

              local opts = { noremap = true, silent = true }

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
              buf_set_keymap(
                "n",
                "K",
                "<cmd>lua vim.lsp.buf.hover()<CR>",
                { noremap = true, silent = true, desc = "Helper" }
              )

              -- Exibir assinatura (documentação inline)
              buf_set_keymap(
                "n",
                "<C-k>",
                "<cmd>lua vim.lsp.buf.signature_help()<CR>",
                { noremap = true, silent = true, desc = "Show signature help" }
              )
            end
            lspconfig[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
