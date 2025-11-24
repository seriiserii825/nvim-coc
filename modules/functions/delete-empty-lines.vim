" Удаляет ПУСТЫЕ строки от текущей до current + {relative}
function! DeleteEmptyFromRelative(relative)
  let cur = line('.')
  let rel = str2nr(a:relative)

  " Диапазон по относительному номеру
  let start = cur
  let end = cur + rel

  " Нормализуем (чтобы можно было вводить и отрицательные числа)
  if end < start
    let [start, end] = [end, start]
  endif

  let start = max([1, start])
  let end = min([line('$'), end])

  " Удаляем только пустые строки в диапазоне
  execute start . ',' . end . 'g/^$/d'
endfunction

command! -nargs=1 DelEmptyFromRelative call DeleteEmptyFromRelative(<f-args>)

" <space>dl → спросит relative number (например 5 или -3)
nnoremap <leader>dl :<C-u>call DeleteEmptyFromRelative(input('Delete empty from relative line: '))<CR>
