
" Modifies behavior of whitespace characters (Space, CR, BS) when used within a pair.

" Similar to the behavior of (Space, CR, BS) in (github.com/jiangmiao/auto-pairs), but without the bloat

" - specify the list of pairs with g:pairlist or b:pairlist, default [['(',')'], ['[',']'], ['{','}']]
" - supports pairs with strings of len > 1, eg. [['\{','\}']]
" - supports insert and terminal modes
" - supports buffer-local pairs (eg. for specific filetypes)



" Main ideas {{{1
" ----------

" next_is(string, pos)
" prev_is(string, pos)

" for [open, close] in g:pairlist
"   if s:prev_is(open, curpos) && s:next_is(close, curpos)
"     return keycombo_here
"   endif
" endfor
" return default_here


" Alternatively, use `search(open..'\%#'..close,'n')`


" Presets {{{1
" ----------

let g:pairlist_default = [
  \ ['(', ')'],
  \ ['[', ']'],
  \ ['{', '}'],
  \]

" inoremap <silent> <Space> <C-R>=PairSpace('i')<CR> " this works too
inoremap <expr> <Space> PairSpace('i')
inoremap <expr> <CR>    PairReturn('i')
inoremap <expr> <BS>    PairBS('i')

" cnoremaps will use getcmdpos(), which requires expressions to be used
cnoremap <expr> <BS>    PairBS('c')

" tnoremap <Space> <C-W>"=PairSpace('t')<CR> " this doesn't work
tnoremap <expr> <Space> PairSpace('t')
tnoremap <expr> <BS>    PairBS('t')


" Helpers {{{1
" -------

" return the list of pairs
" depending on whether b:pairlist, or g:pairlist exists
function! s:get_pairs() abort
  if exists('b:pairlist')
    return b:pairlist
  elseif exists('g:pairlist')
    return g:pairlist
  else
    return g:pairlist_default
endfunction


" checks if string exists to the left of pos
function! s:left_is(string, pos, mode)
  let str_len = strlen(a:string)
  let [lnum, col] = a:pos
  if a:mode ==# 'c'
    let curline = getcmdline()
  else
    let curline = getline(lnum)
  endif

  if curline[col-2-(str_len-1) : col-2] ==# a:string
    return 1
  endif
  return 0

endfunction

" checks if string exists to the right of pos
function! s:right_is(string, pos, mode)
  let str_len = strlen(a:string)
  let [lnum, col] = a:pos
  if a:mode ==# 'c'
    let curline = getcmdline()
  else
    let curline = getline(lnum)
  endif

  if curline[col-1 : col-1+(str_len-1)] ==# a:string
    return 1
  endif
  return 0

endfunction

" checks if string exists at the end of the line above pos
" currently for insert mode only
function! s:above_is(string, pos)
  let str_len = strlen(a:string)
  let [lnum, col] = a:pos
  let line = s:trim(getline(lnum - 1))
  let line_len = strlen(line)
  if line[line_len-1-(str_len-1) : line_len-1] ==# a:string
    return 1
  endif
  return 0
endfunction

" checks if string exists at the start of the line below pos
" currently for insert mode only
function! s:below_is(string, pos)
  let str_len = strlen(a:string)
  let [lnum, col] = a:pos
  let line = s:trim(getline(lnum + 1))
  let line_len = strlen(line)
  if line[0 : (str_len-1)] ==# a:string
    return 1
  endif
  return 0
endfunction

" checks if line lnum contains only whitespaces
" currently for insert mode only
function! s:line_iswhite(lnum)
  return s:trim(getline(a:lnum)) ==# '' ? 1 : 0
endfunction

" trim() for older versions of vim
" (lazy way): do nothing for earlier versions
function! s:trim(string)
  if has('patch-8.0.1630')
    return trim(a:string)
  else
    return a:string
  endif
endfunction


" returns cursor position [line, col]
function! s:get_cursor_pos(mode)
  if a:mode ==# 't'
    " (hack): for terminals, switch to terminal-normal mode to update cursor position
    " then switch back to terminal mode
    call feedkeys("\<C-\>\<C-N>i", 'nix!')
  elseif a:mode ==# 'c'
    return [1, getcmdpos()]  " the first index (row) is unused
  endif
  return getpos('.')[1:2]
endfunction


" Functions for Mappings {{{1
" ----------------------

function! PairSpace(mode)
  let curpos = s:get_cursor_pos(a:mode)
  for [open, close] in s:get_pairs()
    if s:left_is(open, curpos, a:mode) && s:right_is(close, curpos, a:mode)
      " return 'SpaceSpaceLeft'
      if a:mode ==# 'i' && has('patch-7.4.849')
	return "\<Space>\<Space>\<C-G>U\<Left>"
      else 
	return "\<Space>\<Space>\<Left>"
      endif
    endif
  endfor
  " return 'Space'
  return "\<Space>"
endfunction

function! PairReturn(mode)
  " change behavior of <CR>, currently for insert mode only
  let curpos = s:get_cursor_pos('i')
  for [open, close] in s:get_pairs()
    if s:left_is(open, curpos, a:mode) && s:right_is(close, curpos, a:mode)
      " return 'ReturnReturnUp'
      return "\<CR>\<Up>\<End>\<CR>"
    endif
  endfor
  " return 'Return'
  return "\<CR>"
endfunction

function! PairBS(mode)
  let curpos = s:get_cursor_pos(a:mode)
  for [open, close] in s:get_pairs()
    " Handle the case (|)
    if s:left_is(open, curpos, a:mode) && s:right_is(close, curpos, a:mode)
      " return 'BsDel'
      " like \<BS>\<Del>, but support pairs containing multiple characters
      return repeat("\<BS>", strlen(open)) . repeat("\<Del>", strlen(close))
    " Handle the case ( | )
    elseif s:left_is(' ', curpos, a:mode) && s:right_is(' ', curpos, a:mode)
      let [lnum, col] = curpos
      if s:left_is(open, [lnum, col-1], a:mode) && s:right_is(close, [lnum, col+1], a:mode)
	return "\<BS>\<Del>"
      endif
    " Handle the case ( \r | \r ), 
    "   for insert mode only 
    elseif a:mode ==# 'i' && 
      \ s:line_iswhite(curpos[0]) && s:above_is(open, curpos) && s:below_is(close, curpos)
      return "0\<C-D>\<BS>\<Del>"
    endif
  endfor
  " return 'Bs'
  return "\<BS>"
endfunction
