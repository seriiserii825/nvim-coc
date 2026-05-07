function! SelectLinesAbsolute()
  set norelativenumber
  redraw

  let l:input = input('Lines (e.g. 4,8): ')
  if l:input == ''
    set relativenumber
    return
  endif

  let l:parts = split(l:input, ',')
  if len(l:parts) != 2
    echo "Invalid format. Use: 4,8"
    set relativenumber
    return
  endif

  let l:start = max([1, str2nr(l:parts[0])])
  let l:end = min([line('$'), str2nr(l:parts[1])])

  if l:start > l:end
    let [l:start, l:end] = [l:end, l:start]
  endif

  set relativenumber
  call cursor(l:start, 1)
  normal! V
  call cursor(l:end, 1)
endfunction

nnoremap <leader>lv :call SelectLinesAbsolute()<CR>
