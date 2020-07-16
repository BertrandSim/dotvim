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
" { jk:() , df:{} , fj:[] , dj:<> , dk:"" , gk:'' , bk:`` }

call arpeggio#load()

" insert mode
" -----------
Arpeggioinoremap <silent> jk <C-r>=UltiSnips#Anon(
  \ '('.'$1'.')'
  \)<CR>
Arpeggioinoremap <silent> df <C-r>=UltiSnips#Anon(
  \ '{'.'$1'.'}'
  \)<CR>
Arpeggioinoremap <silent> fj <C-r>=UltiSnips#Anon(
  \ '['.'$1'.']'
  \)<CR>
Arpeggioinoremap <silent> dj <C-r>=UltiSnips#Anon(
  \ '<'.'$1'.'>'
  \)<CR>

Arpeggioinoremap <silent> dk <C-r>=UltiSnips#Anon(
  \ '"'.'$1'.'"'
  \)<CR>
Arpeggioinoremap <silent> gk <C-r>=UltiSnips#Anon(
  \ "'".'$1'."'"
  \)<CR>
Arpeggioinoremap <silent> bk <C-r>=UltiSnips#Anon(
  \ '\`'.'$1'.'\`'
  \)<CR>

" terminal mode
" -------------
Arpeggiotnoremap jk ()<Left>
Arpeggiotnoremap df {}<Left>
Arpeggiotnoremap fj []<Left>
Arpeggiotnoremap dj <><Left>
Arpeggiotnoremap dk ""<Left>
Arpeggiotnoremap gk ''<Left>
Arpeggiotnoremap bk ``<Left>

