" foldexprs and foldtexts for .R files.
" folds (1) ## headers ---- and (2) functions(){}
" does not yet support nested functions that start (or end) on the same line. [todo]

" as at 30/4/2021, foldexpr superseded by syntax folding.
" see .vim/after/syntax/r/r_after.vim and .vim/after/ftplugin/r/conf_syn_fold.vim
  " setlocal foldmethod=expr
  " setlocal foldexpr=RscriptFoldExpr()
setlocal foldtext=RscriptFoldText()

" Helper Functions {{{1

function! s:isHeader(lnum)
  " returns 1 if line lnum starts with #'s and ends with ---- , and  0 otherwise
  let thisline = getline(a:lnum)
  return (thisline =~ '\v^\s*\#+') && (thisline =~ '\v\-{4,}$')
endfunction

function! s:countHashes(lnum)
  let thisline = getline(a:lnum)
  return len(matchstr(thisline, '^\s*\zs#\{1,9}\ze'))
endfunction

function! s:isRComment(lnum, cnum)
  return synIDattr(synID(a:lnum, a:cnum, 0), "name") =~? 'rComment'
endfunction

function! s:isRString(lnum, cnum)
  return synIDattr(synID(a:lnum, a:cnum, 0), "name") =~? 'rString'
endfunction

function! s:isRCommentOrString(lnum, cnum)
  return synIDattr(synID(a:lnum, a:cnum, 0), "name") =~? 'rComment\|rString'
endfunction

function! s:isStartOfFunc(lnum)
" returns 1 if line lnum contains \zs function ( \ze ...) { , and 0 otherwise
  let thisline = getline(a:lnum)
  let patternFuncStart = '\v(\w+\s*(\<\-|\=)\s*)?' . 'function\s*\('	
  " see textobj-rfunc.vim for details of above regex. 
  " Note that, being a single line search, 
  " \s* is used in place of \_s after <- | = .
  if thisline =~ patternFuncStart
    let curpos_save = getpos('.')
    call cursor(a:lnum, 1)	" position at start of line (1st col)
    call search( patternFuncStart, 'ce' )	" position at function_(_

    if s:isRCommentOrString(line("."), col(".")) 
      " TODO [2019-12-13]: continue search until end of line
      call setpos('.', curpos_save) | return 0 
    endif

    " jump to matching ')', skipping comments / strings
    if searchpair('(','',')', 'W', 's:isRCommentOrString(line("."), col("."))') <= 0
      call setpos('.', curpos_save) | return 0
    endif

    " check if next char == {
    if !search('\S') 
      call setpos('.', curpos_save) | return 0
    endif
    let nextchar = getline('.')[col('.')-1]	" get char under cursor
    while (nextchar ==# '#')	" skip comment. search the next line.
	  if !search('^\s*\zs\S')
	    call setpos('.', curpos_save) | return 0
	  endif
	  let nextchar = getline('.')[col('.')-1]
    endwhile
    " If yes, success! Else, too bad
    call setpos('.', curpos_save) | return nextchar ==# '{'
  else
    return 0   
  endif
endfunction

" to support nested functions ended on the same line, 
" may need function that returns int instead of bool.

function! s:isEndOfFunc(lnum)
" returns 1 if line lnum contains ending brace } to function(){..._}_ , and 0 otherwise
  let thisline = getline(a:lnum)
  let curpos_save = getpos('.')

  " get number of '}'s
  " redir => numEndBrace
  "   silent exe a:lnum.'s/' . '\V}' . '//gn'
  " redir END
  " let numEndBrace = matchstr( numEndBrace, '\v^\d+' )
  let s:EndBraces = []
  silent exe a:lnum.'s/' . '\V}' . '/\=add(s:EndBraces, submatch(0))' . '/gn'
  let s:numEndBrace = len(s:EndBraces)

  " loop over each '}', check if it is the end of function
  let j=0
  call cursor(a:lnum, 1)
  while j < s:numEndBrace
    normal! f}
    if !s:isRCommentOrString(line('.'), col('.')) &&
      \ s:isClosingBraceOfFunc(line('.'), col('.'))
      call setpos('.', curpos_save) | return 1
    endif
    let j +=1
  endwhile
  call setpos('.', curpos_save) | return 0
endfunction

function! s:isClosingBraceOfFunc(line, col)
  let cur_save = getpos('.')
  call cursor(a:line, a:col)

  " go to matching '{'
  if searchpair('{','','}', 'bW', 's:isRCommentOrString(line("."), col("."))') <= 0
    call setpos('.', cur_save) | return 0
  endif

  " check if prev char == ')'
  if !search('\S', 'bW')  
    call setpos('.', cur_save) | return 0
  endif
  let prevchar = getline('.')[col('.')-1]	" get char under cursor
  while (s:isRComment(line('.'), col('.')))	" skip comment. search the prev line.
	if !search('\S\ze\s*$', 'bW')
	  call setpos('.', cur_save) | return 0
	endif
	let prevchar = getline('.')[col('.')-1]
  endwhile

  " If yes, go to matching '('
  if prevchar ==# ')'
    if searchpair('(','',')', 'bW', 's:isRCommentOrString(line("."), col("."))') <= 0
      call setpos('.', cur_save) | return 0
    endif
    " check is prev word == 'function'
    let pos_prev_word = searchpos('\S', 'bnW')	" TODO [2019-12-13]: skip comment
    let pos_check     = searchpos('function', 'bnWe', )
    if pos_prev_word != [0,0] && 
      \pos_prev_word == pos_check
      call setpos('.', cur_save) | return 1
    else 
      call setpos('.', cur_save) | return 0
    endif
  else
    call setpos('.', cur_save) | return 0
  endif
endfunction


" Fold Exprs and Text {{{1 

function! RscriptFoldExpr()
  if s:isHeader(v:lnum)
    if g:Rscript_fold_style ==# 'nested'
      return '>' . s:countHashes(v:lnum)
    else
      return '>1'
    endif
  elseif s:isEndOfFunc(v:lnum) 
    if s:isStartOfFunc(v:lnum)	
      " function starts and ends on the same line
      return '='
    else 
      return g:Rscript_fold_style ==# 'nested' ? 's1' : '<2'
    endif
  elseif s:isStartOfFunc(v:lnum)
    return g:Rscript_fold_style ==# 'nested' ? 'a1' : '>2'
  else
    return '='
  endif
endfunction

" TODO [2019-12-11]: update fold text function()
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
  if g:Rscript_fold_style ==# 'stacked'
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
