" quick assignment __ for <-
" quick piping     >> for %>%

" in insert mode: 
" if UltiSnips loaded, use that, otherwise, map them
if !( exists('did_plugin_ultisnips') && exists('g:_uspy') )
  inoremap <buffer> __ <-
  " see also Nvim-R's R_assign.
  inoremap <buffer> >> %>%
endif

" in terminal mode, in an R term via Nvim-R
if has('terminal') 	" any other conditions to add?
  " tnoremap __ <-
  " tnoremap >> %>%

  nnoremap <buffer> <leader>rf
        \ :tnoremap __ <-<CR>
	 \:tnoremap >> %>%<CR>
	 \:call StartR("R")<CR>
  nnoremap <buffer> <leader>rq
        \ :tunmap __<CR>
         \:tunmap >><CR>
         \:call RQuit('nosave')<CR>
endif




" Teardown
if !exists("b:undo_ftplugin") | let b:undo_ftplugin = '' | endif

if !( exists('did_plugin_ultisnips') && exists('g:_uspy') )
  let b:undo_ftplugin .= '|iunmap __ |iunmap >>'
endif

" if has('terminal')
"   let b:undo_ftplugin .= '|tunmap __| tunmap >>'
" endif
