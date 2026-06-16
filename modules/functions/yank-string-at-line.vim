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

  let l:line = getline(l:target)
  let l:class = matchstr(l:line, 'class="\zs[^"]*\ze"')

  if l:class != ''
    let @i = l:class
  else
    echo '' | echohl ErrorMsg | echo 'No class attribute found' | echohl None
  endif

  set relativenumber
endfunction

nmap <leader>vs :<C-u>call YankStringAtLine(v:count)<CR>
