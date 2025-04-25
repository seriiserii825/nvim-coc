function! ShowDocumentation()
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction


function! LaravelArgAdd()
  let l:files = split(system("find . -path './vendor' -prune -o -type f -name '*.php' -print"), "\n")
  if !empty(l:files)
    execute 'argadd' join(map(l:files, 'fnameescape(v:val)'))
  endif
endfunction

command! LaravelArgAdd call LaravelArgAdd()


function! NodeArgAdd()
  let l:files = split(system("find . -path './node_modules' -prune -o -type f -name '*.ts' -print"), "\n")
  if !empty(l:files)
    execute 'argadd' join(map(l:files, 'fnameescape(v:val)'))
  endif
endfunction

command! NodeArgAdd call NodeArgAdd()
