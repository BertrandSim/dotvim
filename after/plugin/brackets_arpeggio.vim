" Arpeggio bracket key combis
" ---------------------------
" { jk:() , df:{} , fj:'' , dk:"" , fv:[] }

call arpeggio#load()
" Arpeggioimap jk ()<C-G>U<Left>	 " if has('patch-7.4.849')
" Arpeggioimap jk \pair\<C-r>=UltiSnips#ExpandSnippet()<CR>(<C-r>=UltiSnips#JumpForwards()<CR> 
Arpeggioinoremap jk <C-r>=UltiSnips#Anon(
  \ '('.'$1'.')'
  \)<CR>
" below Arpeggio mapping does not work, as imap ( is written by autopairs
" similar for [], {} 
" Arpeggioinoremap () <C-r>=UltiSnips#Anon(
"   \ '('.'$1'.')'
"   \)<CR>
Arpeggioinoremap df <C-r>=UltiSnips#Anon(
  \ '{'.'$1'.'}'
  \)<CR>
Arpeggioinoremap fv <C-r>=UltiSnips#Anon(
  \ '['.'$1'.']'
  \)<CR>
Arpeggioinoremap <> <C-r>=UltiSnips#Anon(
  \ '<'.'$1'.'>'
  \)<CR>
Arpeggioinoremap fj <C-r>=UltiSnips#Anon(
  \ "'".'$1'."'"
  \)<CR>
Arpeggioinoremap dk <C-r>=UltiSnips#Anon(
  \ '"'.'$1'.'"'
  \)<CR>

