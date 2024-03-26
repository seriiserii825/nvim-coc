lua << EOF
local neogit = require('neogit')
neogit.setup {}
EOF

nnoremap <leader>n :Neogit kind=vsplit<CR>
