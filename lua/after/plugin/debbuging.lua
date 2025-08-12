return {
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    config = function()
      require("dap-go").setup()
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup({})

      local home = os.getenv("HOME")
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = home .. "/Documentos/dap/extension/debugAdapters/bin/OpenDebugAD7",
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
        },
        {
          name = "Attach to gdbserver :1234",
          type = "cppdbg",
          request = "launch",
          MIMode = "gdb",
          miDebuggerServerAddress = "localhost:1234",
          miDebuggerPath = "/usr/bin/gdb",
          cwd = "${workspaceFolder}",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
        },
      }

      local icons = require("core.icons")

      vim.fn.sign_define("DapBreakpoint", {
        text = icons.diagnostics.Debug,
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })
      vim.fn.sign_define("DapBreakpointRejected", {
        text = icons.diagnostics.Debug,
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })
      vim.fn.sign_define("DapStopped", {
        text = icons.ui.BoldArrowRight,
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
      })

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      local status_ok, keybind = pcall(require, "core.keymap")
      if not status_ok then
        vim.notify("KeyBind", "Falha ao importar as keybinds!")
        return
      end

      local key = keybind.key
      local opt = keybind.opt

      key.set("n", "<F5>", dap.continue, opt("Start/Continue debugging"))
      key.set("n", "<F8>", dap.step_over, opt("Step Over"))
      key.set("n", "<F7>", dap.step_into, opt("Step Over"))
      key.set("n", "<leader>dt", dap.toggle_breakpoint, opt("Toggle breakpoint"))
      key.set("n", "<leader>dc", dapui.toggle, opt("toggle dap ui"))
    end,
  },
}
