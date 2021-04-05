
" R function user text object
" requires vim-textobj-user

" TODO: use s, SID(), for some functions?

call textobj#user#plugin('rfunc', {
	  \   '-': {
	  \     'select-a-function': 'SelectRFunc',
	  \     'select-a': '<buffer> af',
	  \   },
	  \ })
	" \     'select-i-function': '<func_name>',
	" \     'select-i': '<buffer> if',


function! SelectRFunc()
  " For textobj-user
  " Selects the function on the cursor, or containing the cursor
  " Supports nested R functions: outerfunc {... innerfunc {...} <cursor> ...}

  let curpos = getpos('.')
  let searchpos = getpos('.')

  let result = SearchRFunc(searchpos, 'bcW', curpos)	" search backwards, place cursor on start of match

  while	( result[0] == -1 )
    " result[0] == -1 means found but does not contain searchpos. 
	" Continue to search as the one found may be nested in another function

	" if continue to search, search backward from start of currently found func
	let searchpos = result[1]
	let result = SearchRFunc(searchpos, 'bW', curpos)

  endwhile

  if result[0] == 0 
	" if not found, text object does not exist
	let out = 0	
  else " result[0] == 1 
	" found and contains searchpos, return it to vim-textobj-user
	let out = ['v', result[1], result[2]]	
  endif

  call setpos('.', curpos)
  return out

endfunction

function! SearchRFunc(searchpos, flags, curpos)
  " searches for an r function from searchpos, 
  " flags are used in search(). These include the search direction (foward or backward).
  " returns: 
  "   [ 1, start, end] if found and [start, end] contains curpos,
  "   [-1, start, end] if found but [start, end] does not contain curpos,
  "   0 if not found

  " TODO: separate case if nextchar != '{' ?

  let curpos_save = getpos('.')

  let patternFuncStart =
    \'\v(\a\k+\s*(\<\-|\=)\_s*)?'.
    \   'function\s*\('
    " optional: <name> <- or =
    " function(

  call setpos('.', a:searchpos)
  if !search(patternFuncStart, a:flags)	" TODO [2019-12-11]:  skip comments / strings
    call setpos('.', curpos_save)
    return 0	
  endif
  let funcstartpos = getpos('.')

  call search(patternFuncStart, 'ce')    " move to end of 'function('
  " jump to matching ')', skipping comments / strings
  call searchpair('(','',')', 'W', 's:isRCommentOrString(line("."), col("."))')

  " check if next char == {
  call search('\S') 
  let nextchar = getline('.')[col('.')-1]	" get char under cursor
  while (nextchar ==# '#')	" skip comment. search the next line.
	call search('^\s*\zs\S')
	let nextchar = getline('.')[col('.')-1]
  endwhile

  " If yes, jump to it, and add {...} to selection
  if (nextchar ==# '{')
	" jump to matching '}', skipping comments / strings
	call searchpair('{','','}', 'W', 's:isRCommentOrString(line("."), col("."))')
	let funcendpos = getpos('.')

	" check if cursor pos is within start/end of function found
	" if yes, good (return 1). Otherwise, return -1.
	if s:PosCompare(a:curpos, funcstartpos) >= 0 && 
	  \s:PosCompare(a:curpos, funcendpos)   <= 0 
	  call setpos('.', curpos_save)
	  return [ 1, funcstartpos, funcendpos]
	else 
	  call setpos('.', curpos_save)
	  return [-1, funcstartpos, funcendpos]
	endif

  else
	call setpos('.', curpos_save)
	return 0

  endif
endfunction

" helpers {{{1

function s:PosCompare(p1, p2)
  " compares if one position is later than the other
  " returns -1 ( p1 < p2 ), +1 ( p1 > p2 ), or 0 ( p1 == p2 )
  " p1 and p2 are positions, in the same format as the output for getpos()
  if     a:p1[1] < a:p2[1] || (a:p1[1] == a:p2[1] && a:p1[2] < a:p2[2]) | return -1
  elseif a:p1[1] > a:p2[1] || (a:p1[1] == a:p2[1] && a:p1[2] > a:p2[2]) | return  1
  else | return  0 | endif
endfunction


" Teardown {{{1

function! s:isRCommentOrString(lnum, cnum)
  return synIDattr(synID(a:lnum, a:cnum, 0), "name") =~? 'rComment\|rString'
endfunction

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
else
  let b:undo_ftplugin .= '| '
endif

" remove custom functions
let b:undo_ftplugin .= ' delfunc SelectRFunc|'
let b:undo_ftplugin .= ' delfunc SearchRFunc|'

" remove custom textobject
let b:undo_ftplugin .= ' ounmap <buffer> af| xunmap <buffer> af|'
let b:undo_ftplugin .= ' ounmap <Plug>(textobj-rfunc-a)| xunmap <Plug>(textobj-rfunc-a)'
