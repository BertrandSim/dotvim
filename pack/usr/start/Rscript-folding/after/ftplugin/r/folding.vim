" foldexprs and foldtexts for .R files.
" folds (1) ## headers ---- and (2) functions(){}
" does not yet support nested functions that start (or end) on the same line. [todo]

setlocal foldmethod=expr
setlocal foldexpr=RScriptFoldExpr()
setlocal foldtext=RscriptFoldText()

" Helper Functions {{{1

function! s:isHeader(lnum)
  " return true if line lnum starts with #'s and ends with ----
  let thisline = getline(a:lnum)
  return (thisline =~ '\v^\s*\#+') && (thisline =~ '\v\-{4,}$')
endfunction

function! s:countHashes(lnum)
  let thisline = getline(a:lnum)
  return len(matchstr(thisline, '^\s*\zs#\{1,9}\ze'))
endfunction

function! s:isRCommentOrString(lnum, cnum)
  return synIDattr(synID(a:lnum, a:cnum, 0), "name") =~? 'rComment\|rString'
endfunction

function! s:isStartOfFunc(lnum)
" return true if line lnum contains \zs function ( \ze ...) {
  let thisline = getline(a:lnum)
  let patternFuncStart = '\v(\w+\s*(\<\-|\=)\s*)?' . 'function\s*\('	
  " see textobj-rfunc.vim for details of above regex. 
  " Note that, being a single line search, 
  " \s* is used in place of \_s after <- | = .
  if thisline =~ patternFuncStart
    let curpos_save = getpos('.')
    call cursor(a:lnum, 1)	" position at start of line (1st col)
    search( patternFuncStart, 'ce' )	" position at function_(_

    if s:isRCommentOrString(line("."), col(".")) 
      call setpos('.', curpos_save) 
      return false 
    endif

    " jump to matching ')', skipping comments / strings
    call searchpair('(','',')', 'W', 's:isRCommentOrString(line("."), col("."))')

    " check if next char == {
    call search('\S') 
    let nextchar = getline('.')[col('.')-1]	" get char under cursor
    while (nextchar ==# '#')	" skip comment. search the next line.
	  call search('^\s*\zs\S')
	  let nextchar = getline('.')[col('.')-1]
    endwhile
    " If yes, success! Else, too bad
    call setpos('.', curpos_save) 
    return nextchar ==# '{'
  else
    call setpos('.', curpos_save) 
    return false   
  endif
endfunction

" to support nested functions ended on the same line, 
" may need function that returns int instead of bool.

function! s:isEndOfFunc(lnum)
" return true if line lnum contains ending brace } to function(){..._}_
" TODO [2019-12-11] 
  let thisline = getline(a:lnum)
  " get number of '}'s

endfunction


" Fold Exprs and Text {{{1 
" [TODO] test


function! RscriptFoldExpr()
  if s:isHeader(v:lnum)
    if g:Rscript_fold_style = 'nested'
      return '>' . s:countHashes(v:lnum)
    else
      return '>1'
    endif
  elseif s:isEndOfFunc(v:lnum) 
    if s:isStartOfFunc(v:lnum)	
      " function starts and ends on the same line
      return '='
    else 
      return 's1'
    endif
  elseif s:isStartOfFunc(v:lnum)
    return 'a1'
  endif
endfunction

" TODO [2019-12-11]: update fold text
function! RscriptFoldText()
    let hashCount = s:countHashes(v:foldstart)
    let maintext = getline(v:foldstart)
    let maintext = substitute(maintext, '\v^\s*\#+\s+', '', '') 
    let maintext = substitute(maintext, '\v\s*\-{4,}$', '', '') 
    let foldsize = (v:foldend - v:foldstart)
    return '+' . repeat('--', hashCount) . ' ' . maintext . ' (' . foldsize . ' lines) ' 
endfunction

" API for toggling between stacked and nested header folds {{{1
" Adapted from markdown folding expressions repo

if !exists('g:Rscript_fold_style')
  let g:Rscript_fold_style = 'stacked'
endif

function! ToggleRscriptFoldStyle()
  if g:Rscript_fold_style = 'stacked'
    let g:Rscript_fold_style = 'nested'
  else 
    let g:Rscript_fold_style = 'stacked'
  endif
endfunction

command! -buffer FoldToggle call ToggleRscriptFoldStyle()

" Teardown {{{1
" Taken from markdown folding expressions repo
if !exists("b:undo_ftplugin") 
  let b:undo_ftplugin = ''
else
  let b:undo_ftplugin .= '|' 
endif

let b:undo_ftplugin .= '
  \   setlocal foldmethod< foldtext< foldexpr<
  \ | delcommand FoldToggle
  \ '

" vim: set fdm=marker:
