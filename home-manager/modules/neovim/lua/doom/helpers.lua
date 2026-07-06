local M = {}

local scratch_bufnr = nil
local scratch_name = "*scratch*"

function M.project_root()
  local ok, project = pcall(require, "project")
  if ok then
    return project.get_root(vim.fn.expand("%:p:h"), false)
  end
  return nil
end

function M.telescope_opts(cwd)
  local opts = {}
  if cwd then
    opts.cwd = cwd
  end
  return opts
end

function M.projectile_find_file()
  require("telescope.builtin").find_files(M.telescope_opts(M.project_root()))
end

function M.find_files_here()
  require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
end

function M.search_project()
  require("telescope.builtin").live_grep(M.telescope_opts(M.project_root()))
end

function M.search_other_project()
  require("telescope.extensions.projects").projects({
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local action = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
        require("telescope.actions").close(prompt_bufnr)
        if action and action.path then
          require("telescope.builtin").live_grep({ cwd = action.path })
        end
      end)
      return true
    end,
  })
end

function M.search_buffer()
  require("telescope.builtin").current_buffer_fuzzy_find()
end

function M.search_cwd()
  require("telescope.builtin").live_grep()
end

function M.search_other_cwd()
  require("telescope.builtin").live_grep({ cwd = vim.fn.input("Directory: ", vim.fn.getcwd(), "dir") })
end

function M.search_symbol_at_point()
  local word = vim.fn.expand("<cword>")
  if word == "" then
    return
  end
  require("telescope.builtin").grep_string({ search = word, cwd = M.project_root() })
end

function M.browse_project()
  local root = M.project_root()
  if root then
    vim.cmd("edit " .. vim.fn.fnameescape(root))
    require("nvim-tree.api").tree.open()
  else
    require("nvim-tree.api").tree.toggle()
  end
end

function M.yank_buffer_path(relative)
  local path = relative and vim.fn.expand("%:~:.") or vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Yanked: " .. path, vim.log.levels.INFO)
end

function M.yank_buffer_contents()
  vim.fn.setreg("+", table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"))
end

function M.toggle_scratch()
  if scratch_bufnr and vim.api.nvim_buf_is_valid(scratch_bufnr) then
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == scratch_bufnr then
        vim.api.nvim_win_close(win, true)
        return
      end
    end
  end
  M.open_scratch()
end

function M.open_scratch()
  if scratch_bufnr and vim.api.nvim_buf_is_valid(scratch_bufnr) then
    vim.api.nvim_set_current_buf(scratch_bufnr)
    return
  end
  scratch_bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(scratch_bufnr, scratch_name)
  vim.api.nvim_set_current_buf(scratch_bufnr)
  vim.bo[scratch_bufnr].filetype = "markdown"
end

function M.switch_scratch()
  if scratch_bufnr and vim.api.nvim_buf_is_valid(scratch_bufnr) then
    vim.api.nvim_set_current_buf(scratch_bufnr)
  else
    M.open_scratch()
  end
end

function M.eval_expression()
  vim.ui.input({ prompt = "Eval: " }, function(input)
    if input and input ~= "" then
      local chunk, err = load("return " .. input)
      if not chunk then
        chunk, err = load(input)
      end
      if chunk then
        local ok, result = pcall(chunk)
        if ok then
          vim.print(result)
        else
          vim.notify(tostring(result), vim.log.levels.ERROR)
        end
      else
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end)
end

function M.kill_other_buffers()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end

function M.kill_all_buffers()
  vim.cmd("bufdo bd")
end

function M.kill_buried_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if not vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

function M.delete_this_file()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return
  end
  vim.fn.delete(file)
  vim.cmd("bdelete!")
end

function M.rename_buffer()
  vim.cmd("file " .. vim.fn.input("New name: ", vim.fn.expand("%")))
end

function M.lsp_rename()
  local word = vim.fn.expand("<cword>")
  vim.cmd("IncRename " .. word)
end

function M.toggle_line_numbers()
  if vim.o.number and vim.o.relativenumber then
    vim.o.number = false
    vim.o.relativenumber = false
  elseif vim.o.number then
    vim.o.relativenumber = not vim.o.relativenumber
  else
    vim.o.number = true
    vim.o.relativenumber = true
  end
end

function M.run_terminal(cmd, direction)
  local ok, toggleterm = pcall(require, "toggleterm")
  if not ok then
    vim.cmd("terminal " .. (cmd or ""))
    return
  end
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new({
    cmd = cmd or vim.o.shell,
    direction = direction or "float",
    hidden = true,
  })
  term:toggle()
end

return M
