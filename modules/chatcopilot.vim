lua << EOF
require("CopilotChat").setup {
  -- The key to open the chat window
mappings = {
      reset = {
        normal = '<leader>cr',
        insert = '<C-c>',
      }
    }
}
EOF

nmap <leader>co :CopilotChatOpen<CR> 
