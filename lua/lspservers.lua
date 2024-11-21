return function(lspconfig)
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
      root_dir = lspconfig.util.root_pattern("compose.json", ".git/", "*.php"),
    },
    html = {},
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    },
  }
end
