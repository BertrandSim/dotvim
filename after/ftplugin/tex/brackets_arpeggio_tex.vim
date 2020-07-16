" key chords for tex-specific delimiter pairs
" ===========================================
" { 
"   mk  : $...$ , 
"   dm  : \[...\] , 
"   sdf : \{...\} ,
" }
"
" (see also .vim/after/plugin/brackets_arpeggio.vim for non-tex-specific chords)

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

Arpeggioinoremap <buffer><silent> sdf <C-r>=UltiSnips#Anon(snip_str_math_braces)<CR>

" fixes masking of df -> {} mapping.
inoremap <buffer><silent> <Plug>(arpeggio-default:df) <C-r>=UltiSnips#Anon( '{'.'$1'.'}' )<CR>
inoremap <buffer><silent> <Plug>(arpeggio-default:fd) <C-r>=UltiSnips#Anon( '{'.'$1'.'}' )<CR>

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
