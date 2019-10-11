setlocal tabstop=8 softtabstop=0 shiftwidth=2 noexpandtab smarttab  " default tabstop, indent by 2 spaces
" setlocal tabstop=2 softtabstop=0 shiftwidth=2 expandtab nosmarttab	" tabs and indents are 2 spaces

" use forward slash '/' when expanding filepaths
setlocal shellslash

" add comment leader when pressing <CR>, allow autoformat with gq, 
" don't automatically break lines, remove comment leader when joining lines
if has('patch-7.3.550')
  autocmd Filetype r setlocal formatoptions=rqlj
else
  autocmd Filetype r setlocal formatoptions=rql
endif



" Teardown
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
else
  let b:undo_ftplugin .= ' | '
endif

let b:undo_ftplugin .= 'setlocal ts< sts< sw< et< sta<'
let b:undo_ftplugin .= ' | setlocal ssl<'
let b:undo_ftplugin .= ' | setlocal fo<'



