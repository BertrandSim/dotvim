
" WIP: syntax for functions
" in the hope that they can be folded via foldmethod=syntax


" Need to be placed before ...?
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


" vim: ts=8 sw=2: foldmethod=marker 
