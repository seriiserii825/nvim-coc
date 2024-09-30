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
" source $HOME/.config/nvim/modules/undotree.vim
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
source $HOME/.config/nvim/modules/vimspector.vim

"Notify
" source $HOME/.config/nvim/modules/nvim-notify.vim
" source $HOME/.config/nvim/modules/nvim-noice.vim

"Theme
source $HOME/.config/nvim/themes/colorscheme.vim
source $HOME/.config/nvim/themes/airline.vim
" source $HOME/.config/nvim/themes/monokaipro.vim
source $HOME/.config/nvim/modules/bufferline.vim
" source $HOME/.config/nvim/modules/openingh.vim


" source $HOME/.config/nvim/modules/colortils.vim

hi Visual  guifg=#000000 guibg=#7FFFD4 gui=none
" source $HOME/.config/nvim/modules/ftp.vim
" source $HOME/.config/nvim/modules/sneak.vim
" source $HOME/.config/nvim/modules/neogit.vim
"
let g:python3_host_prog = "/usr/bin/python"


set grepprg=grep\ -R\ --exclude-dir={venv,node_modules,.git}\ -nH\ $*


" Initialize the global variable to disable auto-upload by default
let g:auto_upload_enabled = 0

" Function to load the project-specific config file
function! LoadProjectConfig()
    let l:config_path = expand('%:p:h') . '/.nvim/config.vim'
    if filereadable(l:config_path)
        execute 'source' l:config_path
    else
        let g:ftp_server_type = ''
        let g:ftp_server = ''
        let g:ftp_username = ''
        let g:ftp_password = ''
        let g:ftp_remote_path = ''
    endif
endfunction

" Function to upload the file using lftp for FTP or SFTP
function! UploadViaLftp(filepath)
    call LoadProjectConfig()
    if g:ftp_server != '' && g:ftp_password != ''
        let l:filename = fnamemodify(a:filepath, ':t')
        if g:ftp_server_type ==# 'sftp'
            let l:cmd = printf('lftp -u %s,%s sftp://%s -e "put %s -o %s%s; bye"',
                \ g:ftp_username, g:ftp_password, g:ftp_server, a:filepath, g:ftp_remote_path, l:filename)
        elseif g:ftp_server_type ==# 'ftp'
            let l:cmd = printf('lftp -u %s,%s ftp://%s -e "put %s -o %s%s; bye"',
                \ g:ftp_username, g:ftp_password, g:ftp_server, a:filepath, g:ftp_remote_path, l:filename)
        else
            echo "Invalid server type. Use 'ftp' or 'sftp'."
            return
        endif
        call system(l:cmd)
    endif
endfunction

" Autocommand to upload file on save only if auto-upload is enabled
autocmd BufWritePost * if g:auto_upload_enabled | call UploadViaLftp(expand('%:p')) | endif

" Command to toggle auto-upload on/off
command! ToggleAutoUpload if g:auto_upload_enabled == 0 | let g:auto_upload_enabled = 1 | echo "Auto-upload enabled" | else | let g:auto_upload_enabled = 0 | echo "Auto-upload disabled" | endif
