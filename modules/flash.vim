lua << EOF
require("flash").setup()
EOF

nmap sn <cmd>lua require("flash").jump()<CR>
