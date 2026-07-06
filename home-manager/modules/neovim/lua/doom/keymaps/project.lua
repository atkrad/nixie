local R = require("doom.keymaps.register")
local H = require("doom.helpers")

return function()
  R.add({
    { "<leader>p", group = "project" },
    { "<leader>p.", H.browse_project, desc = "Browse project", mode = "n" },
    { "<leader>pb", "<cmd>Telescope buffers<cr>", desc = "Project buffers", mode = "n" },
    { "<leader>pf", H.projectile_find_file, desc = "Find file in project", mode = "n" },
    { "<leader>pk", H.kill_other_buffers, desc = "Close other buffers (p)", mode = "n" },
    { "<leader>pp", "<cmd>Telescope projects<cr>", desc = "Switch project", mode = "n" },
    { "<leader>pr", "<cmd>Telescope oldfiles<cr>", desc = "Recent project files", mode = "n" },
    { "<leader>ps", "<cmd>wa<cr>", desc = "Save all files", mode = "n" },
    { "<leader>px", H.toggle_scratch, desc = "Toggle scratch buffer (p)", mode = "n" },
    { "<leader>pX", H.switch_scratch, desc = "Switch to scratch buffer (p)", mode = "n" },
  })
end
