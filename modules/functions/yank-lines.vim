function! YankLinesFlexible(range_str)
  let l:cur = line('.')
  let l:parts = split(a:range_str, ',')
  if len(l:parts) != 2
    echo "Usage: from,to (e.g. -22,-8 or -10,+22)"
    return
  endif

  let l:start = l:cur + str2nr(l:parts[0])
  let l:end = l:cur + str2nr(l:parts[1])

  if l:start > l:end
    let [l:start, l:end] = [l:end, l:start]
  endif

  let l:start = max([1, l:start])
  let l:end = min([line('$'), l:end])

  let l:lines = []
  for l:lnum in range(l:start, l:end)
    call add(l:lines, getline(l:lnum))
  endfor

  call setreg('+', join(l:lines, "\n"))
  echo "Yanked lines " . l:start . " to " . l:end . " with relative numbers"
endfunction

command! -nargs=1 YankLines call YankLinesFlexible(<q-args>)

nmap <leader>yl :call YankLinesFlexible(input('Yank from,to: '))<CR>
