" custom iw and iW text-objects, 
" omitting non-word/WORD characters in counts

" TODO(?) [2019-12-05]: grow visual selection

" iw inner word
function! s:iw_words_only()
  call search('\k','cW', line('.')+3 )
  " search for word ('iskeyword') character, accepting at current cursor loc,
  " search until 3 lines below.
  
  let l:new_count = 2*v:count1-1
  execute 'normal!' . 'v'. l:new_count . 'iw'
endfunction


"iW inner WORD
function! s:iW_WORDs_only()
  call search('\S','cW', line('.')+3 )
  " search for WORD (non-whitespace) character, accepting at current cursor loc,
  " search until 3 lines below.

  let l:new_count = 2*v:count1-1
  execute 'normal!' . 'v'. l:new_count . 'iW'
endfunction


" plug mappings
xnoremap <silent> <Plug>(iw-words-only) :<C-u>call <SID>iw_words_only()<CR>
xnoremap <silent> <Plug>(iW-WORDs-only) :<C-u>call <SID>iW_WORDs_only()<CR>
onoremap <silent> <Plug>(iw-words-only) :<C-u>call <SID>iw_words_only()<CR>
onoremap <silent> <Plug>(iW-WORDs-only) :<C-u>call <SID>iW_WORDs_only()<CR>
