" Surround with Markdown code fences ```lang
let g:surround_{char2nr('t')} = "```ts\n\r\n```"
let g:surround_{char2nr('p')} = "```python\n\r\n```"
let g:surround_{char2nr('h')} = "```php\n\r\n```"

" Count = distance down (relative number), not total lines
function! s:SurroundTsDown(distance) abort
  let d   = max([0, a:distance])        " 0 = only current line
  let cur = line('.')
  let last= line('$')
  let lim = min([d, last - cur])        " don't go past EOF
  execute 'normal! V' . lim . 'j'
  call feedkeys("\<Plug>VSurround" . 't', 'm')
endfunction

" Wrapper so <leader>ts defaults to distance=0 (only current line)
function! s:MapTs() abort
  let dist = v:count == 0 ? 0 : v:count
  call <SID>SurroundTsDown(dist)
endfunction

" Normal-mode mapping: use relative counts (e.g. 1<leader>ts)
nnoremap <silent> <leader>ts :<C-u>call <SID>MapTs()<CR>

" Command version: :SpaceTs {distance}  (defaults to 0)
command! -count=0 SpaceTs call <SID>SurroundTsDown(<count>)

" If you're already in Visual mode, just apply 't' surround
xnoremap <silent> <leader>ts <Plug>VSurroundt

" " ---- Wrap N lines with ```ts ... ```
" function! s:SurroundTs(count) abort
"   let l:n = max([1, a:count])
"   " Make a Visual LINE selection of N lines: current + (n-1) down
"   execute 'normal! V' . (l:n - 1) . 'j'
"   " Trigger the *plugin* Visual surround mapping (not built-in S)
"   call feedkeys("\<Plug>VSurround" . 't', 'm')
" endfunction
"
" " Normal-mode mapping with count: 3<leader>ts -> wrap 3 lines
" nnoremap <silent> <leader>ts :<C-u>call <SID>SurroundTs(v:count1)<CR>
