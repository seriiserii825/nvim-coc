let g:floaterm_wintype = 'float'
let g:floaterm_width = 0.96
let g:floaterm_height = 0.96

let g:floaterm_keymap_toggle = '<C-;>'

" <C-p>: separate terminal opened in the active file's dir (project.nvim chdirs to root).
" Next toggles reuse it until it exits.
function! s:FloatermToggleHere() abort
  if floaterm#terminal#get_bufnr('here') == -1
    let l:dir = expand('%:p:h')
    if &buftype !=# '' || !isdirectory(l:dir)
      let l:dir = getcwd()
    endif
    execute 'FloatermNew --name=here --cwd=' . fnameescape(l:dir)
  else
    FloatermToggle here
  endif
endfunction

nnoremap <silent> <C-p> :call <SID>FloatermToggleHere()<CR>
tnoremap <silent> <C-p> <C-\><C-n>:call <SID>FloatermToggleHere()<CR>

" Files
nmap <leader>ff :Files<CR>
nmap <leader>fs :vs <bar> :Files<CR>
" nmap <leader>fv :vs<CR><C-w>h
nmap <leader>fb :Buffers<CR>

nmap <silent> <expr> <leader>fw ":Files <cr>" . (exists("g:floaterm_instance") ? substitute(expand('<cword>'), "^'", "", "") : expand('<cword>'))

" nmap <leader>fn :FilesSameName<CR>
" nmap <leader>fz :FilesSameNameSplit<CR>
nmap <leader>fu :FilesSameBaseName<CR>
nmap <leader>fy :FilesSameBaseNameSplit<CR>

nmap <Leader>fg :RG <C-r><C-w><CR>
nmap <Leader>rg :RG<CR>
" Git
nmap <leader>fr :GFiles?<CR>
nmap <leader>fc :Commits<CR>
nmap <leader>fd :Gdiff<CR>
nmap <leader>fm :BCommits<CR>


nmap <leader>fv :call CustomMapping()<CR>
function! CustomMapping()
    vs
    wincmd h
    call timer_start(100, {-> execute(':BufferLineCyclePrev')})
endfunction
