return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup {}     -- Configuração básica do which-key
  end
}
