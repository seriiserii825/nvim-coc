" ~/.config/nvim/init.vim

" ============ Database Settings ============

" Настройки vim-dadbod-ui
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_show_database_icon = 1
let g:db_ui_force_echo_notifications = 1
let g:db_ui_win_position = 'left'
let g:db_ui_winwidth = 40
let g:db_ui_save_location = '~/.local/share/nvim/db_ui'

" Подключения к базам данных
let g:dbs = [
  \ { 'name': 'teashop_local', 'url': 'postgresql://postgres:serii1981@localhost:5433/teashop' },
  \ ]

" Горячие клавиши
nnoremap <leader>db :DBUIToggle<CR>
nnoremap <leader>df :DBUIFindBuffer<CR>
nnoremap <leader>dr :DBUIRenameBuffer<CR>
nnoremap <leader>dq :DBUILastQueryInfo<CR>
