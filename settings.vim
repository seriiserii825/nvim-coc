autocmd FocusLost * silent! wall
" set spell
" set spelllang=en-us

" exec current python file code in neovim
" nnoremap <leader>y :exec '!python3' shellescape(@%, 1)<CR>
" nnoremap , :vs <CR> :term python3 % <CR>
" let g:user_emmet_expandabbr_key='<C-;>'

" set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
" set list

au FileType html let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js', 'tailwind.config.cjs']
au FileType php let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js', 'tailwind.config.cjs']
au FileType vue let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js', 'tailwind.config.cjs']

aug i3config_ft_detection
  au!
  au BufNewFile,BufRead /home/serii/xubuntu/i3/config set filetype=i3config
  au BufNewFile,BufRead /home/serii/xubuntu/i3/autostart set filetype=i3config
  au BufNewFile,BufRead /home/serii/xubuntu/i3/keyboard set filetype=i3config
  au BufNewFile,BufRead /home/serii/xubuntu/i3/window-rules set filetype=i3config
  au BufNewFile,BufRead /home/serii/xubuntu/i3/workspaces set filetype=i3config
  au BufNewFile,BufRead /home/serii/xubuntu/i3status/config set filetype=i3config
aug end
"Disable 
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0

hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" set spellfile=~/.config/nvim/spell/en.utf-8.add

let g:sneak#label = 1

" set leader key
let g:mapleader = "\<Space>"
let g:indent_guides_enable_on_vim_startup = 1

" let g:config.health.checker = 0
" set nolazyredraw 
set textwidth=0 wrapmargin=0
set noswapfile
set foldmethod=indent
setlocal foldenable
set foldnestmax=20
set foldlevelstart=1
set foldlevel=1
filetype plugin on
" set nofoldenable
set lazyredraw " macros repeat
set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes
syntax enable                           " Enables syntax 
set hidden                              " Required to keep multiple buffers open multiple buffers
set scrolloff=20                              " Required to keep multiple buffers open multiple buffers
set inccommand=nosplit
set nowrap                              " Display long lines as just one line
set textwidth=0 
set wrapmargin=0
set undofile
" set autoread=1
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set cmdheight=1                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set smartindent
filetype plugin indent on
set laststatus=0                        " Always display the status line
set number                      " Line numbers
set cursorline                          " Enable highlighting of the current line
set cursorcolumn                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments

set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber 
set clipboard=unnamedplus               " Copy paste between vim and everything else

let g:coc_filetype_map = {
  \ 'pug': 'jade',
  \ }


function! VisualRelative(start, end)
  let l1 = line('.') + a:start
  let l2 = line('.') + a:end
  if l1 > l2
    execute l1 . "normal! V" . l2 . "G"
  else
    execute l2 . "normal! V" . l1 . "G"
  endif
endfunction

command! -nargs=+ VRel call VisualRelative(<f-args>)
