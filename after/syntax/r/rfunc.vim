" rFunction syntax definition
" and folding

" remove 'function' as a keyword
syn clear rType
syn keyword rType array category character complex double integer list logical matrix numeric vector data.frame

" function (<args>) {<body>}
syn match rFuncWord /function/ skipwhite nextgroup=rFuncArgs 
syn region rFuncArgs matchgroup=rParen start=/(/ end=/)/ skipwhite nextgroup=rFuncBody contained fold
syn region rFuncBody matchgroup=rBrace start=/{/ end=/}/ contained fold

hi def link rFuncWord rType
hi def link rParen Delimiter
hi def link rBrace Delimiter
