" quick assignment __ for <-
" quick piping     >> for %>%

" in insert mode: 
" if UltiSnips loaded, use that, otherwise, map them
if !( exists('did_plugin_ultisnips') && exists('g:_uspy') )
  " inoremap <buffer> __ <-
  " " see also Nvim-R's R_assign.
  inoremap <buffer> >> %>%
endif

" in terminal mode, in an R term via Nvim-R
if has('terminal') 	" any other conditions to add?
  " tnoremap __ <-
  " tnoremap >> %>%
  " tnoremap <Del> <Right><BS>	" don't exit R console with <Del> on empty line

  nnoremap <buffer> <leader>rf 
	 \:tnoremap >> %>%<CR>
	 \:tnoremap <lt>Del> <lt>Right><lt>BS><CR>
	 \:call StartR("R")<CR>
	" \ :tnoremap __ <-<CR>
  nnoremap <buffer> <leader>rq 
         \:tunmap >><CR>
	 \:tunmap <lt>Del><CR>
         \:call RQuit('nosave')<CR>
	" \ :tunmap __<CR>
endif


" Teardown
if !( exists('did_plugin_ultisnips') && exists('g:_uspy') )

  " put these outside of if block if there are other things to undo
  if !exists('b:undo_ftplugin')
    let b:undo_ftplugin = ''
  else
    let b:undo_ftplugin .= '|'
  endif

  " let b:undo_ftplugin .= ' iunmap <buffer> __|'
  let b:undo_ftplugin .= ' iunmap <buffer> >>'

endif
