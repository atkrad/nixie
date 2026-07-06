local R = require("doom.keymaps.register")

return function()
  R.add({
    { "<leader>w", group = "window" },
    { "<leader>wh", "<C-w>h", desc = "Window left", mode = "n" },
    { "<leader>wj", "<C-w>j", desc = "Window down", mode = "n" },
    { "<leader>wk", "<C-w>k", desc = "Window up", mode = "n" },
    { "<leader>wl", "<C-w>l", desc = "Window right", mode = "n" },
    { "<leader>ww", "<C-w>w", desc = "Other window", mode = "n" },
    { "<leader>wW", "<C-w>W", desc = "Previous window", mode = "n" },
    { "<leader>wv", "<C-w>v", desc = "Split vertical", mode = "n" },
    { "<leader>ws", "<C-w>s", desc = "Split horizontal", mode = "n" },
    { "<leader>wo", "<C-w>o", desc = "Close other windows", mode = "n" },
    { "<leader>wc", "<C-w>c", desc = "Close window", mode = "n" },
    { "<leader>wq", "<C-w>q", desc = "Quit window", mode = "n" },
    { "<leader>w=", "<C-w>=", desc = "Balance windows", mode = "n" },
    { "<leader>wm", "<cmd>only<cr>", desc = "Maximize", mode = "n" },
    { "<leader>wH", "<C-w>H", desc = "Move window left", mode = "n" },
    { "<leader>wJ", "<C-w>J", desc = "Move window down", mode = "n" },
    { "<leader>wK", "<C-w>K", desc = "Move window up", mode = "n" },
    { "<leader>wL", "<C-w>L", desc = "Move window right", mode = "n" },
    { "<leader>wr", "<C-w>r", desc = "Rotate windows", mode = "n" },
    { "<leader>w-", "<C-w>-", desc = "Decrease height", mode = "n" },
    { "<leader>w+", "<C-w>+", desc = "Increase height", mode = "n" },
    { "<leader>w_", "<C-w>_", desc = "Max out height", mode = "n" },
    { "<leader>w<", "<C-w><", desc = "Decrease width", mode = "n" },
    { "<leader>w>", "<C-w>>", desc = "Increase width", mode = "n" },
    { "<leader>w|", "<C-w>|", desc = "Max out width", mode = "n" },
  })
end
