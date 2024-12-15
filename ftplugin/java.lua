local status, jdtls = pcall(require, "jdtls")
if not status then
  return
end

local home = os.getenv("HOME")
local workspace_jdtls_path = home .. "/.local/share/nvim/jdtls_workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_jdtls_dir = workspace_jdtls_path .. project_name

local os_config = "linux"

if vim.fn.has("mac") == 1 then
  os_config = "mac"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local extended_client_capabilities = jdtls.extendedClientCapabilities
extended_client_capabilities.resolveAddtionalTextEditsSupport = true

-- Configurable DAP debug java

local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
    "\n"
  )
)

local config = {
  -- command start lsp java configured
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
    "-jar",
    vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. os_config,
    "-data",
    workspace_jdtls_dir,
  },
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  capabilities = capabilities,

  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-1.8-TEM",
            path = home .. "/.sdkman/candidates/java/8.0.412-tem",
          },
          {
            name = "Java-21-TEM",
            path = home .. "/.sdkman/candidates/java/21.0.2-tem",
          },
          {
            name = "Java-21-GRAAL",
            path = home .. "/.sdkman/candidates/java/21.0.2-graal",
          },
          {
            name = "Java-17-TEM",
            path = home .. "/.sdkman/candidates/java/17.0.11-tem",
          },
        },
      },
      maven = {
        downloadSources = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all", -- literals, all, none
        },
      },
      format = {
        enabled = false,
      },
    },
    signatureHelp = { enabled = true },
    extendedClientCapabilities = extended_client_capabilities,
  },
  init_options = {
    bundles = bundles,
    classpath = home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
  },
}

config["on_attach"] = function(client, bufnr)
  local _, _ = pcall(vim.lsp.codelens.refresh)
  require("jdtls").setup_dap({
    hotcodereplace = "auto",
    config_overrides = {},
  })

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
  -- Helper para facilitar os mapeamentos
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  buf_set_keymap(
    "n",
    "gd",
    "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>",
    { noremap = true, silent = true, desc = "Go to definition" }
  )

  -- Go-to declaração
  buf_set_keymap(
    "n",
    "gD",
    "<cmd>lua vim.lsp.buf.declaration()<CR>",
    { noremap = true, silent = true, desc = "Go to declaration" }
  )

  -- Go-to implementação
  buf_set_keymap(
    "n",
    "gi",
    "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>",
    { noremap = true, silent = true, desc = "Go to implementation" }
  )

  -- Go-to tipo
  buf_set_keymap(
    "n",
    "gt",
    "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>",
    { noremap = true, silent = true, desc = "Go to type definition" }
  )

  buf_set_keymap(
    "n",
    "<leader>lr",
    "<cmd>lua vim.lsp.buf.rename()<CR>",
    { noremap = true, silent = true, desc = "Rename" }
  )
  -- Mostrar referências
  buf_set_keymap(
    "n",
    "gr",
    "<cmd>lua require('telescope.builtin').lsp_references()<CR>",
    { noremap = true, silent = true, desc = "Show references" }
  )

  -- Hover (ajuda)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true, desc = "Helper" })

  -- Exibir assinatura (documentação inline)
  buf_set_keymap(
    "n",
    "<leader>hs",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    { noremap = true, silent = true, desc = "Show signature help" }
  )
end

local status_ok, jdtls_dap = pcall(require, "jdtls.dap")
if status_ok then
  jdtls_dap.setup_dap_main_class_configs()
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
})

-- Started jdtls
require("jdtls").start_or_attach(config)
