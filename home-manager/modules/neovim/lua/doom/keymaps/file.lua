local R = require("doom.keymaps.register")
local H = require("doom.helpers")

return function()
  R.add({
    { "<leader>f", group = "file" },
    { "<leader>fd", "<cmd>NvimTreeToggle<cr>", desc = "File tree", mode = "n" },
    { "<leader>fD", H.delete_this_file, desc = "Delete file", mode = "n" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find file", mode = "n" },
    { "<leader>fF", H.find_files_here, desc = "Find file (here)", mode = "n" },
    { "<leader>fp", "<cmd>e ~/.config/nvim/<cr>", desc = "Find file in config", mode = "n" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files", mode = "n" },
    { "<leader>fs", "<cmd>w<cr>", desc = "Save file", mode = "n" },
    { "<leader>fS", "<cmd>saveas<cr>", desc = "Save file as", mode = "n" },
    { "<leader>fy", function() H.yank_buffer_path(false) end, desc = "Yank file path", mode = "n" },
    { "<leader>fY", function() H.yank_buffer_path(true) end, desc = "Yank project-relative path", mode = "n" },
  })
end
