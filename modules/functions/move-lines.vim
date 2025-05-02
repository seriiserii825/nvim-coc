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
  if a:0 >= 1
    let l:raw_dest = a:1
    if l:raw_dest ==# '0'
      let l:dest = l:cur " Paste at the cursor position
    elseif l:raw_dest =~ '^-'
      let l:dest = l:cur + str2nr(l:raw_dest) " Move relative from current position
    else
      let l:dest = str2nr(l:raw_dest) " Absolute destination line
    endif
  else
    let l:dest = l:cur " Default: paste at the current line
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
  let l:input = input("MoveLines (e.g. -3 4 or -2 1 -5): ")
  if empty(l:input)
    echo "Cancelled"
    return
  endif

  " Split the input into separate arguments
  let l:args = split(l:input, ' ')

  " Call the MoveLines function with the arguments
  call MoveLinesRelative(l:args[0], l:args[1], l:args[2:])
endfunction

" Mapping to call the MoveLinesPrompt function
nnoremap <leader>lm :<C-u>call MoveLinesPrompt()<CR>
