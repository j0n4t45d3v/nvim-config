return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "bufwinenter",
	config = function()
		local ui_icons = require("core.icons").ui
		require("lualine").setup({
			options = {
        theme = 'tokyonight',
				disabled_filetypes = {
					statusline = { "NvimTree" },
				},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str) -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
							return " " .. str
						end,
					},
				},
				lualine_c = {
					-- Aqui você adiciona o ícone do debug se estiver ativado
					{
						function()
							local is_debug_active = function()
								-- Verifique aqui se o debug está ativado, por exemplo, uma variável global
								return vim.g.debug_active == true
							end
							if is_debug_active() then
								return ui_icons.Connect
							else
								return ui_icons.Disconnect
							end
						end,
						icon = "" .. ui_icons.Bug .. " Debugger:",
						color = { fg = "#cfcfcf", gui = "bold" }, -- Customize a cor
					},
				},
				lualine_x = {
					{
						"lsp_progress", -- Exibe o progresso de LSP
						display_components = { "spinner", "percentage" }, -- Customize a exibição
						always_visible = true,
					},
					{
						function()
							local clients = vim.lsp.get_clients()
							if #clients > 0 then
								return "["
									.. table.concat(
										vim.tbl_map(function(client)
											return client.name
										end, clients),
										", "
									)
									.. "]"
							else
								return "No LSP"
							end
						end,
						icon = ui_icons.Lsp .. ":",
						color = { fg = "#cfcfcf", gui = "bold" }, -- Customize a cor
					},
					"filetype",
					"encoding",
					"fileformat",
				},
			},
			inactive_sections = {
				lualine_a = {
					{
						"filename",
						fmt = function(str) -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
							return " " .. str
						end,
					},
				},
				lualine_c = {},
				lualine_x = {},
			},
		})
	end,
}
