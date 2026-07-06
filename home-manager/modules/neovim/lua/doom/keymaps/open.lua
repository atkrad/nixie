local R = require("doom.keymaps.register")
local H = require("doom.helpers")

return function()
  R.add({
    { "<leader>o", group = "open" },
    { "<leader>of", "<cmd>tabnew<cr>", desc = "New tab", mode = "n" },
    { "<leader>op", "<cmd>NvimTreeToggle<cr>", desc = "Project sidebar", mode = "n" },
    { "<leader>oP", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal file in tree", mode = "n" },
    { "<leader>ot", function() H.run_terminal(nil, "float") end, desc = "Toggle terminal (float)", mode = "n" },
    { "<leader>oT", function() H.run_terminal(nil, "horizontal") end, desc = "Open terminal (split)", mode = "n" },
  })
end
