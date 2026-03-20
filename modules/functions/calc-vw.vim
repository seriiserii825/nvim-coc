function! CalcSimpleClampVw()
  let l:range = input("Min font, Max font (px): ")
  let l:parts = split(l:range, ',')

  if len(l:parts) != 2
    echo "Invalid input. Use: min,max"
    return
  endif

  let l:min = str2float(l:parts[0])
  let l:max = str2float(l:parts[1])

  " fixed viewport range 576–1600
  let l:vw = (l:max - l:min) / (1600.0 - 576.0) * 100.0
  let l:offset = l:min - l:vw * 576.0 / 100.0

  let l:result = printf(
        \ "clamp(%.2fpx, calc(%.4fvw + %.2fpx), %.2fpx)",
        \ l:min,
        \ l:vw,
        \ l:offset,
        \ l:max
        \ )

  echo "\n" . l:result
  execute "normal! a" . l:result
endfunction

command! ClampVwSimple call CalcSimpleClampVw()
nmap <leader>cvw :ClampVwSimple<CR>
