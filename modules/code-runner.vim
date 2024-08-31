lua << EOF
require('code_runner').setup {
  filetype = {
    python = "python3 -u",
  },
  project_path = vim.fn.expand('~/.config/nvim/projects.json')
}

local function getProjectRootPath()
  local projects = o.get().project
  print(projects)
  local path = vim.fn.expand("%:p")
  print(path)
  -- for project_path, _ in pairs(projects) do
  --   path_full = vim.fs.normalize(project_path)
  --   if string.find(path, path_full) == 1 then
  --     current_proyect = projects[project_path]
  --     current_proyect["path"] = project_path
  --     print("Project: " .. project_path)
  --     -- return current_proyect
  --   end
  -- end
end

-- getProjectRootPath()

vim.keymap.set('n', '<leader>rc', ':RunCode<CR>', { noremap = true, silent = false })
vim.keymap.set('n', ',', ':RunFile float<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rx', ':RunClose<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rp', ':CRProjects<CR>', { noremap = true, silent = false })

EOF
