"Plugins
source $HOME/.config/nvim/plugins.vim

set termguicolors
" let g:polyglot_disabled = ['vue']
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

"settings
source $HOME/.config/nvim/settings.vim
source $HOME/.config/nvim/functions.vim

" functions
source $HOME/.config/nvim/modules/functions/delete-lines.vim
source $HOME/.config/nvim/modules/functions/duplicate-lines-from.vim " unfold
source $HOME/.config/nvim/modules/functions/copy-lines.vim " unfold
source $HOME/.config/nvim/modules/functions/visual-lines.vim " unfold

"Map
source $HOME/.config/nvim/keys/map-nvim.vim
" source $HOME/.config/nvim/keys/vim-hard.vim

"Macros
source $HOME/.config/nvim/modules/macros.vim
"  source $HOME/.config/nvim/modules/macross-dir/python-macros.vim
source $HOME/.config/nvim/modules/macross-dir/bash-macros.vim
" source $HOME/.config/nvim/modules/macross-dir/blade.macros.vim

"Coc
source $HOME/.config/nvim/modules/coc.vim
source $HOME/.config/nvim/modules/coc-explorer.vim
source $HOME/.config/nvim/modules/coc-css.vim

" syntax
source $HOME/.config/nvim/modules/polyglot.vim
source $HOME/.config/nvim/modules/yazi.vim

"Sftp
" source $HOME/.config/nvim/modules/auto-remote-sync.vim

" source $HOME/.config/nvim/modules/gitgutter.vim
" file manager
source $HOME/.config/nvim/modules/which-key.vim
source $HOME/.config/nvim/modules/lazygit.vim

"Editor
source $HOME/.config/nvim/modules/which-key.vim
source $HOME/.config/nvim/modules/fzf.vim
source $HOME/.config/nvim/modules/multiple-cursors.vim
source $HOME/.config/nvim/modules/rainbow.vim
source $HOME/.config/nvim/modules/indent-guides.vim
source $HOME/.config/nvim/modules/easy-align.vim
source $HOME/.config/nvim/modules/sort.vim
source $HOME/.config/nvim/modules/copilot.vim
" source $HOME/.config/nvim/modules/chatcopilot.vim
" source $HOME/.config/nvim/modules/undotree.vim
source $HOME/.config/nvim/modules/flash.vim
" source $HOME/.config/nvim/modules/tabular.vim
source $HOME/.config/nvim/modules/colorize.vim
" source $HOME/.config/nvim/modules/code-runner.vim
" source $HOME/.config/nvim/modules/color-picker.vim


"Terminal
source $HOME/.config/nvim/modules/floaterm.vim
source $HOME/.config/nvim/modules/markdown.vim
source $HOME/.config/nvim/modules/markdown-preview.vim

"Snippets
source $HOME/.config/nvim/modules/ulti-snippets.vim
" source $HOME/.config/nvim/modules/vimspector.vim

"Notify
source $HOME/.config/nvim/modules/nvim-notify.vim
source $HOME/.config/nvim/modules/nvim-noice.vim

"Theme
source $HOME/.config/nvim/themes/colorscheme.vim
source $HOME/.config/nvim/themes/airline.vim
" source $HOME/.config/nvim/themes/monokaipro.vim
source $HOME/.config/nvim/modules/bufferline.vim
"source $HOME/.config/nvim/modules/treesitter.vim


" source $HOME/.config/nvim/modules/colortils.vim

hi Visual  guifg=#000000 guibg=#7FFFD4 gui=none
" source $HOME/.config/nvim/modules/ftp.vim
" source $HOME/.config/nvim/modules/sneak.vim
" source $HOME/.config/nvim/modules/neogit.vim
"
let g:python3_host_prog = "/usr/bin/python"


" nnoremap <leader>kr :w<CR>:!kotlinc % -include-runtime -d main.jar && java -jar main.jar<CR>

" nnoremap <leader>kr :w<CR>:terminal kotlinc % -include-runtime -d main.jar && java -jar main.jar<CR>
