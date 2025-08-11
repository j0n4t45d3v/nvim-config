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
				width = 50,
				side = "right",
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
				group_empty = true,
			},
			git = {
				enable = true,
			},
			filters = {
				dotfiles = false,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close"))
				vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
			end,
		})
	end,
}
