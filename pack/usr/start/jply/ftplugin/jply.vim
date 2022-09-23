" jianpu (.jply) | lilypond (stdin) -> pdf
" that is, no intermediate .ly file is produced
if has('win32')
  let &l:makeprg = 
    \ 'python -m jianpu-ly.py < % \| 
    \  lilypond --output=%< -'
endif

" " jianpu (.jply) -> lilypond (.ly) -> score (.pdf)
" " FIXME
" if has('win32')
"   let &l:makeprg = 
"     \ 'python -m jianpu-ly.py < % > %<.ly &&
"     \  lilypond %<.ly'
" endif
