" customize the pairlist for tex files
" for use with .vim/plugin/pairspace.vim

let b:pairlist = deepcopy(g:pairlist) 
" '(','[','{' from pairspace_all.vim

let b:pairlist += [
  \ ['$', '$'],
  \ ['\[', '\]'],
  \ ['\{', '\}'],
  \]

" (see also pairspace_all.vim in .vim/after/plugin)


" Teardown
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
else
  let b:undo_ftplugin .= '| '
endif

let b:undo_ftplugin .= 'unlet b:pairlist'
