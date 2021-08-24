" define b:match_* for matchup

" wanted to use matchup for matching of [[...]],
" but it interfered with other [...] and other [[...]]'s
" Have submitted an issue.
" For now, this will not be loaded
finish

" setup
if !exists('b:match_words')
  let b:match_words = ''
  let b:match_words_old = b:match_words " save and restore
elseif b:match_words !~ '^\s*$'  " if not blank
  let b:match_words_old = b:match_words " to save and restore
  let b:match_words .= ','
endif


" add match for double brackets [[.]]
let b:match_words .= '\V[[:]]'

" trial: overwrite match for single brackets [.]
" via negative lookahead/lookbehind for single '['s
let b:match_words .= ',' .. '\V[\@<![[\@!:]'
setlocal mps-=[:]


" Teardown
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
else
  let b:undo_ftplugin .= '| '
endif
" remove match for double brackets
" let b:undo_ftplugin .= 'let b:match_words = substitute(b:match_words, ''\\V\[\[:\]\]'', "", "")'
let b:undo_ftplugin .= 'let b:match_words = b:match_words_old'
let b:undo_ftplugin .= '| setlocal mps<'

