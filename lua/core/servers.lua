return {
	clangd = {},
	gopls = {},
	pyright = {},
	ts_ls = {
		filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
	},
	intelephense = {
		settings = {
			intelephense = {
				files = {
					maxSize = 5000000, -- Aumenta o limite de tamanho de arquivos
				},
			},
		},
	},
	bashls = {},
	html = {},
	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
        diagnostics = {
          globals = {
            'vim',
            'require'
          }
        }
			},
		},
	},
}
