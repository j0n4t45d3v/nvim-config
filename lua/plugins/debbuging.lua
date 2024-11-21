return {
    {
        "leoluz/nvim-dap-go",
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
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            require("dapui").setup()
            require("nvim-dap-virtual-text").setup({})

            dap.adapters.cppdbg = {
                id = "cppdbg",
                type = "executable",
                command = "/home/jonatasroot/Documentos/dap/extension/debugAdapters/bin/OpenDebugAD7",
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

            local icons = require("icons")

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

            local key = vim.keymap

            key.set("n", "<F5>", function()
                require("dap").continue()
            end, { desc = "Start/Continue debugging" })

            key.set("n", "<F8>", function()
                require("dap").step_over()
            end, { desc = "Step Over" })

            key.set("n", "<F7>", function()
                require("dap").step_into()
            end, { desc = "Step Over" })

            key.set("n", "<leader>dt", function()
                require("dap").toggle_breakpoint()
            end, { desc = "Toggle breakpoint" })

            key.set("n", "<leader>cdu", function()
                require("dapui").toggle()
            end, { desc = "toggle dap ui" })
        end,
    },
}
