function! DeleteLinesFlexible(from, ...)
  let l:cur = line('.')
  let l:from = str2nr(a:from)

  if a:0 == 0
    " One argument: delete N lines up or down from current line
    if l:from > 0
      let l:start = l:cur
      let l:end = l:cur + l:from - 1
    else
      let l:start = l:cur + l:from
      let l:end = l:cur
    endif
  else
    " Two arguments: delete from relative start to relative end
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

  execute l:start . "," . l:end . "delete"
endfunction

command! -nargs=+ DeleteLines call DeleteLinesFlexible(<f-args>)


nnoremap <leader>ldr :<C-u>call DeleteLinesPrompt()<CR>

function! DeleteLinesPrompt()
  let l:input = input("DeleteLines (e.g. -4 or -3 5): ")
  if empty(l:input)
    echo "Cancelled"
    return
  endif
  execute "DeleteLines " . l:input
endfunction

function! DeleteLineOffset()
  let l:offset = input("Delete line at relative offset (e.g. -3 or 2): ")
  if l:offset =~ '^-\=\d\+$'
    let l:target = line('.') + str2nr(l:offset)
    if l:target >= 1 && l:target <= line('$')
      execute l:target . 'delete'
    else
      echo "Line out of range"
    endif
  else
    echo "Invalid input"
  endif
endfunction

nnoremap <leader>ldo :<C-u>call DeleteLineOffset()<CR>
