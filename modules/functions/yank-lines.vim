function! YankLinesAbsolute()
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

  let l:lines = []
  for l:lnum in range(l:start, l:end)
    call add(l:lines, getline(l:lnum))
  endfor

  call setreg('+', join(l:lines, "\n"))
  set relativenumber
endfunction

nnoremap <leader>ly :call YankLinesAbsolute()<CR>
