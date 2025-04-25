"COC
"CocInstall @yaegassy/coc-pug

let g:coc_global_extensions=[
      \'coc-prettier',
      \'coc-svg',
      \'coc-phpls',
      \'coc-css',
      \'coc-xml',
      \'coc-html',
      \'coc-blade',
      \'coc-angular',
      \'coc-html-css-support',
      \'coc-eslint',
      \'coc-explorer',
      \'coc-fzf-preview',
      \'coc-highlight',
      \'coc-json',
      \'coc-pyright',
      \'coc-stylelint',
      \'coc-snippets',
      \'coc-tsserver',
      \'coc-sh',
      \'coc-markdown',
      \'coc-emmet',
      \'coc-highlight',
      \'@yaegassy/coc-laravel',
      \'@yaegassy/coc-volar'
      \]

nnoremap <silent> K :call CocAction('doHover')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-next)
nmap <silent> ]g <Plug>(coc-diagnostic-prev)
nnoremap <silent><nowait> <space>ci  :<C-u>CocList diagnostics<cr>
" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)
xmap <leader>a  <Plug>(coc-codeaction-selected)

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap keys for applying code actions at the cursor position
nmap <leader>cp  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <silent> <leader>cb  <Plug>(coc-codeaction-source)<CR>
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>;  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
" nmap <silent> <leader>cr <Plug>(coc-codeaction-refactor)
" xmap <silent> <leader>cr  <Plug>(coc-codeaction-refactor-selected)
" nmap <silent> <leader>rs  <Plug>(coc-codeaction-refactor-selected)
"
nmap <leader>cr :CocRestart<CR><CR>
nmap <M-l> <Plug>(coc-format)
vnoremap <leader>ct "zy:CocSearch <C-r>z/
" vnoremap <leader>rn "zy:s/<C-r>z/
nmap cn <Plug>(coc-rename)
inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"
inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"
inoremap <silent><expr> <down> coc#pum#visible() ? coc#pum#next(0) : "\<down>"
inoremap <silent><expr> <up> coc#pum#visible() ? coc#pum#prev(0) : "\<up>"

" command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <C-j>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<C-j>" :
      \ coc#refresh()
inoremap <expr><C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
