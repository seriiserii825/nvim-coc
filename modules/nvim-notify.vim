lua << EOF
require("notify").setup({
background_colour = "#000000",
timeout = 3000,
render = "compact",
stages = "fade",
top_down = false,
})
vim.notify = require("notify")
EOF
