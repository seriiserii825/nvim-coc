function! DeleteLinesAbsolute()
  set norelativenumber
  redraw

  let l:input = input('Lines (e.g. 23,88): ')
  if l:input == ''
    set relativenumber
    return
  endif

  let l:parts = split(l:input, ',')
  if len(l:parts) == 1
    let l:start = max([1, str2nr(l:parts[0])])
    let l:end = l:start
  elseif len(l:parts) == 2
    let l:start = max([1, str2nr(l:parts[0])])
    let l:end = min([line('$'), str2nr(l:parts[1])])
  else
    echo "Invalid format. Use: 23 (one line) or 23,88 (range)"
    set relativenumber
    return
  endif

  if l:start > l:end
    let [l:start, l:end] = [l:end, l:start]
  endif

  silent! execute l:start . "," . l:end . "delete _"
  echo "Deleted lines " . l:start . " to " . l:end
  set relativenumber
endfunction

nnoremap <leader>ld :call DeleteLinesAbsolute()<CR>
