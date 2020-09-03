" Vim custom indent file for R
" builds on the system vim indent R file by Jakson Alves de Aquino 

if exists("b:did_indent_addon") | finish | endif 
let b:did_indent_addon = 1

setlocal indentexpr=GetRIndentCustom()

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



  " if previous line ends with '{', 
  " and current line does NOT start with '}',
  " increase current line's indent by 1.
  if pline =~ '{$'
    if cline =~ '^\s*}'
      return indent(plnum)
    else
      return indent(plnum) + shiftwidth()
    endif
  endif

  " if previous line ends with '('
  if pline =~ '($'
    if cline =~ '^\s*)'
      return indent(plnum)
    else
      return indent(plnum) + shiftwidth()
    endif
  endif

  " if pline ends with '( <some text>', eg. incomplete function call 'f(args, '
  " handled by GetRIndent()?


  " if line contains only ')', find matching '('.
  " if matching line is '( text, text $', place it right next to matching '('
  " else, matching line is '($'. Follow the indent of matching line
  " (first, check it's not a comment)
  if cline !~# '^\s*#' && 	
    \cline =~# '^\s*)\s*$'		

    " place cursor on ')'
    call search('\%'.clnum.'l)')

    " get col of matching '('
    let [op_lnum, op_col] = 	
      \searchpairpos('(','',')','bnW', 
      \  "getline('.') =~# '^\s*#'")	"skip comments when finding matching '('

    let line = getline(op_lnum)
    let line = s:Sanitize_comm_and_trail(line)
    if line[op_col-1: ] =~ '($'
      return indent(op_lnum)
    else
      return op_col
    endif
  endif


  " use Vim's builtin indent-expr
  return GetRIndent()

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

" Teardown
let b:undo_indent = get(b:, 'undo_indent', '')
if (b:undo_indent != '') | let b:undo_indent .= ' | ' | endif
let b:undo_indent .= 'unlet b:did_indent_addon'
