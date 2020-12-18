" functions and operators for commenting regions " {{{1
"   - line comments {{{2
function! commentor#AddCommentOp(type)
  let comleader = commentor#GetCommentLeader()

  if a:type ==# 'char' || a:type ==# 'line' || a:type ==# 'block'
	let startline = line("'[")
	let endline   = line("']")
  else "if a:type ==# 'v' || a:type ==# 'V' || a:type ==# ''
	let startline = line("'<")
	let endline   = line("'>")
  endif

  let minindent = commentor#GetMinIndent( range(startline, endline) )
  let shiftwidth_ =  has('patch-7.3.694') ? shiftwidth() : &sw == 0 ? &ts : &sw
  let minsw = minindent / shiftwidth_

  execute "silent" . startline.','.endline . repeat('<', minsw)
  execute "silent" . startline.','.endline . 'normal 0i'.comleader."\<Esc>"
  execute "silent" . startline.','.endline . repeat('>', minsw)

  nohlsearch
endfunction

function! commentor#RemoveCommentOp(type)
  if a:type ==# 'char' || a:type ==# 'line' || a:type ==# 'block'
    let startline = line("'[")
	let endline   = line("']")
  else "if a:type ==# 'v' || a:type ==# 'V' || a:type ==# ''
	let startline = line("'<")
	let endline   = line("'>")
  endif

  call commentor#RemoveComment(startline, endline)

endfunction

function! commentor#RemoveComment(startline, endline)
  let comleader = commentor#GetCommentLeader()
  execute a:startline . ',' a:endline . 'substitute' . '/' .
	\ '\v(^\s*)' . '\V'.escape(comleader,'\/') . '/' .
	\ '\1' . '/e'
  nohlsearch
endfunction

" }}}2

"   - block comments {{{2

function! commentor#AddBlockCommentOp(type)
  let [markstart, markend] = commentor#GetOpMarks(a:type)
  let [comstart, comend] = commentor#GetBlockCommentMarks()
  if comstart == "" && comend == "" | return | endif

  " get position / coordinates of start/end marks
  " getpos() only allows 'x, not `x
  let opstart = getpos(substitute(markstart,"`","'",""))
  let opend   = getpos(substitute(markend,  "`","'",""))

  if a:type ==# 'char' || a:type ==# 'v'
	" character wise
	exec 'normal' . markend . 'a'.comend."\<Esc>"
	call setpos( substitute(markstart,"`","'",""), opstart)		" to recall `[ position ; setpos() only allows 'x, not `x
	exec 'normal' . markstart .'i'.comstart."\<Esc>" . markstart
  elseif a:type ==# 'line' || a:type ==# 'V'
	" linewise
	exec 'normal' . markend . 'o'.comend."\<Esc>"
	call setpos( markstart, opstart)
	exec 'normal' . markstart .'O'.comstart."\<Esc>" . markstart
  endif

  " idea of the above (in visual mode):
  " if a:type ==# 'v'	" character wise
  "   exec 'normal' . '`>'. 'a'.comend."\<Esc>" . '`<' .'i'.comstart."\<Esc>" . '`<'
  " elseif a:type ==# 'V'	" linewise
  "   exec 'normal' . '`>'. 'o'.comend."\<Esc>" . '`<' .'O'.comstart."\<Esc>" . '`<'
  " endif
endfunction

function! commentor#RemoveBlockComment()
  let [comstart, comend] = commentor#GetBlockCommentMarks()
  let comstart_len = len(comstart)
  let comend_len   = len(comend)

  " search outward for comment markers
  " for now, cursor must NOT be on the comment markers [FIXME]
  let startpos = searchpairpos('\V'.escape(comstart,'/'), '', '\V'.escape(comend,'\'), 'bnW')
  " echo 'startpos: ' . string(startpos)
  let endpos   = searchpairpos('\V'.escape(comstart,'/'), '', '\V'.escape(comend,'\'),  'nW')
  " echo 'endpos: '   . string(endpos)

  if startpos != [0,0] && endpos != [0,0]
  " ie. block comment markers found
	let curcurpos = getcurpos()

	" remove comment markers
	call cursor(endpos)
	exec 'norm' . comend_len.'x'
	call cursor(startpos)
	exec 'norm' . comstart_len.'x'

	" restore cursor position
	let curcurpos[2] -= comstart_len  " shift left
	let curcurpos[4] = 0	" remove curswant
	" echo string(curcurpos)
	call setpos('.', curcurpos)
  endif
endfunction

" }}}2

"   - helpers {{{2
function! commentor#GetCommentLeader()
  if exists("b:comment_leader")  " user defined
	let commentstart = b:comment_leader
  elseif len(split(&commentstring, '%s')) == 1
	" if 'commentstring' xx%sxx contains no end part
	let commentstart = split(&commentstring, '%s')[0]
  elseif match(&comments, '\v(,|^):[^,:]*,')
    " if 'comment' contains ',:xxx,'
    let commentstart = matchstr(&comments, '\v(,|^):\zs[^,:]*\ze,')
  else
	echoerr "unable to find comment leader."
  endif

  let commentstart = commentor#AppendSpace( commentstart )
  return commentstart
endfunction

function! commentor#GetMinIndent(range)

  let foundNonBlank = 0

  for lnum in a:range

	" find first nonblank line as a starting comparison
    if !foundNonBlank
	  if !commentor#IsBlankLine(lnum)
		let minIndent = indent(lnum)
		let foundNonBlank = 1
	  elseif lnum == a:range[-1]
	  " ie. if last line and all other lines blank
		return 0
	  endif

	elseif !commentor#IsBlankLine(lnum) && indent(lnum) < minIndent
	  let minIndent = indent(lnum)

	endif

  endfor

  return minIndent

endfunction


function! commentor#IsBlankLine(lnum)
  return getline(a:lnum) =~ '\v^\s*$'
endfunction








function! commentor#GetBlockCommentMarks()

  if exists("b:block_comment_marks")
	" b:block_comment_marks should be a list containing start and end strings
	return b:block_comment_marks
  endif

  let split_comment_str = split(&commentstring, '%s')
  if len(split_comment_str) == 2
	" if 'commentstring' xx%sxx contains start and end part
	return split_comment_str
  endif

  echoerr "Unable to find block comment syntax markers."
  return ["",""]

endfunction


function commentor#AppendSpace(str)
" adds a space to the back of str if there isn't one
  let len=strlen(a:str)
  let outstr = a:str

  if a:str[len-1] != ' '
    let outstr = outstr.' '
  endif
  return outstr
endfunction

function! commentor#GetOpMarks(type)
  " returns [start, end] `marks' of operator action
  if     a:type ==# 'char'	" character wise
	let [_start, _end] = [ "`[", "`]" ]
  elseif a:type ==# 'line'	" linewise
	let [_start, _end] = [ "'[", "']" ]
  elseif a:type ==# "v"	" character wise
	let [_start, _end] = [ "`<", "`>" ]
  elseif a:type ==# 'V'	" linewise
	let [_start, _end] = [ "'<", "'>" ]
  endif
  return [_start, _end]
endfunction

" }}}2

" original idea:
" noremap <silent> <leader>cm 
	  " \:<C-B>silent <C-E>
	  " \s/^\s*/&<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>
	  " \:nohlsearch<CR>
" noremap <silent> <leader>cx 
	  " \:<C-B>silent <C-E>
	  " \s/\v(^\s{-})\V<C-R>=escape(b:comment_leader,'\/')<CR>/\1/e<CR>
	  " \:nohlsearch<CR>
	  
" }}}1

" functions and operators for copying and commenting lines/regions {{{1

" Comments cur line or visual selection,
" makes another copy, and
" positions cursor at the copy.

" note that in the implemenation, the line/selection is first copied, then commented.

function! commentor#ComACop(above)
" above: boolean. if true, positions copy above line, otherwise below
  let curpos_save = getcurpos()

  if a:above
    copy .
  else
    copy -
  endif

  " comment line
  set opfunc=commentor#AddCommentOp
  norm! g@_

  " restore cursor
  if !a:above
    let curpos_save[1] += 1   " adjust line (row) position
  endif
  call setpos('.', curpos_save) 
endfunction

function! commentor#VComACop(above)
" above: boolean. if true, positions copy above line/selection, otherwise below
  let curpos_save = getcurpos() 
  let numlines = line("'>") - line("'<") + 1

  if a:above
    '<,'>copy '>.
  else
    '<,'>copy '<-
  endif

  "comment
  set opfunc=commentor#AddCommentOp
  execute 'normal!' ."'<". repeat(a:above ? 'j':'k', numlines)
  execute 'normal!' . 'g@'.numlines.'_'

  " restore cursor
  if !a:above
    let curpos_save[1] += numlines   " adjust line (row) position
  endif
  call setpos('.', curpos_save) 
endfunction

