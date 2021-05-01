" Code folding options, using custom syntax
" see .vim/after/syntax/r/r_after.vim

setlocal foldmethod=syntax

let g:r_syn_fold = {
  \ 'paren' : 0,
  \ 'curly' : 0,
  \ 'brace' : 0,
  \ 'section' : 1,
  \ 'funcArgs' : 1,
  \ 'funcBody' : 1,
\}

" Teardown
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
else
  let b:undo_ftplugin .= '| '
endif

let b:undo_ftplugin .= 'setlocal foldmethod<'
let b:undo_ftplugin .= ' | unlet g:r_syn_fold'
