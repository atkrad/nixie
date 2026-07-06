local R = require("doom.keymaps.register")
local H = require("doom.helpers")

return function()
  R.add({
    { "<leader>q", group = "quit/session" },
    { "<leader>qf", "<cmd>close<cr>", desc = "Close window (q)", mode = "n" },
    { "<leader>qF", H.kill_all_buffers, desc = "Close all buffers (quit)", mode = "n" },
    { "<leader>qq", "<cmd>qa<cr>", desc = "Quit", mode = "n" },
    { "<leader>qQ", "<cmd>qa!<cr>", desc = "Quit without saving", mode = "n" },
    { "<leader>qs", function() require("persistence").save() end, desc = "Save session", mode = "n" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session (q)", mode = "n" },
    { "<leader>qL", function() require("persistence").load() end, desc = "Restore session", mode = "n" },
    { "<leader>qr", "<cmd>source $MYVIMRC<cr>", desc = "Reload config (q)", mode = "n" },
  })
end
