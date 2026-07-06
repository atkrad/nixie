local R = require("doom.keymaps.register")

return function()
  local dap = require("dap")
  R.add({
    { "<leader>d", group = "debugger" },
    { "<leader>dd", function() require("dap-go").debug_test() end, desc = "Debug test", mode = "n" },
    { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue", mode = "n" },
    { "<leader>dn", "<cmd>DapStepOver<cr>", desc = "Step over", mode = "n" },
    { "<leader>ds", "<cmd>DapStepInto<cr>", desc = "Step into", mode = "n" },
    { "<leader>do", "<cmd>DapStepOut<cr>", desc = "Step out", mode = "n" },
    { "<leader>di", function() require("dapui").toggle() end, desc = "Debug UI", mode = "n" },
    { "<leader>dR", function() dap.repl.open() end, desc = "Debug REPL", mode = "n" },
    { "<leader>de", function() dap.set_breakpoint(vim.fn.input("Expression: ")) end, desc = "Conditional breakpoint", mode = "n" },
    { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint", mode = "n" },
    { "<leader>dB", function() dap.clear_breakpoints() end, desc = "Clear breakpoints", mode = "n" },
    { "<leader>dx", function() dap.eval(vim.fn.input("Expression: ")) end, desc = "Evaluate expression", mode = "n" },
    { "<leader>dD", "<cmd>DapTerminate<cr>", desc = "Terminate session", mode = "n" },
  })
end
