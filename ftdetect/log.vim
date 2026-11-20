" *.log (and rotated *.log.1, *.log.2.gz-less copies) → filetype=log, see syntax/log.vim
autocmd BufNewFile,BufRead *.log,*.log.[0-9]* setfiletype log
