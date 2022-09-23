
" further work {{{1

  " TODO [2021-06-22]: save and restore cursor in a robust way
  " requires saving of cursor position _before_ operator is initiated.
  " and restoring of cursor _after_ operator is finished
  " (temporory ad-hoc implementation for single lines and visual selections only)
  
  " bonus: is it still dot-repeatable?

  " idea1: autocmd for custom `operatorfunc`s
  " from https://vimways.org/2019/making-things-flow/
  " and https://www.reddit.com/r/vim/comments/ekgy47/question_how_to_keep_cursor_position_on_yank/
  "
  "   function! OpfuncSteady()
  "     if !empty(&operatorfunc)
  "       call winrestview(w:opfuncview)
  "       unlet w:opfuncview
  "       noautocmd set operatorfunc=
  "     endif
  "   endfunction
  " 
  "   augroup OpfuncSteady
  "     autocmd!
  "     autocmd OptionSet operatorfunc let w:opfuncview = winsaveview()
  "     autocmd CursorMoved * call OpfuncSteady()
  "   augroup END

  " idea2: save view/cursor inside mapping; restore inside operator
  " from https://vi.stackexchange.com/questions/24850/creating-custom-text-objects-via-omap-how-to-run-functions-after-the-motion
  
  " idea3[current]: allow optional args to opfunc, and call winsaveview() inside the additional arg.

  " idea4: use neovim ext marks: drop an extmark at cursor, and restore it after the operator

  " related issue in neovim: https://github.com/neovim/neovim/issues/12374

  " TODO [2021-06-23]: consistency in implementation for RmBlockComment, ComACop
  " RmBlockComment | RemoveBlockComment should be implemented via an operator
  " ComACop should be implemented via an operator


" functions and operators for commenting regions {{{1
"   - line comments {{{2

function! commentor#AddCommentOp(type, ...)
  " first optional arg for winsaveview()

  let comleader = s:GetCommentLeader()

  " access stored cursor and window position
  if a:0 >= 1
    let saveview = a:1
  elseif exists("w:commentor_saveview")
    let saveview = w:commentor_saveview
  endif

  if a:type ==# 'char' || a:type ==# 'line' || a:type ==# 'block'
    let startline = line("'[")
    let endline   = line("']")
  else "if a:type ==# 'v' || a:type ==# 'V' || a:type ==# ''
    let startline = line("'<")
    let endline   = line("'>")
  endif

  let minindent = s:GetMinIndent( range(startline, endline) )
  let shiftwidth_ =  has('patch-7.3.694') ? shiftwidth() : &sw == 0 ? &ts : &sw
  let minsw = minindent / shiftwidth_

  execute "silent" . startline.','.endline . repeat('<', minsw)
  execute "silent" . startline.','.endline . 'normal! 0i'.comleader."\<Esc>"
  execute "silent" . startline.','.endline . repeat('>', minsw)

  " restore cursor and window position
  if exists('saveview')
    let saveview.col += strlen(comleader)
    let saveview.curswant += strlen(comleader)
    call winrestview(saveview)
    unlet saveview
  endif
  " if exists("w:commentor_saveview")
  "   unlet w:commentor_saveview
  " endif
endfunction

function! commentor#RemoveCommentOp(type, ...)
  " first optional arg for winsaveview()

  let comleader = s:GetCommentLeader()

  " access stored cursor and window position
  if a:0 >= 1
    let saveview = a:1
  elseif exists("w:commentor_saveview")
    let saveview = w:commentor_saveview
  endif
  if exists('saveview')
    let cursorline_hascomment = getline(saveview.lnum) =~ '^\s*' . comleader
  endif

  if a:type ==# 'char' || a:type ==# 'line' || a:type ==# 'block'
    let startline = line("'[")
    let endline   = line("']")
  else "if a:type ==# 'v' || a:type ==# 'V' || a:type ==# ''
    let startline = line("'<")
    let endline   = line("'>")
  endif

  call commentor#RemoveComment(startline, endline)

  " restore cursor and window position
  if exists('saveview')
    if cursorline_hascomment
      let saveview.col -= strlen(comleader)
      if saveview.col < 0 | let saveview.col = 0 | endif
      let saveview.curswant -= strlen(comleader)
      if saveview.curswant < 0 | let saveview.curswant = 0 | endif
    endif
    call winrestview(saveview)
    unlet saveview
  endif
  " if exists("w:commentor_saveview")
  "   unlet w:commentor_saveview
  " endif
endfunction

function! commentor#RemoveComment(startline, endline)
  let comleader = s:GetCommentLeader()
  silent execute a:startline . ',' a:endline . 'substitute' . '/' .
	\ '\v(^\s*)' . '\V'.escape(comleader,'\/') . '/' .
	\ '\1' . '/e'
  nohlsearch
endfunction


" }}}2

"   - block comments {{{2

function! commentor#AddBlockCommentOp(type)
  let [markstart, markend] = s:GetOpMarks(a:type)
  let [comstart, comend] = s:GetBlockCommentMarks()
  if comstart == "" && comend == "" | return | endif

  " get position / coordinates of start/end marks
  " getpos() only allows 'x, not `x
  let opstart = getpos(substitute(markstart,"`","'",""))
  let opend   = getpos(substitute(markend,  "`","'",""))

  if a:type ==# 'char' || a:type ==# 'v'
    " character wise
    exec 'normal!' . markend . 'a'.comend."\<Esc>"
    call setpos( substitute(markstart,"`","'",""), opstart)		" to recall `[ position ; setpos() only allows 'x, not `x
    exec 'normal!' . markstart .'i'.comstart."\<Esc>" . markstart
  elseif a:type ==# 'line' || a:type ==# 'V'
    " linewise
    exec 'normal!' . markend . 'o'.comend."\<Esc>"
    call setpos( markstart, opstart)
    exec 'normal!' . markstart .'O'.comstart."\<Esc>" . markstart
  endif

  " idea of the above (in visual mode):
  " if a:type ==# 'v'	" character wise
  "   exec 'normal!' . '`>'. 'a'.comend."\<Esc>" . '`<' .'i'.comstart."\<Esc>" . '`<'
  " elseif a:type ==# 'V'	" linewise
  "   exec 'normal!' . '`>'. 'o'.comend."\<Esc>" . '`<' .'O'.comstart."\<Esc>" . '`<'
  " endif
endfunction

function! commentor#RemoveBlockComment()
  let [comstart, comend] = s:GetBlockCommentMarks()
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
    exec 'normal!' . comend_len.'x'
    call cursor(startpos)
    exec 'normal!' . comstart_len.'x'

    " restore cursor position
    let curcurpos[2] -= comstart_len  " shift left
    let curcurpos[4] = 0	" remove curswant
    " echo string(curcurpos)
    call setpos('.', curcurpos)
  endif
endfunction

" }}}2

"   - helpers {{{2
function! s:GetCommentLeader()
  if exists("b:comment_leader")  " user defined
    return s:AppendSpace(b:comment_leader)
  endif

  let split_comment_str = split(&commentstring, '%s')
  if len(split_comment_str) == 1
    " if 'commentstring' xx%sxx contains no end part
    return s:AppendSpace(split_comment_str[0])
  endif

  let match_comment = matchstr(&comments, '\v(,|^):\zs.{-}\ze(,|$)')
  if match_comment != ''
    " if 'comment' contains ',:xxx,'
    return s:AppendSpace(match_comment)
  endif

  echohl WarningMsg | echo "Unable to find comment leader." | echohl None
  return ""

endfunction

function! s:GetMinIndent(range)
  let foundNonBlank = 0
  for lnum in a:range

    " find first nonblank line as a starting comparison
    if !foundNonBlank
      if !s:IsBlankLine(lnum)
	let minIndent = indent(lnum)
	let foundNonBlank = 1
      elseif lnum == a:range[-1]
	" ie. if last line and all other lines blank
	return 0
      endif

    elseif !s:IsBlankLine(lnum) && indent(lnum) < minIndent
      let minIndent = indent(lnum)

    endif

  endfor
  return minIndent
endfunction

function! s:IsBlankLine(lnum)
  return getline(a:lnum) =~ '\v^\s*$'
endfunction

function! s:GetBlockCommentMarks()

  if exists("b:block_comment_marks")
    " b:block_comment_marks should be a list containing start and end strings
    return b:block_comment_marks
  endif

  let split_comment_str = split(&commentstring, '%s')
  if len(split_comment_str) == 2
    " if 'commentstring' xx%sxx contains start and end part
    return split_comment_str
  endif

  let three_comment = matchstr(&comments, '\v(,|^)\zss[^O]{-}:.{-},m.{-}:.{-},e.{-}:.{-}\ze(,|$)')
  if three_comment != ""
    " if 'comments' contains s:xx,m:xx,e:xx
    let start_comment = matchstr(three_comment, '\v^s.{-}:\zs.{-}\ze,')
    let end_comment   = matchstr(three_comment, '\v,e.{-}:\zs.{-}\ze$')
    return [start_comment, end_comment]
  endif

  echohl WarningMsg | echo "Unable to find block comment syntax markers." | echohl None
  return ["",""]

endfunction

function! s:AppendSpace(str)
" adds a space to the back of str if there isn't one
  let len=strlen(a:str)
  let outstr = a:str

  if a:str[len-1] != ' '
    let outstr = outstr.' '
  endif
  return outstr
endfunction

function! s:GetOpMarks(type)
  " returns [start, end] `marks' of operator action
  if     a:type ==# 'char'	" character wise
	let [_start, _end] = [ "`[", "`]" ]
  elseif a:type ==# 'line'	" linewise
	let [_start, _end] = [ "'[", "']" ]
  elseif a:type ==# "v"	"	character wise
	let [_start, _end] = [ "`<", "`>" ]
  elseif a:type ==# 'V'	"	linewise
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
  normal! g@_

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

