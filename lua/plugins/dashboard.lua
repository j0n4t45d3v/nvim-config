return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    local icons = require("icons")

    -- Botões do Dashboard
    dashboard.section.buttons.val = {
      dashboard.button("n", icons.ui.NewFile .. " Novo arquivo", ":ene <BAR> startinsert<CR>"),
      dashboard.button("f", icons.ui.FindFile .. " Buscar arquivos", ":Telescope find_files<CR>"),
      dashboard.button("p", icons.ui.Project .. " Projetos", ":Telescope project<CR>"),
      dashboard.button("r", "  Recentes", ":Telescope oldfiles<CR>"),
      dashboard.button("c", icons.ui.Gear .. " Configurações", ":e $MYVIMRC<CR>"),
      dashboard.button("q", icons.ui.Close .. "  Sair", ":qa<CR>"),
    }

    alpha.setup(dashboard.opts)
  end,
}
