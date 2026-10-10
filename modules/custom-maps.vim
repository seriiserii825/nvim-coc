" Replacement for fzf.vim's :Maps.
"
" fzf.vim's :Maps builds its list by text-parsing `:verbose {mode}map`
" output. That parser breaks on mappings defined with
" `vim.keymap.set(..., {desc = '...'})`: Neovim prints the desc on its own
" indented line, which the parser misreads as a second, unrelated entry —
" and for Lua-defined mappings "Last set from" collapses to the generic
" "Lua (run Nvim with -V1 for more details)", losing the real file:line.
"
" This reads mappings through the structured API
" (nvim_get_keymap/nvim_buf_get_keymap) instead, so `desc` becomes its own
" column and the source file:line is resolved via getscriptinfo(sid) —
" both survive no matter how the mapping was defined.

lua << EOF
local function source_of(m)
  if m.sid and m.sid > 0 then
    local ok, info = pcall(vim.fn.getscriptinfo, { sid = m.sid })
    if ok and info and info[1] then
      local name = vim.fn.fnamemodify(info[1].name, ':t')
      return string.format('%s:%d', name, m.lnum or 0)
    end
  end
  return '(lua)'
end

local function action_of(m)
  if m.rhs and m.rhs ~= '' then
    return m.rhs
  elseif m.callback then
    return '<lua function>'
  end
  return ''
end

local function collect(mode)
  local seen, rows = {}, {}
  local all = {}
  vim.list_extend(all, vim.api.nvim_buf_get_keymap(0, mode))
  vim.list_extend(all, vim.api.nvim_get_keymap(mode))
  for _, m in ipairs(all) do
    local key = vim.fn.keytrans(m.lhs)
    if not seen[key] then
      seen[key] = true
      table.insert(rows, m)
    end
  end
  return rows
end

_G.__custom_maps_lookup = {}

-- Builds the display lines + the lhs lookup table. Split out from run() so
-- it can be exercised without opening the fzf UI.
local function build(mode)
  local maps = collect(mode)
  local rows = {}
  local key_w, desc_w, action_w = 0, 0, 0

  local function clip(s, max)
    if #s > max then
      return s:sub(1, max - 3) .. '...'
    end
    return s
  end

  for _, m in ipairs(maps) do
    local key = clip(vim.fn.keytrans(m.lhs), 35)
    local desc = clip(m.desc or '', 35)
    local action = clip(action_of(m), 60)
    key_w = math.max(key_w, #key)
    desc_w = math.max(desc_w, #desc)
    action_w = math.max(action_w, #action)
    table.insert(rows, { key = key, desc = desc, action = action, src = source_of(m), raw = m.lhs })
  end
  table.sort(rows, function(a, b) return a.key < b.key end)

  local lines, lookup = {}, {}
  for _, r in ipairs(rows) do
    local line = string.format(
      '%-' .. key_w .. 's  %-' .. desc_w .. 's  %-' .. action_w .. 's  %s',
      r.key, r.desc, r.action, r.src)
    table.insert(lines, line)
    lookup[line] = r.raw
  end
  return lines, lookup
end

local function run(mode)
  local lines, lookup = build(mode)
  _G.__custom_maps_lookup = lookup

  vim.fn['fzf#run'](vim.fn['fzf#wrap']('keymaps', {
    source = lines,
    sink = function(line)
      local raw = _G.__custom_maps_lookup[line]
      if raw then
        vim.api.nvim_feedkeys(raw, 'n', false)
      end
    end,
    options = { '--prompt', 'Maps (' .. mode .. ')> ', '--no-hscroll', '--nth', '1,2,3' },
  }))
end

_G.__custom_maps_run = run
_G.__custom_maps_build = build
EOF

command! -nargs=? KeyMaps lua __custom_maps_run(<q-args> == '' and 'n' or <q-args>)
