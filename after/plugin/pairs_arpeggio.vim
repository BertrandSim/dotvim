" Arpeggio key chords 
" for brackets and pairs
" ----------------------

" map key chords {{{1
" ==============
" { jk:() , df:{} , fj:[] , dj:<> , dk:"" , gk:'' , bk:`` }
"
" (see also .vim/after/ftplugin/tex/pairs_arpeggio_tex.vim for tex-specific chords)


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

" command mode
" ------------
Arpeggiocnoremap jk ()<Left>

" terminal mode
" -------------
Arpeggiotnoremap jk ()<Left>
Arpeggiotnoremap df {}<Left>
Arpeggiotnoremap fj []<Left>
Arpeggiotnoremap dj <><Left>
Arpeggiotnoremap dk ""<Left>
Arpeggiotnoremap gk ''<Left>
Arpeggiotnoremap bk ``<Left>
