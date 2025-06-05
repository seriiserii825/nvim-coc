function! SelectLinesAbsolute(from, to)
  let l:start = str2nr(a:from)
  let l:end = str2nr(a:to)

  " Clamp values to file bounds
  let l:start = max([1, l:start])
  let l:end = min([line('$'), l:end])

  " Normalize order
  if l:start > l:end
    let [l:start, l:end] = [l:end, l:start]
  endif

  " Save view (cursor, folds)
  let l:view = winsaveview()

  " Open folds so selection isn't blocked
  silent! normal! zE

  " Select the lines
  call cursor(l:start, 1)
  normal! V
  call cursor(l:end, 1)

  " Restore view
  call winrestview(l:view)
endfunction

nnoremap <leader>lv :call SelectLinesAbsolute(input('Start line (abs): '), input('End line (abs): '))<CR>
