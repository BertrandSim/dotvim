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

" Added {{{1

" Need to be placed before the above part?
" see :h syn-priority

" if exists("g:r_syntax_func_folding")
  " Original
  " syn region rFunc start=/function\s*(\_.*)\s*{/ end=/}/ transparent contains=ALLBUT,rError,rBraceError,rParenError fold
  " syn region rFunc start=/function\s*(\_.\{-})\s*{/ end=/}/ transparent contains=ALLBUT,rError,rBraceError,rParenError fold
  " syn region rFunc start=/function/ end=/}/ transparent contains=ALLBUT,rError,rBraceError,rParenError fold
  " syn region rFunc start=/function/ end=/}/ transparent contains=ALL fold
  " syn region rFunc start=/fnction(/ end=/)/ transparent fold 
  " syn region rFunc start=/fnction(/ end=/)/ transparent contains=rRegion keepend fold 
  " syn region rFunc start=/fnction(/ end=/# Inputs/ transparent contains=rComment fold 
  " Above does not work ^^^^
  " interesting cases...
  " syn region rFunc start=/fnction(/ end=/# Inputs/ transparent contains=ALLBUT,rRegionCurly,rComment fold 
  " syn region rFunc start=/fnction(/ end=/{/ transparent contains=ALLBUT,rRegionCurly fold 
  " syn region rFunc start=/fnction(/ end=/npropose/ transparent contains=ALLBUT,rRegion keepend fold 
  " below ok ---
  " syn region rFunc start=/fnction(/ end=/nimages/ transparent contains=rRegion fold 
  " syn region rFunc start=/fnction/ end=/nimages/ transparent contains=rRegion fold 
  " syn region rFunc start=/fnction(/ end=/nimages/ transparent fold 
  " syn region rFunc start=/fnction/ end=/nimages/ transparent fold
" endif

" }}}

" Don't mask roxygen block rOBlock syntax highlighting
" redefine these syntax regions again, 
" as they have been masked by syn match rOTitle.
" XXX [2020-03-09] PR has been submitted on github... awaiting response
if g:r_syntax_hl_roxygen
  " When a roxygen block has a title and additional content, the title
  " consists of one or more roxygen lines (as little as possible are matched),
  " followed either by an empty roxygen line
  syn region rOBlock start="\%^\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*$" end="^\s*\(#\{1,2}'\)\@!" contains=rOTitle,rOTag,rOExamples,@Spell keepend fold
  syn region rOBlock start="^\s*\n\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*$" end="^\s*\(#\{1,2}'\)\@!" contains=rOTitle,rOTag,rOExamples,@Spell keepend fold

  " or by a roxygen tag (we match everything starting with @ but not @@ which is used as escape sequence for a literal @).
  syn region rOBlock start="\%^\(\s*#\{1,2}' .*\n\)\{-}\s*#\{1,2}' @\(@\)\@!" end="^\s*\(#\{1,2}'\)\@!" contains=rOTitle,rOTag,rOExamples,@Spell keepend fold
  syn region rOBlock start="^\s*\n\(\s*#\{1,2}' .*\n\)\{-}\s*#\{1,2}' @\(@\)\@!" end="^\s*\(#\{1,2}'\)\@!" contains=rOTitle,rOTag,rOExamples,@Spell keepend fold
endif



" vim: ts=8 sw=2: foldmethod=marker 
