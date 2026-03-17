function! CalcEm()
  let l:size = input("Font size (px): ")
  let l:spacing = input("Letter spacing (px): ")

  let l:size = str2float(l:size)
  let l:spacing = str2float(l:spacing)

  let l:em = l:spacing / l:size
  let l:result = printf("%.4fem", l:em)

  echo "\n" . l:result
  execute "normal! a" . l:result
endfunction

command! Em call CalcEm()

" **Usage** — in normal mode:
" ```
" :Em
" ```

nmap <leader>em :Em<CR>

