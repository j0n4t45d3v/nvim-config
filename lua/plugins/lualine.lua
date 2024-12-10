return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "bufwinenter",
  config = function()
    local navic = require("nvim-navic")
    require("lualine").setup({
      options = {
        theme = "lackluster",
      },
      sections = {
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
        },
      },
    })
  end,
}
