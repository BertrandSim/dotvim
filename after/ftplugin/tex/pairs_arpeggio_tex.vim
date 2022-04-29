" Arpeggio key chords 
" for tex-specific delimiter pairs
" ================================
" { 
"   mk : $...$ , 
"   dm : \[...\] , 
"   zf : \{...\} ,
" }
"
" (see also .vim/after/plugin/pairs_arpeggio.vim for non-tex-specific chords)

call arpeggio#load()

let snip_str_teqn = '$${1:${VISUAL}}$'
" $...$

let snip_str_deqn = 
  \'\[' ."\n".
  \"\t".  '${1:${VISUAL}}' ."\n".
  \'${2:,}\]' ."\n".
  \'$0'

" \[
"   ${1:${VISUAL}}
" ${2:,}\]
" $0

let snip_str_math_braces = '\\{${1:${VISUAL}}\\}'	
"\{...\}

Arpeggioinoremap <buffer><silent> mk <C-r>=UltiSnips#Anon(snip_str_teqn)<CR>

Arpeggioinoremap <buffer><silent> dm <C-r>=UltiSnips#Anon(snip_str_deqn)<CR>

Arpeggioinoremap <buffer><silent> zf <C-r>=UltiSnips#Anon(snip_str_math_braces)<CR>

" " before 2022-04-29, this chord was 'sdf' ...
" Arpeggioinoremap <buffer><silent> sdf <C-r>=UltiSnips#Anon(snip_str_math_braces)<CR>
" " which needed a fix to the masking of df -> {} mapping.
" inoremap <buffer><silent> <Plug>(arpeggio-default:df) <C-r>=UltiSnips#Anon( '{'.'$1'.'}' )<CR>
" inoremap <buffer><silent> <Plug>(arpeggio-default:fd) <C-r>=UltiSnips#Anon( '{'.'$1'.'}' )<CR>

" Example to show that python interpolation can even be coded inside :)
" let snip_str_eg = '\['.
"   \"\n\t". '${1:abc}'.
"   \"\n\t". '`!p if t[1] == "abc":'.
"   \"\n\t\t". 'snip.rv = "def"'.
"   \"\n". 'else:'.
"   \"\n\t\t". 'snip.rv = ""'.
"   \"\n". '`'.
"   \"\n". '\]'
"
" alternatively, one can use expand_anon (python) instead of UltiSnips#Anon (vimscript)
" see matrix snippets in tex.snippets for an example



" Teardown 

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
else
  let b:undo_ftplugin .= ' | '
endif

" TODO [2020-07-17]: update Teardown 
" Currently Arpeggioiunmap with | is not supported
" let b:undo_ftplugin .= '
"   \ Arpeggioiunmap <buffer> mk |
"   \ Arpeggioiunmap <buffer> dm |
"   \ Arpeggioiunmap <buffer> sdf |
"   \ iunmap <buffer> <Plug>(arpeggio-default:df)|
"   \ iunmap <buffer> <Plug>(arpeggio-default:fd)|
"   \'

" Neither is Arpeggioimapclear. But that may remove other Arpeggio mappings not defined in this script
" " let b:undo_ftplugin .= 'Arpeggioimapclear <buffer>'

" The workaround is to use a function
function! Arp_unmap()
  silent! Arpeggioiunmap <buffer> mk
  silent! Arpeggioiunmap <buffer> dm
  silent! Arpeggioiunmap <buffer> zf
  " " not needed since 2022-04-29, when 'sdf' was replaced with 'zf'
  " silent! Arpeggioiunmap <buffer> sdf
  " silent! iunmap <buffer> <Plug>(arpeggio-default:df)
  " silent! iunmap <buffer> <Plug>(arpeggio-default:fd)
endfunction

let b:undo_ftplugin .= 'call Arp_unmap() | '
let b:undo_ftplugin .= 'delfunc Arp_unmap'
