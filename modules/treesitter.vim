lua << EOF
require('nvim-treesitter').setup({
  ensure_installed = {
    "c", "lua", "vim", "vimdoc", "query",
    "markdown", "markdown_inline",
    "python", "php",
    "typescript", "javascript", "vue", "html", "scss",
  },
  auto_install = true,
})

-- Enable highlighting per filetype, fallback to syntax if parser missing
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      return
    end
    local ok2 = pcall(vim.treesitter.start, args.buf)
    if not ok2 then
      vim.bo[args.buf].syntax = "on"
    end
  end,
})
EOF
