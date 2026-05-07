function! CopyLinesAbsolute()
  set norelativenumber
  redraw

  let l:input = input('Lines (e.g. 4,8,44): ')
  if l:input == ''
    set relativenumber
    return
  endif

  let l:parts = split(l:input, ',')
  if len(l:parts) != 3
    echo "Invalid format. Use: 4,8,44"
    set relativenumber
    return
  endif

  let l:start = max([1, str2nr(l:parts[0])])
  let l:end = min([line('$'), str2nr(l:parts[1])])
  let l:dest = max([0, min([line('$'), str2nr(l:parts[2])])])

  if l:start > l:end
    let [l:start, l:end] = [l:end, l:start]
  endif

  execute l:start . "," . l:end . "t" . l:dest
  echo "Copied lines " . l:start . "-" . l:end . " to " . l:dest
  set relativenumber
endfunction

nnoremap <leader>lc :call CopyLinesAbsolute()<CR>
