" Put in your vimrc/init.vim
let g:last_float_delta = ''

function! s:AdjustFloatByInput() abort
  let l:line = getline('.')
  let l:col  = col('.') - 1   " 0-based

  " Find the number span under cursor on this line
  let l:pat = '\v-?\d+(\.\d+)?'
  let l:m = matchstrpos(l:line, l:pat, 0)
  let l:hit = []
  while l:m[1] != -1
    let l:start = l:m[1]
    let l:end   = l:start + strlen(l:m[0]) - 1
    if l:col >= l:start && l:col <= l:end
      let l:hit = [l:m[0], l:start, l:end]
      break
    endif
    let l:m = matchstrpos(l:line, l:pat, l:start + 1)
  endwhile

  if empty(l:hit)
    echohl ErrorMsg | echo 'No number under cursor' | echohl None
    return
  endif

  let l:orig_num = l:hit[0]
  let l:delta_in = input('Δ add/subtract (e.g. 14.8 or -0.25): ', get(g:, 'last_float_delta', ''))
  if l:delta_in ==# '' && has_key(g:, 'last_float_delta') && g:last_float_delta !=# ''
    let l:delta_in = g:last_float_delta
  endif
  if l:delta_in ==# '' || l:delta_in !~# '^\s*[-+]\=\d\+\%(\.\d\+\)\=\s*$'
    echohl ErrorMsg | echo 'Invalid number' | echohl None
    return
  endif
  let g:last_float_delta = l:delta_in

  let l:res = str2float(l:orig_num) + str2float(l:delta_in)

  " Keep the original decimal precision
  let l:dec = matchstr(l:orig_num, '\.\zs\d\+')
  let l:prec = len(l:dec)
  let l:out = (l:prec > 0) ? printf('%.*f', l:prec, l:res) : printf('%d', float2nr(l:res))

  " Splice back just the numeric span (preserve unit like 'rem')
  let l:newline = l:line[:l:hit[1]-1] . l:out . l:line[l:hit[2]+1:]
  call setline('.', l:newline)
endfunction

" Map: <leader>a to prompt and adjust number under cursor
nnoremap <silent> <leader>a :call <SID>AdjustFloatByInput()<CR>
