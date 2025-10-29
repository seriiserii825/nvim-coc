function! ToggleBladeFiletype()
  if &filetype ==# 'php.blade'
    set filetype=php
    syntax on
    echo "🔧 Emmet enabled (filetype=php)"
  elseif &filetype ==# 'php'
    set filetype=php.blade
    syntax on
    echo "🎨 Blade syntax restored (filetype=php.blade)"
  else
    echo "ℹ️ Not a Blade/PHP file"
  endif
endfunction

nnoremap <leader>et :call ToggleBladeFiletype()<CR>
