" 2 execute pathogen#infect()
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

augroup auto_install_plugins
  autocmd!
  autocmd BufWritePost plugins.vim source ~/.config/nvim/plugins.vim | PlugClean | PlugInstall
augroup END

call plug#begin('~/.config/nvim/autoload/plugged')
"Appearance
Plug 'seriiserii825/nvim-git-open'
Plug 'mikavilpas/yazi.nvim'
" theme
" Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
" Plug 'AlexvZyl/nordic.nvim', { 'branch': 'main' }
Plug 'AlexvZyl/nordic.nvim'
" Plug 'navarasu/onedark.nvim'
" Plug 'loctvl842/monokai-pro.nvim'
" Plug 'phanviet/vim-monokai-pro'
Plug 'vim-airline/vim-airline'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'frazrepo/vim-rainbow'
Plug 'mboughaba/i3config.vim'
" Plug 'sheerun/vim-polyglot'
"debug
" Plug 'puremourning/vimspector'

"Align
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'sQVe/sort.nvim'

"Terminal
Plug 'voldikss/vim-floaterm'

" Editor
Plug 'github/copilot.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'CRAG666/code_runner.nvim'
Plug 'liuchengxu/vim-which-key'
" Plug 'mbbill/undotree'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'folke/flash.nvim'
" Plug 'AndrewRadev/splitjoin.vim'
" Plug 'justinmk/vim-sneak'

"Notify
Plug 'rcarriga/nvim-notify'
Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'

"Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yaegassy/coc-intelephense', {'do': 'yarn install --frozen-lockfile'}
Plug 'yaegassy/coc-laravel', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-diagnostic'

"Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Git
Plug 'kdheepak/lazygit.nvim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb' " Fugitive dependency GBrowse
" Plug 'junegunn/gv.vim'
" Plug 'sindrets/diffview.nvim'
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
" Plug 'ziontee113/color-picker.nvim'

"Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"Markdown
" Plug 'plasticboy/vim-markdown'
" Plug 'gabrielelana/vim-markdown'
Plug 'tadmccorkle/markdown.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

" Plug 'gorillamoe/AutoRemoteSync.nvim'

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

Plug 'posva/vim-vue'
" Plug 'leafOfTree/vim-vue-plugin'
" Plug 'mattn/emmet-vim'
" Plug 'digitaltoad/vim-pug'
" Plug 'rbong/vim-flog'
" Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
Plug 'yaegassy/coc-tailwindcss3', {'do': 'yarn install --frozen-lockfile'}
" Plug 'Pocco81/HighStr.nvim'
call plug#end()

