" Vim syntax file
" Language: generic application logs (zap/logrus/slog/syslog-like)

if exists("b:current_syntax")
  finish
endif

syntax case ignore

" --- Levels -----------------------------------------------------------------
syn keyword logLevelError  ERROR ERR FATAL CRITICAL CRIT PANIC DPANIC EMERG ALERT FAILED FAILURE
syn keyword logLevelWarn   WARN WARNING
syn keyword logLevelInfo   INFO NOTICE
syn keyword logLevelDebug  DEBUG TRACE
syn match   logLevelError  '\<level=\%(error\|fatal\|panic\)\>'
syn match   logLevelWarn   '\<level=warn\%(ing\)\=\>'
syn match   logLevelInfo   '\<level=info\>'
syn match   logLevelDebug  '\<level=\%(debug\|trace\)\>'

syntax case match

" --- Date / time ------------------------------------------------------------
" 2026-11-20, 2026/11/20, 2026-11-20T17:19:54.18443Z, +03:00
syn match logDate '\<\d\{4}[-/]\d\{2}[-/]\d\{2}\ze\%(T\|\s\|$\)'
syn match logDate '\<\a\{3} \{1,2}\d\{1,2}\>'                       " syslog: Nov 20
syn match logTime '\%(\d\|T\)\@<=\d\{2}:\d\{2}:\d\{2}\%([.,]\d\+\)\=\%(Z\|[+-]\d\{2}:\=\d\{2}\)\='
syn match logTime '\<\d\{2}:\d\{2}:\d\{2}\%([.,]\d\+\)\=\>'
syn match logDateTimeSep 'T\ze\d\{2}:' contained

" --- Source location: server/server.go:44, main.py:12, at Foo.java:33 -------
syn match logCaller '\<[[:alnum:]_./-]\+\.\a\+:\d\+\%(:\d\+\)\=\>'

" --- Values ------------------------------------------------------------------
syn match  logNumber   '\<-\=\d\+\%(\.\d\+\)\=\%(ms\|s\|µs\|ns\|m\|h\|b\|kb\|mb\|gb\|%\)\=\>'
syn match  logHex      '\<0x\x\+\>'
syn match  logUUID     '\<\x\{8}-\x\{4}-\x\{4}-\x\{4}-\x\{12}\>'
syn match  logIP       '\<\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}\%(:\d\+\)\=\>'
syn match  logAddr     '"\=:\d\{2,5}"\='
syn match  logURL      '\<\a\+://[^ \t"'')\]]\+'
syn match  logPath     '\%(^\|\s\)\zs/[[:alnum:]_./-]\+'
syn keyword logBool    true false nil null None NULL
syn match  logHTTPVerb '\<\%(GET\|POST\|PUT\|PATCH\|DELETE\|HEAD\|OPTIONS\)\>'
syn match  logStatus2  '\<status[=:]\s*"\=2\d\d\>'
syn match  logStatus4  '\<status[=:]\s*"\=[45]\d\d\>'

" key=value (logfmt) and "key": value (JSON fields)
syn match  logKey      '\<[[:alnum:]_.-]\+\ze='
syn match  logJSONKey  '"[^"]\+"\ze\s*:'
syn region logString   start=+"+ skip=+\\"+ end=+"+ oneline contains=logURL,logUUID,logIP
syn region logString   start=+'+ skip=+\\'+ end=+'+ oneline
syn match  logBrace    '[{}\[\]]'

" Re-apply after logString so JSON keys win over the generic string region
syn match  logJSONKey  '"[^"]\+"\ze\s*:'

" --- Stack traces / errors ---------------------------------------------------
syn match  logTraceLine '^\s\+at .*$'
syn match  logTraceLine '^goroutine \d\+ \[.*\]:$'
syn match  logTraceLine '^\s\+\S\+\.go:\d\+ +0x\x\+$'
syn match  logErrKey    '\<\%(error\|err\|exception\|stacktrace\)\ze\%(=\|":\)'

" --- Highlight links --------------------------------------------------------
hi def link logLevelError  ErrorMsg
hi def link logLevelWarn   WarningMsg
hi def link logLevelInfo   Function
hi def link logLevelDebug  Comment

hi def link logDate        Comment
hi def link logTime        Comment
hi def link logCaller      Directory

hi def link logNumber      Number
hi def link logHex         Number
hi def link logUUID        Label
hi def link logIP          Constant
hi def link logAddr        Constant
hi def link logURL         Underlined
hi def link logPath        Directory
hi def link logBool        Boolean
hi def link logHTTPVerb    Keyword
hi def link logStatus2     String
hi def link logStatus4     ErrorMsg

hi def link logKey         Identifier
hi def link logJSONKey     Identifier
hi def link logString      String
hi def link logBrace       Delimiter

hi def link logTraceLine   Special
hi def link logErrKey      ErrorMsg

let b:current_syntax = "log"
