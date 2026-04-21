function! SurroundLineWithTag()
  let tag = input('Tag: ')
  if empty(tag)
    return
  endif
  let lines = input('Lines: ')
  let lines = empty(lines) ? 1 : str2nr(lines)
  let select = lines > 1 ? 'V' . (lines - 1) . 'j' : 'V'
  call feedkeys(select . 'S<' . tag . '>', 't')
endfunction

nnoremap <leader>sl :call SurroundLineWithTag()<CR>
