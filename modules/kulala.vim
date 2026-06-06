" sudo pacman -S tree-sitter-cli

autocmd BufNewFile,BufRead *.http setfiletype http
autocmd BufNewFile,BufRead *.rest setfiletype http

lua << EOF
require('kulala').setup({
	global_keymaps = false,
	global_keymaps_prefix = "<leader>R",
	kulala_keymaps_prefix = "",
})
EOF

nnoremap <silent> <leader>rr :lua require('kulala').run()<CR>
nnoremap <silent> <leader>ra :lua require('kulala').run_all()<CR>
nnoremap <silent> <leader>ri :lua require('kulala').inspect()<CR>
nnoremap <silent> <leader>rT :lua require('kulala').toggle_view()<CR>
nnoremap <silent> <leader>rp :lua require('kulala').jump_prev()<CR>
nnoremap <silent> <leader>rn :lua require('kulala').jump_next()<CR>
nnoremap <silent> <leader>rc :lua require('kulala').copy()<CR>
nnoremap <silent> <leader>rq :lua require('kulala').close()<CR>
nnoremap <silent> <leader>rb :lua require('kulala').scratchpad()<CR>
nnoremap <silent> <leader>rs :lua require('kulala').search()<CR>
