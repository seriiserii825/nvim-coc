function! CopyLinesRelative(from, to, ...)
  let l:cur = line('.')
  let l:start = l:cur + str2nr(a:from)
  let l:end = l:cur + str2nr(a:to)

  " Normalize the copy range
  if l:start > l:end
    let [l:start, l:end] = [l:end, l:start]
  endif

  " Determine destination
  if a:0 >= 1
    let l:raw_dest = a:1
    if l:raw_dest ==# '0'
      let l:dest = line('$')  " Paste at the end of the file
    elseif l:raw_dest =~ '^-'
      let l:dest = l:cur + str2nr(l:raw_dest)
    else
      let l:dest = str2nr(l:raw_dest)
    endif
  else
    let l:dest = l:cur
  endif

  " Clamp values
  let l:start = max([1, l:start])
  let l:end = min([line('$'), l:end])
  let l:dest = max([0, min([line('$'), l:dest])])

  " Avoid overlapping copy into self
  if l:dest >= l:start && l:dest <= l:end
    let l:dest = l:end
  endif

  execute l:start . "," . l:end . "t" . l:dest
endfunction

command! -nargs=+ CopyLines call CopyLinesRelative(<f-args>)


function! CopyLinesPrompt()
  let l:input = input("CopyLines (e.g. -3 4 or -2 1 -5): ")
  if empty(l:input)
    echo "Cancelled"
    return
  endif
  execute "CopyLines " . l:input
endfunction

nnoremap <leader>lt :<C-u>call CopyLinesPrompt()<CR>
