"Plugins
source $HOME/.config/nvim/plugins.vim

set termguicolors
" let g:polyglot_disabled = ['vue']
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

"settings
source $HOME/.config/nvim/settings.vim
source $HOME/.config/nvim/functions.vim

"Map
source $HOME/.config/nvim/keys/map-nvim.vim
" source $HOME/.config/nvim/keys/vim-hard.vim

"Macros
source $HOME/.config/nvim/modules/macros.vim
source $HOME/.config/nvim/modules/macross/python-macros.vim
" source $HOME/.config/nvim/modules/macross/bash-macros.vim

"Coc
source $HOME/.config/nvim/modules/coc.vim
source $HOME/.config/nvim/modules/coc-explorer.vim
source $HOME/.config/nvim/modules/coc-css.vim

" syntax
source $HOME/.config/nvim/modules/polyglot.vim

"Sftp
" source $HOME/.config/nvim/modules/auto-remote-sync.vim

" source $HOME/.config/nvim/modules/gitgutter.vim

"Editor
source $HOME/.config/nvim/modules/which-key.vim
source $HOME/.config/nvim/modules/fzf.vim
source $HOME/.config/nvim/modules/multiple-cursors.vim
source $HOME/.config/nvim/modules/rainbow.vim
source $HOME/.config/nvim/modules/indent-guides.vim
source $HOME/.config/nvim/modules/easy-align.vim
source $HOME/.config/nvim/modules/sort.vim
source $HOME/.config/nvim/modules/copylot.vim
source $HOME/.config/nvim/modules/chatcopilot.vim
" source $HOME/.config/nvim/modules/undotree.vim
source $HOME/.config/nvim/modules/flash.vim
" source $HOME/.config/nvim/modules/tabular.vim
source $HOME/.config/nvim/modules/colorize.vim
" source $HOME/.config/nvim/modules/code-runner.vim
" source $HOME/.config/nvim/modules/color-picker.vim


"Terminal
source $HOME/.config/nvim/modules/floaterm.vim
source $HOME/.config/nvim/modules/markdown-preview.vim

"Snippets
source $HOME/.config/nvim/modules/ulti-snippets.vim
" source $HOME/.config/nvim/modules/vimspector.vim

"Notify
" source $HOME/.config/nvim/modules/nvim-notify.vim
" source $HOME/.config/nvim/modules/nvim-noice.vim

"Theme
source $HOME/.config/nvim/themes/colorscheme.vim
source $HOME/.config/nvim/themes/airline.vim
" source $HOME/.config/nvim/themes/monokaipro.vim
source $HOME/.config/nvim/modules/bufferline.vim
" source $HOME/.config/nvim/modules/openingh.vim
"source $HOME/.config/nvim/modules/treesitter.vim


" source $HOME/.config/nvim/modules/colortils.vim

hi Visual  guifg=#000000 guibg=#7FFFD4 gui=none
" source $HOME/.config/nvim/modules/ftp.vim
" source $HOME/.config/nvim/modules/sneak.vim
" source $HOME/.config/nvim/modules/neogit.vim
"
let g:python3_host_prog = "/usr/bin/python"

