local key = vim.keymap
local opt = function(desc)
  local default_opt = { silent = true, noremap = true }
  default_opt["desc"] = desc
  return default_opt
end

return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
  },
  key.set("n", "<leader>gbt", "<cmd>Gitsigns toggle_current_line_blame<cr>", opt("[G]it [B]lame Line [T]oggle"))
}
