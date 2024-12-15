return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      modules = {},
      ensure_installed = {},
      ignore_install = {},
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Move automaticamente para o próximo texto correspondente
          keymaps = {
            -- Definir text objects para funções
            ["af"] = "@function.outer", -- A função inteira
            ["if"] = "@function.inner", -- Apenas o conteúdo da função

            -- Definir text objects para classes
            ["ac"] = "@class.outer", -- A classe inteira
            ["ic"] = "@class.inner", -- Apenas o conteúdo da classe
          },
        },
        move = {
          enable = true,
          set_jumps = true,       -- Adiciona os movimentos ao jumplist
          goto_next_start = {
            ["]m"] = "@function.outer", -- Próximo início de função
            ["]c"] = "@class.outer", -- Próximo início de classe
          },
          goto_previous_start = {
            ["[m"] = "@function.outer", -- Função anterior
            ["[c"] = "@class.outer", -- Classe anterior
          },
        },
      },
    })
  end,
}
