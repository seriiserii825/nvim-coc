" nnoremap <leader>a :w <bar> %bd <bar> e# <bar> bd# <CR>
"save all
nmap <leader>w :wa<CR>
nnoremap <Leader>x :g/^\s*$/d<CR>
nnoremap <Leader>z :%s/\s\{2,}/ /g<CR>
nnoremap <Leader>pc :w <bar> :source % <bar> :PlugClean<CR>
nnoremap <Leader>pi :w <bar> :source % <bar> :PlugInstall<CR>

"source init.vim
nnoremap <silent> <Leader>sn :source ~/.config/nvim/init.vim<CR>
nnoremap <silent> <Leader>sf :source %<CR>

" nmap <C-t> :let @+ = len(@+)<CR> 
"
nmap <leader>yc :RunCode<CR>
nmap <leader>yl :RunFile<CR>
nmap , :RunFile float<CR>
" nnoremap <silent><space>fw :Fmodules/which-key.vimiles <C-R><C-W><cr> 
" map to find word under cursor with fzf
" map <Leader>fw :call fzf#vim#files(expand('<cword>'))<kEnter>
" nnoremap <silent> <Leader>fw :Files <C-R><C-W><CR>
nnoremap <expr> <leader>fw ':Files <cr>' . "'" . expand('<cword>')
" map <Leader>+F to search in ag the word under the cursor
map <Leader>fg :call fzf#vim#ag(expand('<cword>'))<kEnter>

nmap <leader>fh :set filetype=html<CR>
nmap <leader>fp :set filetype=php<CR>

"rename word
" nmap <C-s> :%s/\<<C-r><C-w>\>/
" nmap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

nmap <C-c> :Colortils<CR>
" markdown
nmap <leader>mp <Plug>MarkdownPreview<CR>
" nmap <C-s> <Plug>MarkdownPreview
" nmap <leader>ms :CocCommand markdown-preview-enhanced.syncPreview<CR>
let b:surround_{char2nr('c')} = "```\r```"
" xnoremap <C-t>let @+ = wordcount().visual_words<CR>
"nmap <M-l> :wall<CR>
" File paths
" relative
map <silent> <leader>yr :let @+=expand("%")<CR> 
" absolute
map <silent> <leader>ya :let @+=expand("%:p")<CR>
" Filename
map <silent> <leader>yf :let @+=expand("%:t")<CR>
" Directory
" map <leader>yd :let @+=expand("%:p:h")<CR>

imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")

" remove empty lines
map <leader>i :g/^\s*$/d<CR>

nnoremap [n :set relativenumber!<CR>
" Relative path to file: %
" Absolute path to file: %:p
" Filename only: %:t
" Directory name only: %:p:h
" Move lines
" nnoremap <M-j> :m .+1<CR>==
" nnoremap <M-k> :m .-2<CR>==
" inoremap <M-j> <Esc>:m .+1<CR>==gi
" inoremap <M-k> <Esc>:m .-2<CR>==gi
" vnoremap <M-j> :m '>+1<CR>gv=gv
" vnoremap <M-k> :m '<-2<CR>gv=gv

" reselect pasted text
nnoremap gp `[v`]

" Sneak
" nnoremap m b
" xnoremap p "_dP

" duplicate line in normal mode:
" nnoremap <C-d> Yp
" duplicate line in insert mode:
" inoremap <C-d> <Esc> Ypi

" HtmlEscape
" nnoremap <Leader>z :'[,']call HtmlEscape()<CR>
" vnoremap <Leader>z :call HtmlEscape()<CR>
" function HtmlEscape()
" silent s/&/\&amp;/eg
" silent s/</\&lt;/eg
" silent s/>/\&gt;/eg
" endfunction

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
" nnoremap <Leader>o o<Esc>^Da
" nnoremap <Leader>O O<Esc>^Da

fu! Incremental_yank(type, ...) abort
 if a:type ==# 'char'
 norm! `[v`]y
 elseif a:type ==# 'line'
 norm! '[V']y
 elseif a:0
 norm! gvy
 endif

 call setreg('z', @".(a:type ==# 'char' ? ' ' : ''), 'a' . getregtype('"'))
 call setreg('"', @z, getregtype('z'))
endfu

nno <silent> zy :<C-U>set opfunc=Incremental_yank<CR>g@
xno <silent> zy :<C-U>call Incremental_yank(visualmode(), 1)<CR>
nno <silent> zyy :<C-U>set opfunc=Incremental_yank<Bar>exe 'norm! '.v:count1.'g@_'<CR>
nno <silent> zyc :<C-U>let [@", @z] = ['', '']<CR>p


