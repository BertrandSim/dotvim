" Regions {([])} and Headers #### ==== ----
" changed rRegion to rRegionParen, rRegionBrace, rRegionCurly
" changed Title from [_=#]{4,} to 3 capture groups.
" changed Title to allow spaces before #
" inserted option r_syntax_brace_folding
if exists("g:r_syntax_folding")
  syn region rRegionParen matchgroup=Delimiter start=/(/ matchgroup=Delimiter end=/)/ transparent contains=ALLBUT,rError,rBraceError,rCurlyError fold
  syn region rRegionCurly matchgroup=Delimiter start=/{/ matchgroup=Delimiter end=/}/ transparent contains=ALLBUT,rError,rBraceError,rParenError fold
  syn region rRegionBrace matchgroup=Delimiter start=/\[/ matchgroup=Delimiter end=/]/ transparent contains=ALLBUT,rError,rCurlyError,rParenError fold
  " syn region rSection matchgroup=Title start=/^#.*[-=#]\{4,})/ end=/^#.*[-=#]\{4,}/ms=s-2,me=s-1 transparent contains=ALL fold
  syn region rSection matchgroup=Title start=/^\s*#.*\v(\-{4,}|\={4,}|#{4,})/ end=/^\s*#.*\v(\-{4,}|\={4,}|#{4,})/ms=s-2,me=s-1 transparent contains=ALL fold
elseif exists("g:r_syntax_brace_folding")
  syn region rRegionParen matchgroup=Delimiter start=/(/ matchgroup=Delimiter end=/)/ transparent contains=ALLBUT,rError,rBraceError,rCurlyError
  syn region rRegionCurly matchgroup=Delimiter start=/{/ matchgroup=Delimiter end=/}/ transparent contains=ALLBUT,rError,rBraceError,rParenError fold
  syn region rRegionBrace matchgroup=Delimiter start=/\[/ matchgroup=Delimiter end=/]/ transparent contains=ALLBUT,rError,rCurlyError,rParenError
  syn region rSection matchgroup=Title start=/^\s*#.*\v(\-{4,}|\={4,}|#{4,})/ end=/^\s*#.*\v(\-{4,}|\={4,}|#{4,})/ms=s-2,me=s-1 transparent contains=ALL fold
else
  syn region rRegionParen matchgroup=Delimiter start=/(/ matchgroup=Delimiter end=/)/ transparent contains=ALLBUT,rError,rBraceError,rCurlyError
  syn region rRegionCurly matchgroup=Delimiter start=/{/ matchgroup=Delimiter end=/}/ transparent contains=ALLBUT,rError,rBraceError,rParenError
  syn region rRegionBrace matchgroup=Delimiter start=/\[/ matchgroup=Delimiter end=/]/ transparent contains=ALLBUT,rError,rCurlyError,rParenError
endif

syn match rError      "[)\]}]"
syn match rBraceError "[)}]" contained
syn match rCurlyError "[)\]]" contained
syn match rParenError "[\]}]" contained

" vim: ts=8 sw=2: foldmethod=marker 
