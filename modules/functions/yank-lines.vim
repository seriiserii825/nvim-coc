function! YankLinesFlexible(from, ...)
  let l:cur = line('.')

  " If two arguments, assume absolute line mode and show confirmation
  if a:0 > 0
    let l:choice = confirm("Yank absolute lines from ".a:from." to ".a:1."?\nPress 'Yes' to continue.", "&Yes\n&No", 1)
    if l:choice != 1
      echo "Yank canceled."
      return
    endif
  endif

  if a:0 == 0
    " One argument, relative yank from current line
    let l:from = str2nr(a:from)
    if l:from > 0
      let l:start = l:cur
      let l:end = l:cur + l:from - 1
    else
      let l:start = l:cur + l:from
      let l:end = l:cur
    endif
  else
    " Two arguments, absolute line numbers
    let l:start = str2nr(a:from)
    let l:end = str2nr(a:1)
    if l:start > l:end
      let [l:start, l:end] = [l:end, l:start]
    endif
  endif

  " Clamp within buffer
  let l:start = max([1, l:start])
  let l:end = min([line('$'), l:end])

  execute l:start . "," . l:end . "yank"
  echo "Yanked lines " . l:start . " to " . l:end
endfunction

command! -nargs=+ YankLines call YankLinesFlexible(<f-args>)
