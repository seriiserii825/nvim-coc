function! CalcSimpleClampVw()
  let l:range = input("Min,Max (px): ")
  let l:parts = split(l:range, ',')

  if len(l:parts) != 2
    echo "Invalid input. Use: min,max"
    return
  endif

  let l:min = str2float(l:parts[0])
  let l:max = str2float(l:parts[1])

  " default viewport range 1280–1920
  let l:vw = (l:max - l:min) / (1920.0 - 1280.0) * 100.0

  let l:result = printf(
        \ "clamp(%.2fpx, %.4fvw, %.2fpx)",
        \ l:min,
        \ l:vw,
        \ l:max
        \ )

  echo "\n" . l:result
  execute "normal! a" . l:result
endfunction

command! ClampVwSimple call CalcSimpleClampVw()
nmap <leader>cvw :ClampVwSimple<CR>
