" ~/.config/nvim/init.vim

" ============ Database Settings ============

" Настройки vim-dadbod-ui
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_show_database_icon = 1
let g:db_ui_force_echo_notifications = 1
let g:db_ui_win_position = 'left'
let g:db_ui_winwidth = 40
let g:db_ui_save_location = getcwd() . '/saved-queries'

" Подключения к базам данных
let g:dbs = [
  \ { 'name': 'tea-stream-local', 'url': 'postgresql://root:123456@localhost:5433/teastream' },
  \ { 'name': 'tea-shop', 'url': 'postgresql://postgres:postgres@localhost:5434/teashop' },
  \ ]

" Тоггл DBUI, закрывающий заодно и окно с результатом запроса (dbout),
" иначе DBUIToggle закрывает только сайдбар, а нижняя панель остаётся висеть
function! s:ToggleDBUI() abort
  let l:dbui_open = 0
  for l:win in range(1, winnr('$'))
    if getbufvar(winbufnr(l:win), '&filetype') ==# 'dbui'
      let l:dbui_open = 1
    endif
  endfor

  if l:dbui_open
    for l:win in reverse(range(1, winnr('$')))
      if getbufvar(winbufnr(l:win), '&filetype') ==# 'dbout'
        execute l:win . 'wincmd c'
      endif
    endfor
  endif

  DBUIToggle
endfunction

" Горячие клавиши
nnoremap <leader>db :call <SID>ToggleDBUI()<CR>
nnoremap <leader>df :DBUIFindBuffer<CR>
nnoremap <leader>dr :DBUIRenameBuffer<CR>
nnoremap <leader>dq :DBUILastQueryInfo<CR>
" Сохранить текущий query-буфер в "Saved queries" (переживает перезапуск nvim)
nmap <leader>dw <Plug>(DBUI_SaveQuery)

" \ { 'name': 'teashop_local', 'url': 'postgresql://postgres:serii1981@localhost:5433/teashop' },
