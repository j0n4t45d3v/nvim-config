return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-project.nvim",
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      themes = "dropdowm",
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({})
        },
        project = {
          base_dirs = {
            "~/Documentos/workspace/java",
            "~/Documentos/workspace/php",
            "~/Documentos/workspace/golang",
          }
        }
      },
    })
    telescope.load_extension("ui-select")
    telescope.load_extension("project")
  end,
}
