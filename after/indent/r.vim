" Vim custom indent file for R
" builds on the system vim indent R file by Jakson Alves de Aquino 

if exists("b:did_indent_addon") | finish | endif 
let b:did_indent_addon = 1

setlocal indentexpr=GetRIndentCustom()

function! GetRIndentCustom()

  let clnum = line(".")    " current line
  let cline = getline(clnum)

  " overwrites the default indent 

  " if line contains only ')', place it next to matching '('
  " (first, check it's not a comment)
  if cline !~# '^\s*#' && 	
    \cline =~# '^\s*)\s*$'		

    " place cursor on ')'
    call search('\%'.clnum.'l)')

    " get col of matching '('
    let [op_lnum, op_col] = 	
      \searchpairpos('(','',')','bnW', 
      \  "getline('.') =~# '^\s*#'")	"skip comments when finding matching '('
    return op_col

  else 
    return GetRIndent()
  endif
endfunction

let b:undo_indent = get(b:, 'undo_indent', '')
if (b:undo_indent != '') | let b:undo_indent .= ' | ' | endif
let b:undo_indent .= 'unlet b:did_indent_addon'
