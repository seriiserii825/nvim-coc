function! DeleteLinesRelative(from, to)
  let l:cur = line('.')
  let l:start = l:cur + str2nr(a:from)
  let l:end = l:cur + str2nr(a:to)

  " Clamp to buffer boundaries
  let l:start = max([1, l:start])
  let l:end = min([line('$'), l:end])

  " Normalize range
  if l:start > l:end
    let [l:start, l:end] = [l:end, l:start]
  endif

  " Confirm before deleting
  let l:choice = confirm("Delete lines " . l:start . " to " . l:end . "?", "&Yes\n&No", 2)
  if l:choice != 1
    echo "Deletion canceled."
    return
  endif

  " Unfold affected lines to ensure deletion works
  silent! execute l:start . "," . l:end . "delete _"
  echo "Deleted lines " . l:start . " to " . l:end
endfunction

nnoremap <leader>ld :call DeleteLinesRelative(input('Start offset (e.g. -2): '), input('End offset (e.g. 3): '))<CR>
