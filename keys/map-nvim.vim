"save all
nmap <leader>w :wa<CR>
nmap _ i <Esc>

inoremap <C-i> <C-r>=@i<CR>
" remove empty lines
" 
nnoremap <silent> <Leader>x :g/^\s*$/d<CR>
" remove trailing spaces
nnoremap <silent> <Leader>z :%s/\s\{2,}/ /g<CR>
" open in browser
nmap <silent> <leader>ob :w <Bar> !xdg-open %<CR>
"source init.vim
nnoremap <silent> <Leader>sn :source ~/.config/nvim/init.vim<CR>
nnoremap <silent> <Leader>sf :source %<CR>
" count symbols in buffer
nmap <silent> <C-t> :let @+ = len(@+)<CR> 
" code runner
nmap <leader>yc :RunCode<CR>
nmap <leader>yl :RunFile<CR>
nmap , :RunFile float<CR>
"rename word
vnoremap <leader>rn "zy:s/<C-r>z/
vnoremap <leader>rna "zy:%s/<C-r>z/
nmap <leader>vs "iyi"
let b:surround_{char2nr('c')} = "```\r```"
" File paths
" relative
map <silent> <leader>yr :let @+=expand("%")<CR> 
" absolute
map <silent> <leader>ya :let @+=expand("%:p")<CR>
" Filename
map <silent> <leader>yn :let @+=expand("%:t")<CR>
" Directory
map <silent><leader>yd :let @+=expand("%:p:h")<CR>
nnoremap [n :set relativenumber!<CR>
" Move lines
" nnoremap <M-j> :m .+1<CR>==
" nnoremap <M-k> :m .-2<CR>==
" vnoremap <M-j> :m '>+1<CR>gv=gv
" vnoremap <M-k> :m '<-2<CR>gv=gv
" reselect pasted text
nnoremap gp `[v`]
" Reset highlight
nnoremap <leader>nh :nohl<CR>
" Use alt + hjkl to resize windows
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>
" I hate escape more than anything else
imap jj <esc>
" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" HtmlEscape
" nnoremap <Leader>z :'[,']call HtmlEscape()<CR>
" vnoremap <Leader>z :call HtmlEscape()<CR>
" function HtmlEscape()
" silent s/&/\&amp;/eg
" silent s/</\&lt;/eg
" silent s/>/\&gt;/eg
" endfunction
