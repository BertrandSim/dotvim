" " Use nested instead of flat folding for markdown files. (Toggle with :FoldToggle)
" setlocal foldexpr=NestedMarkdownFolds()

" Teardown
" if !exists("b:undo_ftplugin") | let b:undo_ftplugin = '' | endif
" let b:undo_ftplugin .= ''
