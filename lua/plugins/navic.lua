return {
  "SmiteshP/nvim-navic",
  dependencies = {
    {
      "utilyre/barbecue.nvim",
      config = function()
        require("barbecue").setup()
      end,
    },
  },
  event = "VeryLazy",
  config = function()
    local icons = require("core.icons")
    require("nvim-navic").setup({
      lsp = {
        auto_attach = true,
        preference = nil,
      },
      highlight = false,
      separator = " > ",
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
      lazy_update_context = false,
      click = false,
      format_text = function(text)
        return text
      end,
      icons = icons.kind,
    })
  end,
}
