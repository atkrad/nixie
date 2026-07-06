local R = require("doom.keymaps.register")
local H = require("doom.helpers")

return function()
  R.add({
    { "<leader>s", group = "search" },
    { "<leader>sb", H.search_buffer, desc = "Search buffer", mode = "n" },
    { "<leader>sB", "<cmd>Telescope grep_string<cr>", desc = "Search open buffers", mode = "n" },
    { "<leader>sd", H.search_cwd, desc = "Search directory", mode = "n" },
    { "<leader>sD", H.search_other_cwd, desc = "Search other directory", mode = "n" },
    { "<leader>si", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols (search)", mode = "n" },
    { "<leader>sI", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols (all)", mode = "n" },
    { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist", mode = "n" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks", mode = "n" },
    { "<leader>sp", H.search_project, desc = "Search project (p)", mode = "n" },
    { "<leader>sP", H.search_other_project, desc = "Search other project", mode = "n" },
    { "<leader>sS", H.search_symbol_at_point, desc = "Search word under cursor", mode = "n" },
  })
end
