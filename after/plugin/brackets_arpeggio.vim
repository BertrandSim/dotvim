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

  for delim in ['(',')','[',']','{','}','<','>',"'",'"','`']
    exec 'silent! iunmap <buffer>' delim
  endfor
endfunction


" map key chords {{{
" ==================
" { jk:() , df:{} , fj:[] , vn:<> , dk:"" , gk:'' , bk:`` }

call arpeggio#load()

" insert mode
" -----------
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

Arpeggioinoremap dk <C-r>=UltiSnips#Anon(
  \ '"'.'$1'.'"'
  \)<CR>
Arpeggioinoremap gk <C-r>=UltiSnips#Anon(
  \ "'".'$1'."'"
  \)<CR>
Arpeggioinoremap bk <C-r>=UltiSnips#Anon(
  \ '\`'.'$1'.'\`'
  \)<CR>

" terminal mode
" -------------
Arpeggiotnoremap jk ()<Left>
Arpeggiotnoremap df {}<Left>
Arpeggiotnoremap fj []<Left>
Arpeggiotnoremap vn <><Left>
Arpeggiotnoremap dk ""<Left>
Arpeggiotnoremap gk ''<Left>
Arpeggiotnoremap bk ``<Left>

