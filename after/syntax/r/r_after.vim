" Custom syntax rules for regions, headers, functions
" Custom dictionary 'g:r_syn_fold' for folding options

let s:r_syn_fold = get(g:, 'r_syn_fold', {})
let s:r_syn_fold.paren = get(s:r_syn_fold, 'paren', 0)
let s:r_syn_fold.curly = get(s:r_syn_fold, 'curly', 0)
let s:r_syn_fold.brace = get(s:r_syn_fold, 'brace', 0)
let s:r_syn_fold.section = get(s:r_syn_fold, 'section', 0)
let s:r_syn_fold.funcArgs = get(s:r_syn_fold, 'funcArgs', 0)
let s:r_syn_fold.funcBody = get(s:r_syn_fold, 'funcBody', 0)


" rFunction syntax definition {{{1
" and folding

" remove 'function' as a keyword
syn clear rType
syn keyword rType array category character complex double integer list logical matrix numeric vector data.frame

" function (<args>) {<body>}
syn match rFuncWord /function/ skipwhite nextgroup=rFuncArgs 

exec 'syn region rFuncArgs matchgroup=rParen start=/(/ end=/)/ skipwhite nextgroup=rFuncBody contained' . 
  \ ' transparent contains=ALLBUT,rError,rBraceError,rCurlyError' .
  \ (s:r_syn_fold.funcArgs ? ' fold' : '')
exec 'syn region rFuncBody matchgroup=rCurly start=/{/ end=/}/ contained' .
  \ ' transparent contains=ALLBUT,rError,rCurlyError,rParenError' .
  \ (s:r_syn_fold.funcBody ? ' fold' : '')


" Regions {([])} and Headers #### ==== ---- {{{1
" changed rRegion to rRegionParen, rRegionBrace, rRegionCurly
" changed Title from [_=#]{4,} to 3 capture groups.
" changed Title to allow spaces before #

exec 'syn region rRegionParen matchgroup=rParen start=/(/ end=/)/ transparent contains=ALLBUT,rError,rBraceError,rCurlyError' . 
  \ (s:r_syn_fold.paren ? ' fold' : '')
exec 'syn region rRegionCurly matchgroup=rCurly start=/{/ end=/}/ transparent contains=ALLBUT,rError,rBraceError,rParenError' .
  \ (s:r_syn_fold.curly ? ' fold' : '')
exec 'syn region rRegionBrace matchgroup=rBrace start=/\[/ end=/]/ transparent contains=ALLBUT,rError,rCurlyError,rParenError' .
  \ (s:r_syn_fold.brace ? ' fold' : '')

exec 'syn region rSection matchgroup=Title start=/^\s*#.*\v(\-{4,}|\={4,}|#{4,})/ end=/^\s*#.*\v(\-{4,}|\={4,}|#{4,})/ms=s-2,me=s-1 transparent contains=ALL' .
  \ (s:r_syn_fold.section ? ' fold' : '')


" highlight definitions {{{1

hi def link rFuncWord rType
hi def link rParen Delimiter
hi def link rBrace Delimiter
hi def link rCurly Delimiter


" vim: ts=8 sw=2: foldmethod=marker 
