function! YankStringAtLine(count)
  set norelativenumber
  redraw

  if a:count > 0
    let l:target = a:count
  else
    let l:input = input('Line: ')
    if l:input == ''
      set relativenumber
      return
    endif

    if l:input =~# '^[+-]\d\+$'
      let l:target = line('.') + str2nr(l:input)
    else
      let l:target = str2nr(l:input)
    endif
  endif

  let l:save_pos = getpos('.')
  execute l:target
  normal! zv"iyi"
  call setpos('.', l:save_pos)
  set relativenumber
endfunction

nmap <leader>vs :<C-u>call YankStringAtLine(v:count)<CR>
