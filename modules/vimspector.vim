let g:vimspector_enable_mappings = 'HUMAN'
nmap <silent> <leader>dd :call vimspector#Launch()<CR>
nmap <silent> <leader>dx :VimspectorReset<CR>
nmap <silent> <leader>db <Plug>VimspectorToggleBreakpoint<CR>
nmap <silent> <leader>di <Plug>VimspectorStepInto<CR>
nmap <silent> <leader>do <Plug>VimspectorStepOver<CR>
nmap <silent> <leader>dt <Plug>VimspectorStepOut<CR>
nmap <silent> <leader>dr <Plug>VimspectorRestart<CR>
nmap <silent> <leader>dp <Plug>VimspectorPause<CR>

" for python
" autocmd FileType python nmap <silent> <leader>dd :call vimspector#Launch()<CR>
"| Key | Mapping | Function |
" | --- | --- | --- |
" | `F5` | `<Plug>VimspectorContinue` | When debugging, continue. Otherwise start debugging. |
" | `F3` | `<Plug>VimspectorStop` | Stop debugging. |
" | `F4` | `<Plug>VimspectorRestart` | Restart debugging with the same configuration. |
" | `F6` | `<Plug>VimspectorPause` | Pause debuggee. |
" | `F9` | `<Plug>VimspectorToggleBreakpoint` | Toggle line breakpoint on the current line. |
" | `<leader>F9` | `<Plug>VimspectorToggleConditionalBreakpoint` | Toggle conditional line breakpoint or logpoint on the current line. |
" | `F8` | `<Plug>VimspectorAddFunctionBreakpoint` | Add a function breakpoint for the expression under cursor |
" | `<leader>F8` | `<Plug>VimspectorRunToCursor` | Run to Cursor |
" | `F10` | `<Plug>VimspectorStepOver` | Step Over |
" | `F11` | `<Plug>VimspectorStepInto` | Step Into |
" | `F12` | `<Plug>VimspectorStepOut` | Step out of current function scope |
