function! s:CopyFileLineWithDiagnostics() abort
  let l:path = expand("%:p")
  let l:lnum = line(".")
  let l:result = printf("path: %s\nLine: %d", l:path, l:lnum)

  try
    let l:diagnostics = CocAction('diagnosticList')
    let l:line_diags = filter(copy(l:diagnostics), {_, d -> get(d, 'lnum', 0) == l:lnum})
    if !empty(l:line_diags)
      let l:result .= "\nDiagnostics:"
      for l:d in l:line_diags
        let l:severity = get(l:d, 'severity', 'error')
        let l:message  = get(l:d, 'message', '')
        let l:result  .= printf("\n[%s] %s", l:severity, l:message)
      endfor
    endif
  catch
  endtry

  let @+ = l:result
endfunction

nnoremap <silent> <leader>cfl :call <SID>CopyFileLineWithDiagnostics()<CR>
