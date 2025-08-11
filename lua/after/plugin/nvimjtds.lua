return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local status, jdtls = pcall(require, "jdtls")
    if not status then
      vim.notify("JDTLS", "Biblioteca não encontrada!")
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
          contentProvider = {
            preferred = "fernflower",
          },
          format = {
            enabled = true,
          },
          completion = {
            favoriteStaticMembers = {
              "org.junit.jupiter.api.Assertions.*",
              "org.mockito.Mockito.*",
            },
            filteredTypes = {
              "com.sun.*",
              "io.micrometer.shaded.*",
              "java.awt.*",
              "jdk.*",
              "sun.*",
            },
          },
        },
        signatureHelp = { enabled = true },
        extendedClientCapabilities = extended_client_capabilities,
      },
      init_options = {
        bundles = bundles,
      },
    }

    config["on_attach"] = function(client, bufnr)
      local _, _ = pcall(vim.lsp.codelens.refresh)
      require("jdtls").setup_dap({
        hotcodereplace = "auto",
        config_overrides = {},
      })
      require("core.lsp").default_on_attach(client, bufnr)

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
    end

    -- Started jdtls
    require("jdtls").start_or_attach(config)

    local status_ok, keybind = pcall(require, "core.keymap")
    if status_ok then
      local key = keybind.key
      local opt = keybind.opt

      -- Mapear no modo normal
      key.set({ "n", "v" }, "<leader>Jo", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opt("Organize Imports"))
      key.set({ "n", "v" }, "<leader>Jv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opt("Extract Variable"))
      key.set({ "n", "v" }, "<leader>JC", "<Cmd>lua require('jdtls').extract_constant()<CR>", opt("Extract Constant"))
      key.set("v", "<leader>Jm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opt("Extract Method"))
      key.set("n", "<leader>Jt", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opt("Test Method"))
      key.set("n", "<leader>JT", "<Cmd>lua require'jdtls'.test_class()<CR>", opt("Test Class"))
      key.set("n", "<leader>Ju", "<Cmd>JdtUpdateConfig<CR>", opt("Update Config"))
    end
  end,
}
