local R = require("doom.keymaps.register")

return function()
  R.add({
    { "<leader><Tab>", group = "session" },
    { "<leader><Tab>.", function() require("persistence").load() end, desc = "Switch session", mode = "n" },
    { "<leader><Tab>`", function() require("persistence").load({ last = true }) end, desc = "Restore last session", mode = "n" },
  })
end
