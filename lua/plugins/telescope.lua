return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-project.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      themes = "dropdowm",
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
        project = {
          base_dirs = {
            "~/Documentos/workspace/java",
            "~/Documentos/workspace/php",
            "~/Documentos/workspace/golang",
          },
        },
        fzf = {
          fuzzy = true,              -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case",  -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    })
    telescope.load_extension("ui-select")
    telescope.load_extension("project")
    telescope.load_extension("fzf")
  end,
}
