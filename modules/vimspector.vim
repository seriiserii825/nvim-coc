let g:vimspector_enable_mappings = 'HUMAN'
nmap <silent> <leader>dd :call vimspector#Launch()<CR>
nmap <silent> <leader>dx :VimspectorReset<CR>
nmap <silent> <leader>db <Plug>VimspectorToggleBreakpoint<CR>
nmap <silent> <leader>dc <Plug>VimspectorContinue<CR>
nmap <silent> <leader>di <Plug>VimspectorStepInto<CR>
nmap <silent> <leader>do <Plug>VimspectorStepOver<CR>
nmap <silent> <leader>dt <Plug>VimspectorStepOut<CR>
nmap <silent> <leader>dr <Plug>VimspectorRestart<CR>
nmap <silent> <leader>dp <Plug>VimspectorPause<CR>

