return {
  "marko-cerovac/material.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require("material").setup({
      lualine_style = "stealth",
    })

    vim.cmd([[colorscheme material-deep-ocean]])
  end,
}
