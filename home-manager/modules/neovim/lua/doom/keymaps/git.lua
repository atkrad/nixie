local R = require("doom.keymaps.register")

return function()
  R.add({
    { "<leader>g", group = "git" },
    { "<leader>gR", "<cmd>e!<cr>", desc = "Revert file", mode = "n" },
    { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Revert hunk", mode = "n" },
    { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk", mode = "n" },
    { "<leader>g]", "<cmd>Gitsigns next_hunk<cr>", desc = "Next hunk", mode = "n" },
    { "<leader>g[", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous hunk", mode = "n" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Switch branch", mode = "n" },
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Git status", mode = "n" },
    { "<leader>gG", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Git status (here)", mode = "n" },
    { "<leader>gB", "<cmd>Gitsigns blame_line<cr>", desc = "Git blame", mode = "n" },
    { "<leader>gF", "<cmd>Neogit fetch<cr>", desc = "Git fetch", mode = "n" },
    { "<leader>gL", "<cmd>Neogit log<cr>", desc = "Git log", mode = "n" },
    { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage file", mode = "n" },
    { "<leader>gU", "<cmd>Gitsigns undo_stage<cr>", desc = "Unstage file", mode = "n" },

    { "<leader>gf", group = "find" },
    { "<leader>gff", "<cmd>Telescope git_files<cr>", desc = "Git files", mode = "n" },
    { "<leader>gfc", "<cmd>Telescope git_commits<cr>", desc = "Git commits", mode = "n" },

    { "<leader>gc", group = "create" },
    { "<leader>gcc", "<cmd>Neogit commit<cr>", desc = "Commit", mode = "n" },
    { "<leader>gcb", "<cmd>Neogit branch<cr>", desc = "Branch", mode = "n" },
  })
end
