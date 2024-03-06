lua << EOF
require("flash").setup()
EOF

nmap sn <cmd>lua require("flash").jump()<CR>
nmap <leader>fl <cmd>lua require("flash").toggle()<CR>
