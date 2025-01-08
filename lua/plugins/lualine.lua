return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "bufwinenter",
  config = function()
    local diagnostic_icons = require("core.icons").diagnostics
    require("lualine").setup({
      sections = {
        lualine_c = {
          -- Aqui você adiciona o ícone do debug se estiver ativado
          {
            function()
              local is_debug_active = function()
                -- Verifique aqui se o debug está ativado, por exemplo, uma variável global
                return vim.g.debug_active == true
              end
              if is_debug_active() then
                return "Enable"
              else
                return "Disable"
              end
            end,
            icon = "" .. diagnostic_icons.Debug .. " Debugger:",
            color = { fg = "#cfcfcf", gui = "bold" }, -- Customize a cor
          },
        },
        lualine_x = {
          {
            "lsp_progress",                             -- Exibe o progresso de LSP
            display_components = { "spinner", "percentage" }, -- Customize a exibição
            always_visible = true,
          },
          {
            function()
              local clients = vim.lsp.get_active_clients()
              if #clients > 0 then
                return "["
                    .. table.concat(
                      vim.tbl_map(function(client)
                        return client.name
                      end, clients),
                      ", "
                    )
                    .. "]"
              else
                return "No LSP"
              end
            end,
            icon = " LSP:",
            color = { fg = "#cfcfcf", gui = "bold" }, -- Customize a cor
          },
          "filetype",
          "encoding",
          "fileformat",
        },
      },
    })
  end,
}
