autocmd Filetype * AnyFoldActivate               " activate for all filetypes
set foldlevel=99 " Open all folds
let g:anyfold_fold_comments=1
let g:foldmethod="indent"
hi Folded guibg=gray guifg=black

" help: fold-command
" Use key combinations [[ and ]] to navigate to the beginning and end of the current open fold. 
" Use ]k and [j to navigate to the end of the previous block and to the beginning of the next block. 
" zf{motion} - create fold
" zc - fold
" zC - fold all under cursor
" zo - unfold
" zO - unfold all under cursor
" zM - Close all folds recursively
" zR - Unfodl all
