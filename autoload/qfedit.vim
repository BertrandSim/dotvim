" facilitates editing of the quickfix list
" see https://www.reddit.com/r/vim/comments/7dv9as/how_to_edit_the_vim_quickfix_list/

function! qfedit#edit()
  " let qf be editable
  if (&l:filetype ==# 'qf')
    setlocal modifiable
  endif
endfunction

function! qfedit#update()
  " update qf with edited qf list
  " and preserve editability
  if (&l:filetype ==# 'qf')
    let l:view = winsaveview()

    setlocal errorformat=%f\|%l\ col\ %c\|%m
    if getwininfo(win_getid())[0]['loclist']
      lgetbuffer
    else
      cgetbuffer
    endif

    call winrestview(l:view)
    call qfedit#edit()
  endif
endfunction

function! qfedit#stopedit()
  " stop qf editabilty
  if (&l:filetype ==# 'qf')
    setlocal nomodifiable
  endif
endfunction
