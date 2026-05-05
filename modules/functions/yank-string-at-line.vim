function! YankStringAtLine()
  let l:input = input('Line: ')
  if l:input == '' | return | endif

  if l:input =~# '^[+-]\d\+$'
    let l:target = line('.') + str2nr(l:input)
  else
    let l:target = str2nr(l:input)
  endif

  execute l:target
  normal! zv"iyi"
endfunction

nmap <leader>vs :call YankStringAtLine()<CR>
