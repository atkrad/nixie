local R = require("doom.keymaps.register")
local H = require("doom.helpers")

return function()
  R.add({
    { "<leader>c", group = "code" },
    { "<leader>cc", "<cmd>make<cr>", desc = "Compile", mode = "n" },
    { "<leader>cC", "<cmd>silent make clean | make<cr>", desc = "Recompile", mode = "n" },
    { "<leader>cd", "<cmd>Lspsaga goto_definition<cr>", desc = "Go to definition", mode = "n" },
    { "<leader>cD", "<cmd>Telescope lsp_references<cr>", desc = "References", mode = "n" },
    { "<leader>cf", function() vim.lsp.buf.format({ async = false }) end, desc = "Format buffer", mode = "n" },
    { "<leader>ci", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations", mode = "n" },
    { "<leader>ck", "K", desc = "Documentation", mode = "n" },
    { "<leader>ct", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type definition", mode = "n" },
    { "<leader>cw", "<cmd>%s/\\s\\+$//e<cr>", desc = "Trim trailing whitespace", mode = "n" },
    { "<leader>cx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics", mode = "n" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = "n" },
    { "<leader>cl", "<cmd>LspInfo<cr>", desc = "LSP info", mode = "n" },
    { "<leader>cr", H.lsp_rename, desc = "Rename", mode = "n" },
    { "<leader>cS", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols (LSP)", mode = "n" },
    { "<leader>cj", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols (LSP)", mode = "n" },
    { "<leader>cJ", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "All workspace symbols", mode = "n" },
  })
end
