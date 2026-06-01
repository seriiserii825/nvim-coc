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

" ── Snippet browser (FZF) ────────────────────────────────────────────────────

function! s:SnipFtList()
  let ft = &filetype
  let hier = get(g:UltiSnipsFiletypeHierarchy, ft, [ft])
  if index(hier, ft) < 0 | call insert(hier, ft, 0) | endif
  return hier + ['all']
endfunction

function! s:BrowseSnippets()
  let dirs = [$HOME . '/.config/nvim/UltiSnips/']
  let fzf_lines = []

  for name in s:SnipFtList()
    for dir in dirs
      let fpath = dir . name . '.snippets'
      if !filereadable(fpath) | continue | endif

      let src   = fnamemodify(fpath, ':t:r')
      let fdata = readfile(fpath)
      let i     = 0

      while i < len(fdata)
        if fdata[i] =~# '^snippet\s'
          let m = matchlist(fdata[i], '^snippet\s\+\(\S\+\)\s*\%("\([^"]*\)"\)\?')
          if !empty(m)
            let trigger = m[1]
            let desc    = empty(m[2]) ? trigger : m[2]
            let display = printf('%-20s  %-35s [%s]', trigger, desc, src)
            " fields: display \t filepath \t lineno \t trigger
            call add(fzf_lines, display . "\t" . fpath . "\t" . (i + 1) . "\t" . trigger)
          endif
        endif
        let i += 1
      endwhile
    endfor
  endfor

  if empty(fzf_lines)
    echo 'No snippets for: ' . &filetype
    return
  endif

  let preview = executable('bat')
    \ ? 'f={2}; l={3}; bat --style=plain --color=always --line-range=$l:$((l+30)) "$f"'
    \ : 'f={2}; l={3}; tail -n +$l "$f" | head -n 30'

  call fzf#run(fzf#wrap('snips', {
    \ 'source':  fzf_lines,
    \ 'sink':    function('s:SnipSink'),
    \ 'options': [
    \   '--prompt', &filetype . ' snips> ',
    \   '--delimiter', "\t",
    \   '--with-nth', '1',
    \   '--preview', preview,
    \   '--preview-window', 'right:55%:wrap',
    \   '--ansi',
    \ ],
    \ }))
endfunction

function! s:SnipSink(line)
  let parts = split(a:line, "\t")
  if len(parts) >= 4
    call feedkeys('a' . parts[3], 'n')
  endif
endfunction

command! SnipsBrowse call s:BrowseSnippets()
nnoremap <leader>us :SnipsBrowse<CR>

