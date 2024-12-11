return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    local nvim_tree = require("nvim-tree")
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    nvim_tree.setup({
      hijack_netrw = true,
      update_cwd = true,
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      view = {
        width = 30,
        side = "left",
      },
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      git = {
        enable = true,
      },
      filters = {
        dotfiles = false,
      },
    })
  end,
}
