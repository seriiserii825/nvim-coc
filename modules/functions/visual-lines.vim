function! SelectLinesRelative(from, to)
  let l:cur = line('.')
  let l:start = l:cur + str2nr(a:from)
  let l:end = l:cur + str2nr(a:to)

  " Clamp values to file bounds
  let l:start = max([1, l:start])
  let l:end = min([line('$'), l:end])

  " Normalize so we always go from top to bottom
  if l:start > l:end
    let [l:start, l:end] = [l:end, l:start]
  endif

  " Jump to start, enter visual mode, then go to end
  call cursor(l:start, 1)
  normal! V
  call cursor(l:end, 1)
endfunction


nnoremap <leader>lv :call SelectLinesRelative(input('Start (rel): '), input('End (rel): '))<CR>
