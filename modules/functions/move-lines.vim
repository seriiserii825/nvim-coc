function! MoveLinesRelative(from, to, ...)
  let l:cur = line('.') " Get current cursor line

  " Compute the start and end lines based on the relative values
  let l:start = l:cur + str2nr(a:from)
  let l:end = l:cur + str2nr(a:to)

  " Normalize start and end so that start is always less than end
  if l:start > l:end
    let [l:start, l:end] = [l:end, l:start]
  endif

  " Clamp start and end to valid line numbers
  let l:start = max([1, l:start])
  let l:end = min([line('$'), l:end])

  " Determine the destination
  if a:0 >= 1 && type(a:1) == type('') && !empty(a:1)
    let l:raw_dest = a:1
    if l:raw_dest ==# '.' || l:raw_dest ==# '0'
      let l:dest = l:cur
    elseif l:raw_dest =~ '^[+-]'
      let l:dest = l:cur + str2nr(l:raw_dest)
    else
      let l:dest = str2nr(l:raw_dest)
    endif
  else
    let l:dest = l:cur
  endif

  " Ensure destination is within valid bounds
  let l:dest = max([1, min([line('$'), l:dest])])

  " Prevent moving lines into their own range (handle overlap)
  if l:dest >= l:start && l:dest <= l:end
    let l:dest = l:end + 1
  endif

  " Perform the move
  execute l:start . "," . l:end . "m" . l:dest
endfunction

" Prompt function to handle user input correctly
function! MoveLinesPrompt()
  let l:input = input("MoveLines (e.g. -3,+4 5 or -2,-6 .): ")
  if empty(l:input)
    echo "Cancelled"
    return
  endif

  let l:parts = split(l:input, ' ')
  let l:range = split(l:parts[0], ',')

  if len(l:range) < 2
    echo "Invalid format. Use from,to (e.g. -3,+4)"
    return
  endif

  if len(l:parts) > 1
    call MoveLinesRelative(l:range[0], l:range[1], l:parts[1])
  else
    call MoveLinesRelative(l:range[0], l:range[1])
  endif
endfunction

" Mapping to call the MoveLinesPrompt function
nnoremap <leader>lm :<C-u>call MoveLinesPrompt()<CR>
