" Enable true color
set termguicolors

" Set keymap to open Yazi
lua << EOF
vim.keymap.set("n", "<leader>e", function()
  require("yazi").yazi()
end, { desc = "Open Yazi at current file" })

vim.keymap.set("n", "<leader>cw", "<cmd>Yazi cwd<cr>", { desc = "Yazi: CWD" })
vim.keymap.set("n", "<C-Up>", "<cmd>Yazi toggle<cr>", { desc = "Yazi: Toggle last session" })

-- Optional settings
require("yazi").setup({
  open_for_directories = false,
  keymaps = {
    show_help = "<F1>",
  },
})
EOF
