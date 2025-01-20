return {
  {
    "williamboman/mason.nvim",
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
    end,
  },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local servers = require("core.servers")
      servers.intelephense.root_dir = lspconfig.util.root_pattern("compose.json", ".git/", "*.php")
      servers.phpactor.root_dir = lspconfig.util.root_pattern("compose.json", ".git/", "*.php")

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua",
      })

      local icon_diagnostic = require("core.icons").diagnostics

      local signs = {
        Error = icon_diagnostic.Error,
        Warn = icon_diagnostic.Warning,
        Info = icon_diagnostic.Info,
        Hint = icon_diagnostic.Hint,
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      local setup_lsp_server = require("core.lsp")
      require("mason-lspconfig").setup({
        ensure_installed = { "jdtls" },
        automatic_installation = true,
        handlers = {
          function(server_name)
            if server_name == "jdtls" then
              return
            end
            local server = servers[server_name] or {}
            server.capabilities = setup_lsp_server.default_capabilities(server)
            server.on_attach = function(client, buffer)
              if client.server_capabilities.documentSymbolProvider then
                require("nvim-navic").attach(client, buffer)
              end
              require("core.lsp").lsp_keybinds(buffer)
            end
            lspconfig[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
