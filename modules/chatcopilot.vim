lua << EOF
require("CopilotChat").setup {
  -- See Configuration section for options
}
EOF

map <leader>co :CopilotChatOpen<CR> 
