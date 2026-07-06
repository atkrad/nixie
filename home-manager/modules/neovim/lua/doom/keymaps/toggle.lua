local R = require("doom.keymaps.register")

return function()
  R.add({
    { "<leader>t", group = "toggle" },
    { "<leader>tc", "<cmd>set colorcolumn=<cr>", desc = "Color column", mode = "n" },
    { "<leader>td", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Git blame (line)", mode = "n" },
    { "<leader>tI", "<cmd>set expandtab!<cr>", desc = "Expand tab", mode = "n" },
    { "<leader>tl", function() require("doom.helpers").toggle_line_numbers() end, desc = "Line numbers", mode = "n" },
    { "<leader>tr", "<cmd>set readonly!<cr>", desc = "Read-only", mode = "n" },
    { "<leader>ts", "<cmd>set spell!<cr>", desc = "Spell check", mode = "n" },
    { "<leader>tw", "<cmd>set wrap!<cr>", desc = "Line wrap", mode = "n" },
  })
end
