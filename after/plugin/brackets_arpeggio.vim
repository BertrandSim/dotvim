" Arpeggio bracket key combis
" ---------------------------

" map key chords {{{1
" ==============
" { jk:() , df:{} , fj:[] , dj:<> , dk:"" , gk:'' , bk:`` }
"
" (see also .vim/after/ftplugin/tex/brackets_arpeggio_tex.vim for tex-specific chords)


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



" unmap auto-pairs keymappings {{{1
" ============================

" if auto-pairs is loaded,
"   remove buffer-local mappings for ()[]{}<> for Arpeggio mappings to work properly.
"   remove buffer-local mappings for <Space>, <CR>, <BS>, for SpacePair.vim mappings to work.

if !get(g:, "AutoPairsLoaded", 0) | finish | endif

au BufEnter * call s:unmapAutoPairsInsert() 

function! s:unmapAutoPairsInsert()
  " redir => insertmaps
  "   filter /\cAutoPairsInsert/ imap <buffer>
  " redir END

  for delim in ['(',')','[',']','{','}','<','>',"'",'"','`']
    exec 'silent! iunmap <buffer>' delim
  endfor

  iunmap <buffer> <Space>
  iunmap <buffer> <CR>
  iunmap <buffer> <BS>
endfunction


