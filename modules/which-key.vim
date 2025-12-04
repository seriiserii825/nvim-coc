" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Инициализация пустого словаря
let g:which_key_map = {}

" Настройка маппингов для вызова which-key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Определение групп и команд
let g:which_key_map.x = {
      \ 'name': '+cleanup',
      \ 'r': 'remove empty lines',
      \ 'l': 'remove leading whitespace',
      \ }

" Регистрация словаря (обязательно в конце)
call which_key#register('<Space>', "g:which_key_map")
