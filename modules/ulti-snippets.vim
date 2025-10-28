let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-b>'
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-tab>'


" Blade template filetype detection for Ultisnips and other plugins
"
autocmd BufNewFile,BufRead *.blade.php setlocal filetype=php.blade

let g:UltiSnipsSnippetDirectories = ['UltiSnips']
let g:UltiSnipsFiletypeHierarchy = {
\ 'php.blade': ['php', 'html', 'blade'],
\}

