return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        separator_style = "slope",
        show_buffer_icons = true,
        numbers = "buffer_id",
        max_name_length = 18,
        max_prefix_length = 15,
        diagnostics = "nvim_lsp", -- Mostra informações de erro do LSP
        offsets = {
          {
            filetype = "NvimTree", -- Ajusta para que não sobreponha a barra lateral do NvimTree
            text = "File Explorer", -- Texto a ser exibido no offset
            highlight = "Directory",
            text_align = "left",
          },
        },
        close_command = "bdelete! %d",   -- Comando para fechar buffers
        right_mouse_command = "bdelete! %d", -- Fecha com clique direito
        always_show_bufferline = false,
      },
    })

    local key = vim.keymap
    local opt = { silent = true, noremap = true }
    local opts = function(desc)
      return vim.tbl_extend("force", { desc = desc }, opt)
    end
    key.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", opts("Next Buffer"))
    key.set("n", "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", opts("Prev Buffer"))
    key.set("n", "<leader>c", "<cmd>bdelete<cr>", opts("Close Buffer"))
  end,
}
