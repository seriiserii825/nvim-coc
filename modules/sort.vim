nnoremap <silent> go <Cmd>Sort<CR>
vnoremap <silent> go <Esc><Cmd>Sort<CR>
" Optional setup for overriding defaults.
lua << EOF
require("sort").setup({
  -- Input configuration here.
  -- Refer to the configuration section below for options.
  -- List of delimiters, in descending order of priority, to automatically
  -- sort on.
  delimiters = {
    ',',
    '|',
    ';',
    ':',
    's', -- Space
    't'  -- Tab
  }
})
EOF

