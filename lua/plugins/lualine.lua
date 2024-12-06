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
        lualine_c = {
          { navic.get_location, cond = navic.is_available },
        },
      },
      winbar = {
        lualine_c = {
          {
            function()
              return navic.get_location()
            end,
            cond = function()
              return navic.is_available()
            end,
          },
        },
      },
    })
  end,
}
