" 2 execute pathogen#infect()
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif



" Automatically run :Plug Clean and :Plug Install when saving plugins.vim
augroup AutoPlug
    autocmd!
    autocmd BufWritePost plugins.vim silent! source %
    autocmd BufWritePost plugins.vim silent! PlugClean 
    autocmd BufWritePost plugins.vim silent! PlugInstall 
augroup END

call plug#begin('~/.config/nvim/autoload/plugged')
"Appearance
Plug 'phanviet/vim-monokai-pro'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'frazrepo/vim-rainbow'
Plug 'mboughaba/i3config.vim'

"Align
Plug 'godlygeek/tabular'
" Plug 'junegunn/vim-easy-align'

"Terminal
Plug 'voldikss/vim-floaterm'

" Editor
Plug 'github/copilot.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'CRAG666/code_runner.nvim'
Plug 'liuchengxu/vim-which-key'
Plug 'mbbill/undotree'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'folke/flash.nvim'
Plug 'AndrewRadev/splitjoin.vim'
" Plug 'justinmk/vim-sneak'

"Notify
" Plug 'rcarriga/nvim-notify'
" Plug 'folke/noice.nvim'
" Plug 'MunifTanjim/nui.nvim'

"Coc
" Plug 'neoclide/coc.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
Plug 'yaegassy/coc-intelephense', {'do': 'yarn install --frozen-lockfile'}

"Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Almo7aya/openingh.nvim'
" Plug 'f-person/git-blame.nvim'
" Plug 'lewis6991/gitsigns.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'NeogitOrg/neogit'

"Buffers
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
" Plug 'akinsho/bufferline.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

"Colors
Plug 'NvChad/nvim-colorizer.lua'
Plug 'ziontee113/color-picker.nvim'

"Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

Plug 'gorillamoe/AutoRemoteSync.nvim'

" Javscript
" Plug 'mxw/vim-jsx'
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript' 

" Themes
" Plug 'tanvirtin/monokai.nvim'
" Plug 'mhartington/oceanic-next'

" Plug 'jwalton512/vim-blade'

"Vim
" Plug 'airblade/vim-tailwind'

" Plug 'iamcco/mathjax-support-for-mkdp'
" Plug 'iamcco/markdown-preview.vim'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Plug 'ixru/nvim-markdown'

" Plug 'posva/vim-vue'
" Plug 'leafOfTree/vim-vue-plugin'
" Plug 'mattn/emmet-vim'
" Plug 'digitaltoad/vim-pug'
" Plug 'rbong/vim-flog'
" Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
" Plug 'yaegassy/coc-tailwindcss3', {'do': 'yarn install --frozen-lockfile'}
" Plug 'Pocco81/HighStr.nvim'
call plug#end()

