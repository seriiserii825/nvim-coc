" Surround with Markdown code fences ```lang
let g:surround_{char2nr('t')} = "```ts\n\r\n```"
let g:surround_{char2nr('p')} = "```python\n\r\n```"
let g:surround_{char2nr('h')} = "```php\n\r\n```"


" ---- Wrap N lines with ```ts ... ```
function! s:SurroundTs(count) abort
  let l:n = max([1, a:count])
  " Make a Visual LINE selection of N lines: current + (n-1) down
  execute 'normal! V' . (l:n - 1) . 'j'
  " Trigger the *plugin* Visual surround mapping (not built-in S)
  call feedkeys("\<Plug>VSurround" . 't', 'm')
endfunction

" Normal-mode mapping with count: 3<leader>ts -> wrap 3 lines
nnoremap <silent> <leader>ts :<C-u>call <SID>SurroundTs(v:count1)<CR>
