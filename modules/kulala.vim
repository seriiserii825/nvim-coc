autocmd BufNewFile,BufRead *.http setfiletype http

lua << EOF
require('kulala').setup({
  -- По умолчанию request method (GET, POST, etc.)
  default_view = "body",
  
  -- Показывать иконки в UI
  icons = {
    inlay = {
      loading = "⏳",
      done = "✅",
      error = "❌",
    },
  },
  
  -- Дополнительные настройки curl
  additional_curl_options = {},
})
EOF

" Правильные keybindings для kulala
nnoremap <leader>rr :lua require('kulala').run()<CR>
nnoremap <leader>ri :lua require('kulala').inspect()<CR>
nnoremap <leader>rt :lua require('kulala').toggle_view()<CR>
nnoremap <leader>rp :lua require('kulala').jump_prev()<CR>
nnoremap <leader>rn :lua require('kulala').jump_next()<CR>
nnoremap <leader>rc :lua require('kulala').copy()<CR>
nnoremap <leader>rq :lua require('kulala').close()<CR>
nnoremap <leader>rb :lua require('kulala').scratchpad()<CR>

" Для выбора environment используйте telescope или встроенный UI
nnoremap <leader>rs :lua require('kulala').search()<CR>
