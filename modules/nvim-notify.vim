lua << EOF
require("notify")("My super important message")
vim.notify = require("notify")
EOF
