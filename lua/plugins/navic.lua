return {
  "SmiteshP/nvim-navic",
  config = function()
    local icons = require("core.icons")
    require("nvim-navic").setup({
      highlight = false,          -- Realce para os símbolos na winbar
      separator = " > ",          -- Separador entre os símbolos
      depth_limit = 0,            -- Número máximo de símbolos exibidos (0 = sem limite)
      depth_limit_indicator = "...", -- Indicador quando o limite for atingido
      icons = icons.kind,
    })
  end,
}
