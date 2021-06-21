" quick comment {{{1
nnoremap <silent> <Plug>(AddComment) :<C-U>set opfunc=commentor#AddCommentOp<CR>g@
nnoremap <silent> <Plug>(RmComment) :<C-U>set opfunc=commentor#RemoveCommentOp<CR>g@
nnoremap <silent> <Plug>(AddBlockComment) :<C-U>set opfunc=commentor#AddBlockCommentOp<CR>g@
" nnoremap <silent> <Plug>(RmBlockComment) :<C-U>set opfunc=commentor#RemoveCommentOp<CR>g@
vnoremap <silent> <Plug>(VAddComment) :<C-U>call commentor#AddCommentOp(visualmode())<CR>
vnoremap <silent> <Plug>(VRmComment) :<C-U>call commentor#RemoveCommentOp(visualmode())<CR>
vnoremap <silent> <Plug>(VAddBlockComment) :<C-U>call commentor#AddBlockCommentOp(visualmode())<CR>
" vnoremap <silent> <Plug>(VRmBlockComment) :<C-U>call commentor#RemoveCommentOp(visualmode())<CR>

nnoremap <silent> <Plug>(RmBlockComment) :<C-u>call commentor#RemoveBlockComment()<CR>
vnoremap <silent> <Plug>(VRmBlockComment) :<C-u>call commentor#RemoveBlockComment()<CR>


" comment and copy {{{1
nnoremap <silent> <Plug>(ComACop)   :<C-U>call commentor#ComACop(0)<CR>
nnoremap <silent> <Plug>(ComACopA)  :<C-U>call commentor#ComACop(1)<CR>
vnoremap <silent> <Plug>(VComACop)  :<C-U>call commentor#VComACop(0)<CR>
vnoremap <silent> <Plug>(VComACopA) :<C-U>call commentor#VComACop(1)<CR>

