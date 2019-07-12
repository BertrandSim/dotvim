setlocal foldmethod=expr
" setlocal foldexpr=StackedRscriptFoldExpr(v:lnum)  " included in API below
setlocal foldtext=RscriptFoldText()

" Fold Exprs and Text {{{1 
" [TODO] folding R functions

function! StackedRscriptFoldExpr()
    let thisline = getline(v:lnum)

    " fold lines starting with #'s and ending with ----
    if thisline =~ '\v^\s*\#+\s+.{-,}\-{4,}$'  
        return '>1'
    else 
        return '='
    endif
endfunction

function! NestedRscriptFoldExpr()
    let thisline = getline(v:lnum)

    " fold lines starting with #'s and ending with ----
    if thisline =~ '\v^\s*\#+\s+.{-,}\-{4,}$'  
        let hashCount = s:CountHashes(v:lnum)
        if hashCount > 0
            return '>' . hashCount
        else
            return '='
        endif

    " " fold functions with multiple lines
    " elseif thisline =~ '[^#].*function(.*)\s*{'
    "     return 'a1'
    " 
    " " end the fold for end of functions
    " elseif thisline =~ '\v(^\}|[^#].*\})' "starts with }, or contains } not in a comment
    "     "cursor(, )
    "     if getline(searchpair('{', '', '}', 'bW')) =~ '[^#].*function(.*)\s*{'
    "         return 's1'
    "     else
    "         return '='
    "     endif
    else 
        return '='
    endif
endfunction

function! RscriptFoldText()
    let hashCount = s:CountHashes(v:foldstart)
    let maintext = getline(v:foldstart)
    let maintext = substitute(maintext, '\v^\s*\#+\s+', '', '') 
    let maintext = substitute(maintext, '\v\s*\-{4,}$', '', '') 
    let foldsize = (v:foldend - v:foldstart)
    return '+' . repeat('--', hashCount) . ' ' . maintext . ' (' . foldsize . ' lines) ' 
endfunction

" Helper Functions {{{1

function! s:CountHashes(lnum)
    let text = getline(a:lnum)
    return len(matchstr(text, '^\s*\zs#\{1,6}\ze'))
endfunction

" API and Teardown sections taken from markdown folding expressions repo
" API for toggling between stacked and nested folds {{{1

if !exists('g:Rscript_fold_style')
  let g:Rscript_fold_style = 'stacked'
endif

let &l:foldexpr =
  \ g:Rscript_fold_style ==# 'nested'
  \ ? 'NestedRscriptFoldExpr()'
  \ : 'StackedRscriptFoldExpr()'

function! ToggleRscriptFoldexpr()
  if &l:foldexpr ==# 'StackedRscriptFoldExpr()'
    setlocal foldexpr=NestedRscriptFoldExpr()
  else
    setlocal foldexpr=StackedRscriptFoldExpr()
  endif
endfunction

command! -buffer FoldToggle call ToggleRscriptFoldexpr()

" Teardown {{{1
" delete :FoldToggle command 
if !exists("b:undo_ftplugin") | let b:undo_ftplugin = '' | endif
let b:undo_ftplugin .= '
  \ | setlocal foldmethod< foldtext< foldexpr<
  \ | delcommand FoldToggle
  \ '

" vim: set fdm=marker:
