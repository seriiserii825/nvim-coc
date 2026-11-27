" Tagged template with type arguments: sql<T>`...` (drizzle, etc.).
" Built-in typescriptTypeArguments only allows `(` after `>`, so the opening
" backtick is skipped, the closing one opens a template and the rest of the
" file is highlighted as a string. Redefine it with typescriptTemplate in
" nextgroup.
syntax clear typescriptTypeArguments
syntax region typescriptTypeArguments matchgroup=typescriptTypeBrackets
  \ start=/\></ end=/>/
  \ contains=@typescriptType
  \ nextgroup=typescriptFuncCallArg,typescriptTemplate,@typescriptTypeOperator
  \ contained skipwhite
