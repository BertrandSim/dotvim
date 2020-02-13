" Arpeggio bracket key combis
" ---------------------------

" As imap ()[]{}<> is written by autopairs
" remove these mappings for Arpeggio mappings below to work properly
" use autopairs plugin for <space>, <BS>, <CR>
au BufEnter * call s:unmapAutoPairsInsert()

function! s:unmapAutoPairsInsert()
  " redir => insertmaps
  "   filter /\cAutoPairsInsert/ imap <buffer>
  " redir END

  for delim in ['(',')','[',']','{','}','<','>',"'",'"']
    exec 'silent! iunmap <buffer>' delim
  endfor
endfunction


" map key chords
" { jk:() , df:{} , fj:[] , vn:<> , sk:'' , dk:"", bk:`` }

call arpeggio#load()

" Arpeggioimap jk ()<C-G>U<Left>	 " if has('patch-7.4.849')
" Arpeggioimap jk \pair\<C-r>=UltiSnips#ExpandSnippet()<CR>(<C-r>=UltiSnips#JumpForwards()<CR> 

Arpeggioinoremap () <C-r>=UltiSnips#Anon(
  \ '('.'$1'.')'
  \)<CR>
Arpeggioinoremap {} <C-r>=UltiSnips#Anon(
  \ '{'.'$1'.'}'
  \)<CR>
Arpeggioinoremap [] <C-r>=UltiSnips#Anon(
  \ '['.'$1'.']'
  \)<CR>
Arpeggioinoremap <> <C-r>=UltiSnips#Anon(
  \ '<'.'$1'.'>'
  \)<CR>

Arpeggioimap jk ()
Arpeggioimap df {}
Arpeggioimap fj []
Arpeggioimap vn <>

Arpeggioinoremap sk <C-r>=UltiSnips#Anon(
  \ "'".'$1'."'"
  \)<CR>
Arpeggioinoremap dk <C-r>=UltiSnips#Anon(
  \ '"'.'$1'.'"'
  \)<CR>
Arpeggioinoremap bk <C-r>=UltiSnips#Anon(
  \ '\`'.'$1'.'\`'
  \)<CR>


