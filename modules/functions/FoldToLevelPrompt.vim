function! FoldToLevelPrompt()
  let level = input('Fold to level: ')
  if level =~ '^\d\+$'
    let l:save = &foldenable
    set foldenable
    execute 'set foldlevel=' . level
    normal! zM
    let &foldenable = l:save
  else
    echo "Invalid level: must be a number"
  endif
endfunction

nnoremap <leader>fl :call FoldToLevelPrompt()<CR>


function! FoldSetLevelInBlock()
  let l:level = input('Fold to level (0 = all closed): ')
  if l:level !~ '^\d\+$'
    echo "Invalid level: must be a number"
    return
  endif

  " Try to detect Vue-style tag block: <template>, <script>, <style>
  let l:start = search('<\(template\|script\|style\)\>', 'bnW')
  let l:end = search('</\(template\|script\|style\)>', 'nW')

  " If not found, try to fall back to current fold block
  if l:start <= 0 || l:end <= 0 || l:end <= l:start
    let l:start = foldclosed('.')
    let l:end = foldclosedend('.')
    if l:start == -1 || l:end == -1
      echo "Couldn't find a block or fold"
      return
    endif
  endif

  " Temporarily set global foldlevel
  let l:oldlevel = &foldlevel
  set foldenable
  execute l:start . ',' . l:end . 'normal! zM'
  execute 'set foldlevel=' . l:level
  execute l:start . ',' . l:end . 'normal! zr'

  let &foldlevel = l:oldlevel
  echo "Folds set to level " . l:level . " from line " . l:start . " to " . l:end
endfunction

nnoremap <leader>fi :call FoldSetLevelInBlock()<CR>
