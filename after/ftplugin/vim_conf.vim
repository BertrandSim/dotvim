" don't autowrap comments onto newline; don't autoinsert comment leader when using o or O.
setlocal formatoptions-=c formatoptions-=o

" single shiftwidth indent for continuation line that starts with '\'
let s:shiftwidth_ =  has('patch-7.3.694') ? shiftwidth() : &sw == 0 ? &ts : &sw
let g:vim_indent_cont = s:shiftwidth_

" Use only () for autopairs plugin 
if exists('g:AutoPairsLoaded') && g:AutoPairsLoaded == 1
  let b:AutoPairs = {'(':')'}
endif

" Teardown
if !exists("b:undo_ftplugin") | let b:undo_ftplugin = '' | endif
let b:undo_ftplugin .= '|setlocal fo<'
let b:undo_ftplugin .= '|unlet b:AutoPairs'