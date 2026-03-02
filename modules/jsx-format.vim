autocmd BufWritePre *.tsx call FixJSX()

function! FixJSX()
  silent! g/^\s*<!--/d
  silent! %s/class=/className=/ge
endfunction

" nnoremap <leader>fx :silent! g/^\s*<!--/d<CR>:silent! %s/class=/className=/ge<CR>
