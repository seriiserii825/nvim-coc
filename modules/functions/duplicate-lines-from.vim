function! DuplicateLinesFrom(from)
  let cur = line('.')
  let start = cur + str2nr(a:from)
  let end = cur

  " Normalize in case from is positive
  if start > end
    let [start, end] = [end, start]
  endif

  let start = max([1, start])
  let end = min([line('$'), end])

  execute start . "," . end . "t" . cur
endfunction

command! -nargs=1 CopyFrom call DuplicateLinesFrom(<f-args>)

nnoremap <leader>lf :<C-u>call DuplicateLinesFrom(input('Copy from relative line: '))<CR>
