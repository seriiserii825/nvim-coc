function! CalcVw()
  let l:min = input("Min size (px): ")
  let l:max = input("Max size (px): ")

  let l:min = str2float(l:min)
  let l:max = str2float(l:max)

  let l:vw = (l:max - l:min) / (1920.0 - 1280.0) * 100.0

  let l:result = printf("%.4fvw", l:vw)
  echo "\n" . l:result
  execute "normal! a" . l:result
endfunction

command! Vw call CalcVw()

nmap <leader>cvw :Vw<CR>

" **Usage:**
" ```
" :Vw
" Min size (px): 32
" Max size (px): 64
" → font-size: clamp(32px, 5.0000vw, 64px)
" ```
"
" ---
