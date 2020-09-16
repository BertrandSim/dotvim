" Vim custom indent file for R
" builds on the system vim indent R file by Jakson Alves de Aquino 

if exists("b:did_indent_addon") | finish | endif 
let b:did_indent_addon = 1

setlocal indentexpr=GetRIndentCustom()

" Main Indent Expression {{{

function! GetRIndentCustom()
" overwrites the default indent function
" for specific cases
" falls back to default GetRIndent() for other cases

  let clnum = line(".")    " current line
  let cline = getline(clnum)

  let plnum = s:Get_prev_line(clnum)
  if plnum == 0 | return 0 | endif
  let pline = getline(plnum) " previous non-blank line
  let pline = SanitizeRLine(pline)


  " (first, check it's not a comment or string)
  if !s:isRCommentOrString(clnum)

    " if line starts with ')', find matching '('.
    " if matching line ends with '( <some_text> $', place it right next to matching '('
    " else, matching line ends with '($'. Follow the indent of matching line.
    " if matching '(' not found, fallback to default indent expr.
    " Similarly for '}' and '{'

    if cline =~# '^\s*)'		
      let out = s:match_opening_indent(clnum, '(', ')')
      if out != -1 | return out | endif
    elseif cline =~# '^\s*}'		
      let out = s:match_opening_indent(clnum, '{', '}')
      if out != -1 | return out | endif
    endif


    " if previous line ends with '(' or '{', 
    " and current line does NOT start with ')' or '}', (guaranteed from this point)
    " increase current line's indent by 1.

    if pline =~ '\v[\(\{]$'
      return indent(plnum) + shiftwidth()
    endif

  endif


  " use Vim's builtin indent-expr
  return GetRIndent()

endfunction

" }}}
" Helpers {{{

" return a suitable indent for line lnum that starts with a close_delim
" eg. open_delim == '(', close_delim == ')'
"     if a line starts with ')', return indent based on the line containing the matching '('.
function! s:match_opening_indent(lnum, open_delim, close_delim)

  " place cursor on ')'
  call search('\%' . a:lnum . 'l' . a:close_delim)

  " get col of matching '('
  let [op_lnum, op_col] = 	
    \searchpairpos(a:open_delim, '', a:close_delim, 'bnW', 
    \  's:isRCommentOrString()')	"skip comments or strings when finding matching '('

  if [op_lnum, op_col] == [0,0] 
  " if not found
    return -1
  endif

  let line = getline(op_lnum)
  let line = s:Sanitize_comm_and_trail(line)
  if line[op_col-1: ] =~ a:open_delim.'$'
    " if matching line ends with '($'. Follow the indent of matching line
    return indent(op_lnum)
  else
    " else, matching line ends with '( <some_text> $', place it right next to matching '('
    return op_col
  endif
endfunction


" Get previous relevant line. Search back until getting a line that isn't
" comment or blank
" copied from vim81/indent/r.vim
function s:Get_prev_line(lineno)
  let lnum = a:lineno - 1
  let data = getline( lnum )
  while lnum > 0 && (data =~ '^\s*#' || data =~ '^\s*$')
    let lnum = lnum - 1
    let data = getline( lnum )
  endwhile
  return lnum
endfunction


" remove comments and trailing spaces from line
" taken from SanitizeRLine in vim81/indent/r.vim
function s:Sanitize_comm_and_trail(line)
  let newline = substitute(a:line, '#.*', "", "")
  let newline = substitute(newline, '\s*$', "", "")
  return newline
endfunction

" check if (lnum, cum) is displayed as a comment or string in R
" requires two args: (lnum, cnum). Defaults to line/col of cursor if omitted
function! s:isRCommentOrString(...)
  if a:0 == 0
    let lnum = line(".")
    let cnum = col(".")
  elseif a:0 == 1
    let lnum = a:1
    let cnum = col(".")
  else " if a:0 == 2
    let lnum = a:1
    let cnum = a:2
  endif
  return synIDattr(synID(lnum, cnum, 0), "name") =~? 'rComment\|rString'
endfunction

" }}}
" Teardown {{{

let b:undo_indent = get(b:, 'undo_indent', '')
if (b:undo_indent != '') | let b:undo_indent .= ' | ' | endif
let b:undo_indent .= 'unlet b:did_indent_addon'

" }}}
