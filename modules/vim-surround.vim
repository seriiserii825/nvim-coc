" Markdown code fences for multiple languages
let g:surround_{char2nr('t')} = "```ts\n\r\n```"
let g:surround_{char2nr('p')} = "```python\n\r\n```"
let g:surround_{char2nr('h')} = "```php\n\r\n```"
let g:surround_{char2nr('b')} = "```bash\n\r\n```"
let g:surround_{char2nr('y')} = "```yaml\n\r\n```"
let g:surround_{char2nr('j')} = "```json\n\r\n```"
let g:surround_{char2nr('g')} = "```graphql\n\r\n```"
let g:surround_{char2nr('v')} = "```vim\n\r\n```"
let g:surround_{char2nr('s')} = "```sql\n\r\n```"

" --- Generic surround with ```lang fences ---
function! s:SurroundWith(lang, count) abort
  let c = max([1, a:count])
  let steps = c - 1
  let steps = min([steps, line('$') - line('.')])

  " Start visual line selection
  normal! V
  if steps > 0
    execute 'normal! ' . steps . 'j'
  endif

  " Use correct surround character
  call feedkeys("\<Plug>VSurround" . a:lang, 'm')
endfunction

" --- Mappings: <leader>m{key}
nnoremap <silent> ts :<C-u>call <SID>SurroundWith('t', v:count1)<CR>
nnoremap <silent> py :<C-u>call <SID>SurroundWith('p', v:count1)<CR>
nnoremap <silent> ph :<C-u>call <SID>SurroundWith('h', v:count1)<CR>
nnoremap <silent> mb :<C-u>call <SID>SurroundWith('b', v:count1)<CR>
nnoremap <silent> my :<C-u>call <SID>SurroundWith('y', v:count1)<CR>
nnoremap <silent> mj :<C-u>call <SID>SurroundWith('j', v:count1)<CR>
nnoremap <silent> mg :<C-u>call <SID>SurroundWith('g', v:count1)<CR>
nnoremap <silent> ms :<C-u>call <SID>SurroundWith('s', v:count1)<CR>
nnoremap <silent> mv :<C-u>call <SID>SurroundWith('v', v:count1)<CR>

" Dash 5
command! -nargs=1 Dash exec line('.') . ',' . (line('.') + <args>) . 'normal! I- '
