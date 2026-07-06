local M = {}

local modules = {
  "doom.keymaps.root",
  "doom.keymaps.workspace",
  "doom.keymaps.buffer",
  "doom.keymaps.code",
  "doom.keymaps.debug",
  "doom.keymaps.file",
  "doom.keymaps.git",
  "doom.keymaps.open",
  "doom.keymaps.project",
  "doom.keymaps.quit",
  "doom.keymaps.search",
  "doom.keymaps.toggle",
  "doom.keymaps.help",
  "doom.keymaps.window",
}

function M.setup()
  for _, name in ipairs(modules) do
    require(name)()
  end
end

return M
