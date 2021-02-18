" " Use nested instead of flat folding for markdown files. (Toggle with :FoldToggle)
" setlocal foldexpr=NestedMarkdownFolds()

" don't hide latex math *d*elims
if !exists("g:tex_conceal")
  " let g:tex_conceal = 'abdmgsS'
  let g:tex_conceal = 'abmgsS'	" remove the 'd'
  " see h: g:tex_conceal as to the things each alphabet conceals
else
  let s:tex_conceal_user_defined = 1
  let g:tex_conceal_usr = g:tex_conceal
  if g:tex_conceal_usr =~# 'd'
    " let g:tex_conceal = s:tex_conceal - 'd'
    let g:tex_conceal = substitute(g:tex_conceal_usr, 'd', '', '')
  endif
endif


" Teardown
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
else
  let b:undo_ftplugin .= '| '
endif

if !exists("s:tex_conceal_user_defined")
  let b:undo_ftplugin .= 'unlet g:tex_conceal'
else
  let b:undo_ftplugin .= 'let g:tex_conceal = g:tex_conceal_usr |'
  let b:undo_ftplugin .= 'unlet g:tex_conceal_usr'
endif

