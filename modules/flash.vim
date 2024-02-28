lua << EOF
require("flash").setup()
EOF

nmap s <cmd>lua require("flash").jump()<CR>
