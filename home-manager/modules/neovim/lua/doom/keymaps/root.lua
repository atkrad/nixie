local R = require("doom.keymaps.register")
local H = require("doom.helpers")

return function()
  R.add({
    { "<leader>;", H.eval_expression, desc = "Eval expression", mode = "n" },
    { "<leader>:", "<cmd>Telescope commands<cr>", desc = "Commands", mode = "n" },
    { "<leader>w", group = "window" },
    { "<leader>h", group = "help" },
    { "<leader>.", "<cmd>Telescope find_files<cr>", desc = "Find file (.)", mode = "n" },
    { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Switch buffer (,)", mode = "n" },
    { "<leader>`", "<cmd>e #<cr>", desc = "Switch to last buffer (`)", mode = "n" },
    { "<leader>'", "<cmd>Telescope resume<cr>", desc = "Resume last search", mode = "n" },
    { "<leader>*", H.search_symbol_at_point, desc = "Search symbol in project", mode = "n" },
    { "<leader>/", H.search_project, desc = "Search project (/)", mode = "n" },
    { "<leader><Space>", H.projectile_find_file, desc = "Find file in project (SPC)", mode = "n" },
    { "<leader><CR>", "<cmd>Telescope marks<cr>", desc = "Jump to mark (CR)", mode = "n" },
    { "<leader>x", H.toggle_scratch, desc = "Toggle scratch buffer (x)", mode = "n" },
  })
end
