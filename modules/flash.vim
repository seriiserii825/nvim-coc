lua << EOF
require("flash").setup()
EOF

nmap s <cmd>lua require("flash").jump()<CR>
nmap <leader>ft <cmd>lua require("flash").toggle()<CR>
onoremap r <cmd>lua require("flash").remote()<CR>
