" -- for repository page
nmap <silent> <Leader>gr :OpenInGHRepo<CR>
" vim.api.nvim_set_keymap("n", "<Leader>gr", ":OpenInGHRepo <CR>", { silent = true, noremap = true })

" -- for current file page
nmap <silent> <Leader>gf :OpenInGHFile<CR>
vmap <silent> <Leader>gf :OpenInGHFileLines<CR>
" vim.api.nvim_set_keymap("n", "<Leader>gf", ":OpenInGHFile <CR>", { silent = true, noremap = true })
" vim.api.nvim_set_keymap("v", "<Leader>gf", ":OpenInGHFileLines <CR>", { silent = true, noremap = true })
