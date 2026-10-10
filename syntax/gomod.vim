" Vim syntax file
" Language: go.mod (Go module definition)

if exists("b:current_syntax")
  finish
endif

syntax case match

syn keyword gomodDirective module go toolchain require exclude replace retract
      \ nextgroup=gomodModulePath skipwhite

syn match gomodComment "//.*$" contains=@Spell
syn region gomodBlock start="(" end=")" transparent fold

syn match gomodVersion "\<v\d\+\.\d\+\.\d\+\%([-+][A-Za-z0-9.-]\+\)\?\>"
syn match gomodArrow "=>"

syn match gomodModulePath "\v[A-Za-z0-9][A-Za-z0-9_.\-/]*\.[A-Za-z]{2,}[A-Za-z0-9_.\-/]*" contains=NONE

hi def link gomodDirective  Keyword
hi def link gomodComment    Comment
hi def link gomodVersion    Number
hi def link gomodArrow      Operator
hi def link gomodModulePath Identifier

let b:current_syntax = "gomod"
