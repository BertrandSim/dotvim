" don't autowrap comments onto newline; don't autoinsert comment leader when using o or O.
setlocal formatoptions-=c formatoptions-=o

" Use only () for autopairs plugin 
if exists('g:AutoPairsLoaded') && g:AutoPairsLoaded == 1
  let b:AutoPairs = {'(':')'}
endif

" Teardown
if !exists("b:undo_ftplugin") | let b:undo_ftplugin = '' | endif
let b:undo_ftplugin .= '|setlocal fo<'
let b:undo_ftplugin .= '|unlet b:AutoPairs'
