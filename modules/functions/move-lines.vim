function! MoveLinesAbsolute()
  set norelativenumber
  redraw

  let l:input = input('Lines (e.g. 4,8,44): ')
  if l:input == ''
    set relativenumber
    return
  endif

  let l:parts = split(l:input, ',')
  if len(l:parts) == 2
    let l:start = max([1, str2nr(l:parts[0])])
    let l:end = l:start
    let l:dest = max([0, min([line('$'), str2nr(l:parts[1])])])
  elseif len(l:parts) == 3
    let l:start = max([1, str2nr(l:parts[0])])
    let l:end = min([line('$'), str2nr(l:parts[1])])
    let l:dest = max([0, min([line('$'), str2nr(l:parts[2])])])
  else
    echo "Invalid format. Use: 4,44 (one line) or 4,8,44 (range)"
    set relativenumber
    return
  endif

  if l:start > l:end
    let [l:start, l:end] = [l:end, l:start]
  endif

  if l:dest >= l:start && l:dest <= l:end
    let l:dest = l:end + 1
  endif

  silent! execute l:start . "," . l:end . "m" . l:dest
  set relativenumber
endfunction

nnoremap <leader>lm :call MoveLinesAbsolute()<CR>
