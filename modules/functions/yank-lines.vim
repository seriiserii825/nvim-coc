function! YankLinesFlexible(from, ...)
  let l:cur = line('.')
  let l:from = str2nr(a:from)

  if a:0 == 0
    " One argument: yank N lines up or down from current line
    if l:from > 0
      let l:start = l:cur
      let l:end = l:cur + l:from - 1
    else
      let l:start = l:cur + l:from
      let l:end = l:cur
    endif
  else
    " Two arguments: yank from relative start to relative end
    let l:to = str2nr(a:1)
    let l:start = l:cur + l:from
    let l:end = l:cur + l:to
    if l:start > l:end
      let [l:start, l:end] = [l:end, l:start]
    endif
  endif

  " Clamp within buffer limits
  let l:start = max([1, l:start])
  let l:end = min([line('$'), l:end])

  execute l:start . "," . l:end . "yank"
endfunction

command! -nargs=+ YankLines call YankLinesFlexible(<f-args>)


nnoremap <leader>lyr :<C-u>call YankLinesPrompt()<CR>

function! YankLinesPrompt()
  let l:input = input("YankLines (e.g. -4 or -3 5): ")
  if empty(l:input)
    echo "Cancelled"
    return
  endif
  execute "YankLines " . l:input
endfunction

function! YankLineOffset()
  let l:offset = input("Yank line at relative offset (e.g. -3 or 2): ")
  if l:offset =~ '^-\=\d\+$'
    let l:target = line('.') + str2nr(l:offset)
    if l:target >= 1 && l:target <= line('$')
      execute l:target . 'yank'
    else
      echo "Line out of range"
    endif
  else
    echo "Invalid input"
  endif
endfunction

nnoremap <leader>lyo :<C-u>call YankLineOffset()<CR>
