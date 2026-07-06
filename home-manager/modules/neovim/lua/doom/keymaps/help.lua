local R = require("doom.keymaps.register")

return function()
  R.add({
    { "<leader>h", group = "help" },
    { "<leader>hW", "<cmd>Telescope man_pages<cr>", desc = "Man pages", mode = "n" },
    { "<leader>ha", "<cmd>Telescope help_tags<cr>", desc = "Search help", mode = "n" },
    { "<leader>hF", "<cmd>Telescope highlights<cr>", desc = "Highlights", mode = "n" },
    { "<leader>ht", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", mode = "n" },
    { "<leader>hv", "<cmd>Telescope vim_options<cr>", desc = "Options", mode = "n" },
    { "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", mode = "n" },
    { "<leader>hm", "<cmd>set filetype?<cr>", desc = "Filetype", mode = "n" },
    { "<leader>hi", "<cmd>help<cr>", desc = "Help", mode = "n" },

    { "<leader>hd", group = "nvim" },
    { "<leader>hdb", "<cmd>checkhealth<cr>", desc = "Check health", mode = "n" },
    { "<leader>hdc", "<cmd>e ~/.config/nvim/<cr>", desc = "Open config", mode = "n" },
    { "<leader>hdv", "<cmd>version<cr>", desc = "Version", mode = "n" },

    { "<leader>hr", group = "reload" },
    { "<leader>hrr", "<cmd>source $MYVIMRC<cr>", desc = "Reload config (h)", mode = "n" },
    { "<leader>hrt", "<cmd>colorscheme dracula<cr>", desc = "Reload colorscheme", mode = "n" },
  })
end
