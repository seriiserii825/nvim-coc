lua << EOF
require("flash").setup()
EOF

nmap <leader>ls <cmd>lua require("flash").jump()<CR>
