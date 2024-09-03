" Copilot
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

nmap <leader>ce :Copilot enable<CR>
nmap <leader>cd :Copilot disable<CR>
