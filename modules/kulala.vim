" sudo pacman -S tree-sitter-cli

autocmd BufNewFile,BufRead *.http setfiletype http
autocmd BufNewFile,BufRead *.rest setfiletype http

lua << EOF
require('kulala').setup({
	global_keymaps = false,
	global_keymaps_prefix = "<leader>R",
	kulala_keymaps_prefix = "",
	default_env = "dev",
	ui = {
		display_mode = "split",
		split_direction = "right",
	},
})

_G.KulalaSearchRun = function()
	local DB = require("kulala.db")
	local Parser = require("kulala.parser.document")

	DB.set_current_buffer()
	local requests = Parser.get_document()
	if not requests then return end

	table.sort(requests, function(a, b) return a.start_line < b.start_line end)

	local names, by_name = {}, {}
	for _, request in ipairs(requests) do
		table.insert(names, request.name)
		by_name[request.name] = request
	end

	vim.ui.select(names, { prompt = "Search & run request" }, function(choice)
		if not choice then return end
		vim.cmd("normal! " .. by_name[choice].start_line .. "Gzz")
		require("kulala").run()
	end)
end
EOF

autocmd FileType kulala_ui nnoremap <buffer> <silent> <C-h> <C-w>h
autocmd FileType kulala_ui nnoremap <buffer> <silent> <C-l> <C-w>l
autocmd FileType kulala_ui nnoremap <buffer> <silent> <C-j> <C-w>j
autocmd FileType kulala_ui nnoremap <buffer> <silent> <C-k> <C-w>k

nnoremap <silent> <leader>kr :lua require('kulala').run()<CR>
nnoremap <silent> <leader>ka :lua require('kulala').run_all()<CR>
nnoremap <silent> <leader>ki :lua require('kulala').inspect()<CR>
nnoremap <silent> <leader>kT :lua require('kulala').toggle_view()<CR>
nnoremap <silent> <leader>kp :lua require('kulala').jump_prev()<CR>
nnoremap <silent> <leader>kn :lua require('kulala').jump_next()<CR>
nnoremap <silent> <leader>kc :lua require('kulala').copy()<CR>
nnoremap <silent> <leader>kq :lua require('kulala').close()<CR>
nnoremap <silent> <leader>kb :lua require('kulala').scratchpad()<CR>
nnoremap <silent> <leader>ks :lua require('kulala').search()<CR>
nnoremap <silent> <leader>kw :lua KulalaSearchRun()<CR>
nnoremap <silent> <leader>ke :lua require('kulala').set_selected_env()<CR>
