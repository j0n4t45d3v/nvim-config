return {
  "MunifTanjim/nui.nvim",
  config = function()
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    -- Substituir o prompt padrão por NUI
    vim.ui.input = function(opts, on_confirm)
      local input_box
      input_box = Input({
        position = { row = "50%", col = "50%" },
        size = { width = 40 },
        border = {
          style = "rounded",
          text = {
            top = opts.prompt or " Input ",
            top_align = "center",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
      }, {
        prompt = opts.prompt or "> ",
        default_value = opts.default,
        on_submit = function(value)
          input_box:unmount() -- Fecha o box ao enviar o valor
          on_confirm(value) -- Retorna o valor para o LSP
        end,
        on_close = function()
          input_box:unmount() -- Fecha o box se for cancelado
          on_confirm(nil) -- Indica cancelamento para o LSP
        end,
      })
      -- Mapeamento para fechar ao pressionar ESC
      input_box:map("n", "<ESC>", function()
        input_box:unmount()
        on_confirm(nil) -- Indica cancelamento
      end, { noremap = true })
      -- Fechar o box ao perder o foco
      input_box:on(event.BufLeave, function()
        input_box:unmount()
        on_confirm(nil)
      end)

      input_box:mount()
    end
  end,
}
