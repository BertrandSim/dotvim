" quick macros for creating tests 

function Check_output_equal()
  " <cur_line> --> all.equal( <cur_line>, output_value )
  " uses custom plugin mappings \o (Nvim-R), sa (vim-sandwich)
  normal \o:sleep 50md2WkJi,^sa$fall.equal
endfunction

function Extract_first_arg()
  " all.equal( <expr>, output_value ) --> <expr> , 
  normal! :s/^.\{-}(\(.\{-}\),.*$/\1:nohlsearch
endfunction

map <leader>O :call Check_output_equal()<CR>
map <leader>I :call Extract_first_arg()<CR>


" Teardown
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
else
  let b:undo_ftplugin .= '| '
endif

let b:undo_ftplugin .= 
  \'delfunc Check_output_equal | delfunc Extract_first_arg
  \  | unmap <leader>O | unmap <leader>I 
  \'
