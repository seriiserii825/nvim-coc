" Удаляет технический мусор: символ │ (U+2502) и хвостовые пробелы в конце строк
function! DeleteInvisibleChars()
  let l:save_cursor = getpos('.')
  silent! %s/\s*\%u2502\s*$//e
  silent! %s/\s\+$//e
  call setpos('.', l:save_cursor)
endfunction

command! DeleteInvisibleChars call DeleteInvisibleChars()

" <leader>ds → удалить символ │ и висящие пробелы по всему файлу
nnoremap <leader>ds :call DeleteInvisibleChars()<CR>
