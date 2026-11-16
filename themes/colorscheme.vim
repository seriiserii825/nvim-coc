" set termguicolors
" https://github.com/topics/neovim-theme

set termguicolors

" colorscheme one
" set background=dark
" set background=dark
" colorscheme palenight
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu
" colorscheme minimalist 
" colorscheme onedarker
" colorscheme monokai
" colorscheme monokai-pro-machine
" colorscheme monokai_soda
" colorscheme monokai_ristretto
" let g:onedark_config = {
"     \ 'style': 'darker',
" \}
" colorscheme onedark
" colorscheme monokai-pro
" colorscheme monokai_pro
" colorscheme catppuccin
lua << EOF
require('nordic').setup({
  cursorline = {
    theme = 'light',   -- светлее, чем 'dark'
    blend = 0.5,       -- меньше значение = заметнее линия (по умолчанию 0.85)
    bold = false,
    bold_number = true,
  },
})
EOF
colorscheme nordic
