lua << EOF
local wk = require("which-key")

wk.setup({
  preset = "modern",
  win = {
    border = "rounded",
  },
})

-- ── Group / key descriptions ─────────────────────────────────────────
wk.add({
  { "<leader>x",  group = "cleanup" },
  { "<leader>xr", desc = "remove empty lines" },
  { "<leader>xl", desc = "remove leading whitespace" },
})
EOF

" ── Colors (applied on the which_key buffer itself) ──────────────────
augroup WhichKeyColors
  autocmd!
  autocmd FileType which_key call s:WhichKeyColors()
augroup END

function! s:WhichKeyColors() abort
  highlight WhichKey          guifg=#89b4fa gui=bold
  highlight WhichKeyGroup     guifg=#a6e3a1
  highlight WhichKeyDesc      guifg=#cdd6f4
  highlight WhichKeySeparator guifg=#6c7086
  highlight WhichKeyFloat     guibg=#1e1e2e
  highlight WhichKeyBorder    guifg=#89dceb
endfunction
