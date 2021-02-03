" pandoc syntax file 
" for markdown type documents
" see also vim-pandoc-syntax/syntax/pandoc.vim

" support multiline embedded HTML tags
" PR proposed on github 1/2/2021 11:56AM GMT+8
" syn match pandocHTML /<\/\?\a.\{-}>/ contains=@HTML	"original, single line html tags
syn match pandocHTML /<\/\?\a\_.\{-}>/ contains=@HTML	"modified, multiline html tags
