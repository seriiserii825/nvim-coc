" Align column definitions inside CREATE TABLE (...) blocks on save:
"   name   TYPE          constraints...
" Lines nested deeper than the table's own parens (multi-line CHECK bodies)
" and table-level constraints (PRIMARY KEY (...), CONSTRAINT ..., etc.) are left as-is.
" :SqlAlign — run manually; let g:sql_align_on_save = 0 to disable on save.

lua << EOF
local M = {}

local constraint_kw = {
  CONSTRAINT = true, PRIMARY = true, FOREIGN = true, UNIQUE = true,
  CHECK = true, EXCLUDE = true, LIKE = true, INDEX = true, KEY = true,
}

-- multi-word types: first word -> list of possible continuations
local multiword = {
  DOUBLE = { 'PRECISION' },
  CHARACTER = { 'VARYING' },
  BIT = { 'VARYING' },
  TIMESTAMP = { 'WITH TIME ZONE', 'WITHOUT TIME ZONE' },
  TIMESTAMPTZ = {},
  TIME = { 'WITH TIME ZONE', 'WITHOUT TIME ZONE' },
}

-- paren delta of a line, ignoring '...' strings and -- comments
local function paren_delta(s)
  local d, i, n, in_str = 0, 1, #s, false
  while i <= n do
    local c = s:sub(i, i)
    if in_str then
      if c == "'" then in_str = false end
    elseif c == "'" then in_str = true
    elseif c == '-' and s:sub(i + 1, i + 1) == '-' then break
    elseif c == '(' then d = d + 1
    elseif c == ')' then d = d - 1 end
    i = i + 1
  end
  return d
end

-- read a balanced (...) starting at position i (s:sub(i,i) == '(')
local function read_parens(s, i)
  local depth = 0
  for j = i, #s do
    local c = s:sub(j, j)
    if c == '(' then depth = depth + 1
    elseif c == ')' then
      depth = depth - 1
      if depth == 0 then return j end
    end
  end
  return nil
end

-- split "name TYPE rest" -> name, type, rest  (nil if not a column line)
local function parse_column(body)
  local name, pos = body:match('^("[^"]+")()')
  if not name then name, pos = body:match('^([%w_]+)()') end
  if not name or constraint_kw[name:upper()] then return nil end

  local s = body:sub(pos):gsub('^%s+', '')
  local typ, tpos = s:match('^([%a_][%w_]*)()')
  if not typ then return nil end

  -- multi-word types
  local conts = multiword[typ:upper()]
  if conts then
    for _, cont in ipairs(conts) do
      local pat = '^%s+' .. cont:gsub(' ', '%%s+')
      local a, b = s:sub(tpos):upper():find(pat)
      if a then
        typ = typ .. ' ' .. s:sub(tpos + a - 1, tpos + b - 1):gsub('^%s+', ''):gsub('%s+', ' ')
        tpos = tpos + b
        break
      end
    end
  end

  -- (args) right after type, e.g. VARCHAR(100), NUMERIC(10, 2)
  local after = s:sub(tpos)
  local sp = after:match('^%s*')
  if after:sub(#sp + 1, #sp + 1) == '(' then
    local close = read_parens(after, #sp + 1)
    if close then
      typ = typ .. after:sub(#sp + 1, close)
      after = after:sub(close + 1)
    end
  end
  -- array suffix: INT[], TEXT[][]
  while after:match('^%[%d*%]') do
    local a = after:match('^%[%d*%]')
    typ = typ .. a
    after = after:sub(#a + 1)
  end

  local rest = after:gsub('^%s+', ''):gsub('%s+$', '')
  -- trailing comma with nothing else stays glued to the type
  if rest == ',' then
    typ = typ .. ','
    rest = ''
  end
  return name, typ, rest
end

function M.align(buf)
  buf = buf or 0
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local changed = {}
  local i = 1
  while i <= #lines do
    local l = lines[i]
    if l:upper():match('^%s*CREATE%s+.-TABLE') and paren_delta(l) > 0 then
      local depth = paren_delta(l)
      local cols = {}
      local j = i + 1
      while j <= #lines and depth > 0 do
        local line = lines[j]
        if depth == 1 then
          local indent, body = line:match('^(%s*)(.-)%s*$')
          if body ~= '' and not body:match('^%-%-') and not body:match('^%)') then
            local name, typ, rest = parse_column(body)
            if name then
              table.insert(cols, { idx = j, indent = indent, name = name, typ = typ, rest = rest })
            end
          end
        end
        depth = depth + paren_delta(line)
        j = j + 1
      end

      if #cols > 0 then
        local wn, wt = 0, 0
        for _, c in ipairs(cols) do
          wn = math.max(wn, vim.fn.strdisplaywidth(c.name))
          if c.rest ~= '' then wt = math.max(wt, vim.fn.strdisplaywidth(c.typ)) end
        end
        local indent = cols[1].indent
        for _, c in ipairs(cols) do
          local out = indent .. c.name .. string.rep(' ', wn - vim.fn.strdisplaywidth(c.name) + 1) .. c.typ
          if c.rest ~= '' then
            out = out .. string.rep(' ', wt - vim.fn.strdisplaywidth(c.typ) + 1) .. c.rest
          end
          if out ~= lines[c.idx] then
            lines[c.idx] = out
            changed[c.idx] = out
          end
        end
      end
      i = j
    else
      i = i + 1
    end
  end

  for idx, text in pairs(changed) do
    vim.api.nvim_buf_set_lines(buf, idx - 1, idx, false, { text })
  end
end

-- ---------------------------------------------------------------------------
-- Uppercase SQL keywords / type names. Skips '...' strings, "..." identifiers,
-- -- and /* */ comments, $$ bodies, words touching a '.' (schema.table),
-- and the column name at the start of a CREATE TABLE column line.
local keywords = {}
for w in ([[
  select from where and or not null is in exists between like ilike as on join
  left right inner outer full cross natural using group by order having limit offset
  union all intersect except distinct case when then else end asc desc nulls first last
  insert into values update set delete returning default conflict do nothing
  create alter drop table schema index unique primary key foreign references
  constraint check cascade restrict no action if replace view materialized
  sequence trigger function procedure language returns begin commit rollback
  transaction add column rename to enum extension owner grant revoke
  temp temporary with without time zone collate deferrable initially deferred immediate
  serial bigserial smallserial int integer bigint smallint numeric decimal real
  double precision float boolean bool char character varchar varying text bytea
  uuid json jsonb date timestamp timestamptz interval inet cidr money xml
  true false now current_timestamp current_date
]]):gmatch('%S+') do keywords[w] = true end

local function upper_line(line, state, skip_first)
  local out, i, n = {}, 1, #line
  local first_word_done = not skip_first
  while i <= n do
    local c = line:sub(i, i)
    if state.dollar then
      local e = line:find(state.dollar, i, true)
      if e then
        table.insert(out, line:sub(i, e + #state.dollar - 1)); i = e + #state.dollar; state.dollar = nil
      else table.insert(out, line:sub(i)); break end
    elseif state.block then
      local e = line:find('*/', i, true)
      if e then table.insert(out, line:sub(i, e + 1)); i = e + 2; state.block = false
      else table.insert(out, line:sub(i)); break end
    elseif c == '-' and line:sub(i + 1, i + 1) == '-' then
      table.insert(out, line:sub(i)); break
    elseif c == '/' and line:sub(i + 1, i + 1) == '*' then
      state.block = true; table.insert(out, '/*'); i = i + 2
    elseif c == "'" or c == '"' then
      local e = line:find(c, i + 1, true)
      e = e or n
      table.insert(out, line:sub(i, e)); i = e + 1
    elseif c == '$' and line:match('^%$[%w_]*%$', i) then
      local tag = line:match('^%$[%w_]*%$', i)
      state.dollar = tag; table.insert(out, tag); i = i + #tag
    elseif c:match('[%a_]') then
      local w = line:match('^[%w_]+', i)
      local prev = line:sub(i - 1, i - 1)
      local nxt = line:sub(i + #w, i + #w)
      if not first_word_done then
        first_word_done = true
        table.insert(out, w)
      elseif keywords[w:lower()] and prev ~= '.' and nxt ~= '.' then
        table.insert(out, w:upper())
      else
        table.insert(out, w)
      end
      i = i + #w
    else
      if c:match('%S') then first_word_done = true end
      table.insert(out, c); i = i + 1
    end
  end
  return table.concat(out)
end

function M.upper(buf)
  buf = buf or 0
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local state = {}
  local tdepth = 0 -- paren depth inside CREATE TABLE (...)
  for idx, line in ipairs(lines) do
    local skip_first = false
    if tdepth == 1 then
      local word = line:match('^%s*([%w_]+)')
      skip_first = word ~= nil and not constraint_kw[word:upper()]
    end
    local new = upper_line(line, state, skip_first)
    if tdepth > 0 then
      tdepth = tdepth + paren_delta(line)
    elseif line:upper():match('^%s*CREATE%s+.-TABLE') then
      tdepth = math.max(paren_delta(line), 0)
    end
    if new ~= line then
      vim.api.nvim_buf_set_lines(buf, idx - 1, idx, false, { new })
    end
  end
end

_G.SqlAlign = M
EOF

if !exists('g:sql_align_on_save')
  let g:sql_align_on_save = 1
endif

if !exists('g:sql_upper_on_save')
  let g:sql_upper_on_save = 1
endif

command! SqlAlign lua SqlAlign.align(0)
command! SqlUpper lua SqlAlign.upper(0)

augroup SqlAlignOnSave
  autocmd!
  autocmd BufWritePre *.sql if g:sql_upper_on_save | execute 'lua SqlAlign.upper(0)' | endif
  autocmd BufWritePre *.sql if g:sql_align_on_save | execute 'lua SqlAlign.align(0)' | endif
augroup END
