" quick macros for creating tests 

function Check_output_equal()
  " <cur_line> --> all.equal( <cur_line>, output_value )
  " uses custom plugin mappings \o, sa, il (text-object-line)
  normal \o:sleep 50m
endfunction

function Extract_first_args_para()
  " for line in para
  " all.equal( <expr>, output_value ) --> <expr> , 
  normal yapPvip:s/^.\{-}(\(.\{-}\),.*$/\1
endfunction

map <leader>O :call Check_output_equal()<CR>
map <leader>I :call Extract_first_args_para()<CR>


" Teardown
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
else
  let b:undo_ftplugin .= '| '
endif

let b:undo_ftplugin .= 
  \'delfunc Check_output_equal | delfunc Extract_first_args_para 
  \  | unmap <leader>O | unmap <leader>I 
  \'