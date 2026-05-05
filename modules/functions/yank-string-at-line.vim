function! YankStringAtLine()
  let l:input = input('Line: ')
  if l:input == '' | return | endif

  if l:input =~# '^[+-]\d\+$'
    let l:target = line('.') + str2nr(l:input)
  else
    let l:target = str2nr(l:input)
  endif

  let l:save_pos = getpos('.')
  execute l:target
  normal! zv"iyi"
  call setpos('.', l:save_pos)
endfunction

nmap <leader>vs :call YankStringAtLine()<CR>
