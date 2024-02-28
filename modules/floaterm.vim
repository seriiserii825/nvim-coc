let g:floaterm_wintype = 'float'
let g:floaterm_width = 0.96
let g:floaterm_height = 0.96

let g:floaterm_keymap_toggle = '<C-b>'

" Files
nmap <leader>ff :Files<CR>
nmap <leader>fb :Buffers<CR>
nmap <leader>fr :Rg<CR>
" Git
nmap <leader>fg :GFiles?<CR>
nmap <leader>fc :Commits<CR>
nmap <leader>fd :Gdiff<CR>
nmap <leader>ft :BCommits<CR>

"       \ 'c' : [':Commits'      , 'commits'],
"       \ 'C' : [':BCommits'     , 'buffer commits'],

