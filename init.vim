"Plugins
source $HOME/.config/nvim/plugins.vim

set termguicolors
" let g:polyglot_disabled = ['vue']
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

"settings
source $HOME/.config/nvim/settings.vim
source $HOME/.config/nvim/functions.vim

"Map
source $HOME/.config/nvim/keys/map-nvim.vim

"Macros
source $HOME/.config/nvim/modules/macros.vim
" source $HOME/.config/nvim/modules/macross/python-macros.vim
source $HOME/.config/nvim/modules/macross/bash-macros.vim

"Coc
source $HOME/.config/nvim/modules/coc.vim
source $HOME/.config/nvim/modules/coc-explorer.vim
source $HOME/.config/nvim/modules/coc-css.vim

"Sftp
source $HOME/.config/nvim/modules/auto-remote-sync.vim

" source $HOME/.config/nvim/modules/gitgutter.vim

"Editor
source $HOME/.config/nvim/modules/which-key.vim
source $HOME/.config/nvim/modules/fzf.vim
source $HOME/.config/nvim/modules/emmet.vim
source $HOME/.config/nvim/modules/multiple-cursors.vim
source $HOME/.config/nvim/modules/rainbow.vim
source $HOME/.config/nvim/modules/indent-guides.vim
source $HOME/.config/nvim/modules/easy-align.vim
source $HOME/.config/nvim/modules/copylot.vim
source $HOME/.config/nvim/modules/undotree.vim
source $HOME/.config/nvim/modules/flash.vim
source $HOME/.config/nvim/modules/tabular.vim
source $HOME/.config/nvim/modules/colorize.vim
source $HOME/.config/nvim/modules/code-runner.vim
source $HOME/.config/nvim/modules/color-picker.vim


"Terminal
source $HOME/.config/nvim/modules/floaterm.vim
source $HOME/.config/nvim/modules/markdown-preview.vim

"Snippets
source $HOME/.config/nvim/modules/ulti-snippets.vim

"Notify
" source $HOME/.config/nvim/modules/nvim-notify.vim
" source $HOME/.config/nvim/modules/nvim-noice.vim

"Theme
source $HOME/.config/nvim/themes/colorscheme.vim
source $HOME/.config/nvim/themes/airline.vim
source $HOME/.config/nvim/modules/bufferline.vim
source $HOME/.config/nvim/modules/openingh.vim


" source $HOME/.config/nvim/modules/colortils.vim

hi Visual  guifg=#000000 guibg=#7FFFD4 gui=none
" source $HOME/.config/nvim/modules/ftp.vim
" source $HOME/.config/nvim/modules/sneak.vim
" source $HOME/.config/nvim/modules/neogit.vim
"
let g:python3_host_prog = "/usr/bin/python"


" Function to get the current Git project path and open it in the browser
function! OpenGitProjectInBrowser()
  " Get the current Git root directory
  let l:git_root = system('git rev-parse --show-toplevel')
  if v:shell_error
    echo "Not a git repository"
    return
  endif

  " Remove any trailing newline
  let l:git_root = substitute(l:git_root, '\n', '', '')

  " Extract the GitHub/Bitbucket/other remote URL from the Git config
  let l:remote_url = system('git config --get remote.origin.url')
  if v:shell_error
    echo "Could not find remote repository"
    return
  endif

  function! ConvertSshToHttps(ssh_url)
    " Remove 'git@' from the SSH URL and convert to HTTPS format
    echo a:ssh_url
    " Replace the second occurrence of ':' with '/'
    let l:url = substitute(a:ssh_url, ':', '/', '')
    echo 'URL after colon substitution: ' . l:url
    let l:url = substitute(l:url, '\n', '', '')

    " Print the URL after replacing the second ':'
    echo 'URL after colon substitution: ' . l:url
   " Get the last 5 characters (or fewer if the line is shorter)
    let l:end_symbols = l:url[-5:]

    " Print the characters at the end of the line
    echo 'End of line symbols: "' . l:end_symbols . '"'

    let l:url = substitute(l:url, '^git@', 'https://', '')

    " Print the URL after the first substitution
    echo 'URL after git@ substitution: ' . l:url

    " Explicitly check and remove the '.git' suffix
    let git_sign = '\.git$'
    if l:url =~ git_sign
      echo 'URL contains .git suffix'
        let l:no_git = substitute(l:url, git_sign, '', '')
        echo 'URL after removing .git: ' . l:no_git
    else
      echo 'URL does not contain .git suffix'
        let l:no_git = l:url
        echo 'URL after removing .git: ' . l:no_git
    endif

    " Append '/src/main/' to the URL for the Bitbucket repository
    let l:https_url = l:no_git . '/src/main/'
    return l:https_url
  endfunction

  " Example usage
  let ssh_url = l:remote_url
  let https_url = ConvertSshToHttps(ssh_url)
  echo https_url

  " Open the remote URL in the default web browser
  if has('mac')
    let l:open_cmd = 'open ' . https_url
  elseif has('unix')
    let l:open_cmd = 'google-chrome-stable ' . https_url
  elseif has('win32')
    let l:open_cmd = 'start ' . https_url
  else
    echo "Unsupported OS"
    return
  endif
  echo "Opening " . l:open_cmd . " in the browser"

  call system(l:open_cmd)
endfunction

" Map the function to a keybinding (e.g., <leader>go)
nnoremap <leader>go :call OpenGitProjectInBrowser()<CR>
