local R = require("doom.keymaps.register")
local H = require("doom.helpers")

return function()
  R.add({
    { "<leader>b", group = "buffer" },
    { "<leader>b[", "<cmd>bprevious<cr>", desc = "Previous buffer", mode = "n" },
    { "<leader>b]", "<cmd>bnext<cr>", desc = "Next buffer", mode = "n" },
    { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Switch buffer", mode = "n" },
    { "<leader>bd", "<cmd>bd<cr>", desc = "Close buffer", mode = "n" },
    { "<leader>bK", H.kill_all_buffers, desc = "Close all buffers", mode = "n" },
    { "<leader>bl", "<cmd>e #<cr>", desc = "Switch to last buffer", mode = "n" },
    { "<leader>bN", "<cmd>enew<cr>", desc = "New empty buffer", mode = "n" },
    { "<leader>bO", H.kill_other_buffers, desc = "Close other buffers", mode = "n" },
    { "<leader>br", "<cmd>checktime | edit!<cr>", desc = "Revert buffer", mode = "n" },
    { "<leader>bR", H.rename_buffer, desc = "Rename buffer", mode = "n" },
    { "<leader>bs", "<cmd>w<cr>", desc = "Save buffer", mode = "n" },
    { "<leader>bS", "<cmd>wa<cr>", desc = "Save all buffers", mode = "n" },
    { "<leader>bx", H.open_scratch, desc = "Open scratch buffer", mode = "n" },
    { "<leader>bX", H.switch_scratch, desc = "Switch to scratch buffer (b)", mode = "n" },
    { "<leader>by", H.yank_buffer_contents, desc = "Yank buffer", mode = "n" },
    { "<leader>bz", "<cmd>hide<cr>", desc = "Hide buffer", mode = "n" },
    { "<leader>bZ", H.kill_buried_buffers, desc = "Close hidden buffers", mode = "n" },
  })
end
