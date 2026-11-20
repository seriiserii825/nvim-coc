" Log files are not code: keep LSP/CoC away (otherwise e.g. gopls in a Go
" project root may publish parse errors like "expected ';', found 'EOF'").
let b:coc_enabled = 0
let b:coc_diagnostic_disable = 1
setlocal nospell nowrap nolist
setlocal foldmethod=manual
