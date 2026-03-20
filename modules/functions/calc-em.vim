function! CalcEm()
  let l:input = input("Font-size,Letter-spacing (px): ")
  let l:parts = split(l:input, ',')

  if len(l:parts) != 2
    echo "Invalid input. Use: size,spacing"
    return
  endif

  let l:size = str2float(l:parts[0])
  let l:spacing = str2float(l:parts[1])

  if l:size == 0
    echo "Font-size cannot be 0"
    return
  endif

  let l:em = l:spacing / l:size
  let l:result = printf("%.4fem", l:em)

  echo "\n" . l:result
  execute "normal! a" . l:result
endfunction

command! Em call CalcEm()
nmap <leader>em :Em<CR>
