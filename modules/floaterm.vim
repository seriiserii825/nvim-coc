let g:floaterm_wintype = 'float'
let g:floaterm_width = 0.96
let g:floaterm_height = 0.96

let g:floaterm_keymap_toggle = '<C-;>'

" Files
nmap <leader>ff :Files<CR>
nmap <leader>fs :vs <bar> :Files<CR>
" nmap <leader>fv :vs<CR><C-w>h
nmap <leader>fb :Buffers<CR>

nmap <silent> <expr> <leader>fw ":Files <cr>" . (exists("g:floaterm_instance") ? substitute(expand('<cword>'), "^'", "", "") : expand('<cword>'))

nmap <Leader>fg :call fzf#vim#ag(expand('<cword>'))<kEnter>
nmap <Leader>rg :Rg<CR>
" Git
nmap <leader>fr :GFiles?<CR>
nmap <leader>fc :Commits<CR>
nmap <leader>fd :Gdiff<CR>
nmap <leader>ft :BCommits<CR>

nmap <leader>fv :call CustomMapping()<CR>
function! CustomMapping()
    vs
    wincmd h
    call timer_start(100, {-> execute(':BufferLineCyclePrev')})
endfunction
