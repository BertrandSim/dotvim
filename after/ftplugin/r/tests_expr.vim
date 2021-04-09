" quick macros for creating tests 

function Check_output_equal() abort
  " <cur_line> --> all.equal( <cur_line>, output_value )

  " normal \o:sleep 50md2WkJi,sailfall.equal
  "   original ver uses custom plugin mappings 
  "   \o (Nvim-R), sa (vim-sandwich), il (vim-textobj-line)

  call SendLineToRAndInsertOutput()
  normal! 0
  sleep 50m
  normal! d2WkJi,
  normal! Iall.equal(A)
endfunction

function Extract_first_arg()
  " all.equal( <expr>, output_value ) --> <expr> , 
  normal! :s/^.\{-}(\(.\{-}\),.*$/\1:nohlsearch
endfunction

map <buffer> <leader>O :call Check_output_equal()<CR>
map <buffer> <leader>I :call Extract_first_arg()<CR>


" Teardown
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
else
  let b:undo_ftplugin .= '| '
endif

let b:undo_ftplugin .= 
  \'delfunc Check_output_equal | delfunc Extract_first_arg
  \  | unmap <buffer> <leader>O| unmap <buffer> <leader>I
  \'
