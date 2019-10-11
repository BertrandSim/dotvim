" custom compound recipes
"   all buns [j]
"   all brackets [o]
"   all quotes [u]

" custom textobjects
"   ij, aj; io, ao; iu, au; as above
"   iq, aq; [q]uery

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)


" compound recipes {{{
" these are added to g:sandwich#recipes

let s:group_recipes  = []

  " 'ALL recipes' query 
  " sdj, srj to delete, replace any pairs
  " replaces sdb, srb
  " remove 'kind': 'auto' to prevent recursion
let s:group_recipes += [
  \   {
  \     'external': ["\<Plug>(textobj-sandwich-auto-i)", "\<Plug>(textobj-sandwich-auto-a)"],
  \     'kind'    : ['delete', 'replace', 'query'],
  \     'noremap' : 0,
  \     'input'   : ['j'],
  \   }
  \ ]

  " remove 'kind': 'auto' as their simple recipes are already included in 'auto'
let s:group_recipes += [
  \   {
  \     'external': ["\<Plug>(textobj-sandwich-bracket-i)", "\<Plug>(textobj-sandwich-bracket-a)"],
  \     'kind'    : ['delete', 'replace', 'query'],
  \     'noremap' : 0,
  \     'input'   : ['o'],
  \   },
  \   {
  \     'external': ["\<Plug>(textobj-sandwich-quote-i)", "\<Plug>(textobj-sandwich-quote-a)"],
  \     'kind'    : ['delete', 'replace', 'query'],
  \     'noremap' : 0,
  \     'input'   : ['u'],
  \   },
  \ ]

call extend(g:sandwich#recipes, s:group_recipes)

" }}}

" helpers {{{
function! s:has_item_list(list, item)
  " check if an item is in a list
  return (index(a:list, a:item) != -1) ? 1 : 0
endfunction

" }}}

" build compound recipes from default recipes {{{
let s:sandwich_with_buns = filter(copy(g:sandwich#recipes), 'has_key(v:val, "buns")')

  " 'all brackets'
let s:bracket_buns = [
  \   ['(',')'],
  \   ['[',']'],
  \   ['{','}'],
  \   ['<','>'],
  \ ]
let s:bracket_recipes = filter(copy(s:sandwich_with_buns),
  \ 's:has_item_list(s:bracket_buns, v:val["buns"])' )

  " 'all quotes'
let s:quote_buns = [
  \   ['"','"'],
  \   ["'","'"],
  \   ['`','`'],
  \ ]
let s:quote_recipes = filter(copy(s:sandwich_with_buns),
  \ 's:has_item_list(s:quote_buns, v:val["buns"])' )


let g:sandwich_bracket_recipes = deepcopy(s:bracket_recipes)
let g:sandwich_quote_recipes   = deepcopy(s:quote_recipes)

" no need to add these to g:sandwich#recipes :)

" }}}

" key mappings; textobjs {{{
xnoremap <silent><expr> <Plug>(textobj-sandwich-bracket-i) textobj#sandwich#auto('x', 'i', {'synchro': 0}, g:sandwich_bracket_recipes)
xnoremap <silent><expr> <Plug>(textobj-sandwich-bracket-a) textobj#sandwich#auto('x', 'a', {'synchro': 0}, g:sandwich_bracket_recipes)
xnoremap <silent><expr> <Plug>(textobj-sandwich-quote-i) textobj#sandwich#auto('x', 'i', {'synchro': 0}, g:sandwich_quote_recipes)
xnoremap <silent><expr> <Plug>(textobj-sandwich-quote-a) textobj#sandwich#auto('x', 'a', {'synchro': 0}, g:sandwich_quote_recipes)

onoremap <silent><expr> <Plug>(textobj-sandwich-bracket-i) textobj#sandwich#auto('o', 'i', {'synchro': 0}, g:sandwich_bracket_recipes)
onoremap <silent><expr> <Plug>(textobj-sandwich-bracket-a) textobj#sandwich#auto('o', 'a', {'synchro': 0}, g:sandwich_bracket_recipes)
onoremap <silent><expr> <Plug>(textobj-sandwich-quote-i) textobj#sandwich#auto('o', 'i', {'synchro': 0}, g:sandwich_quote_recipes)
onoremap <silent><expr> <Plug>(textobj-sandwich-quote-a) textobj#sandwich#auto('o', 'a', {'synchro': 0}, g:sandwich_quote_recipes)

xmap <silent> ij <Plug>(textobj-sandwich-auto-i)
xmap <silent> aj <Plug>(textobj-sandwich-auto-a)
xmap <silent> io <Plug>(textobj-sandwich-bracket-i)
xmap <silent> ao <Plug>(textobj-sandwich-bracket-a)
xmap <silent> iu <Plug>(textobj-sandwich-quote-i)
xmap <silent> au <Plug>(textobj-sandwich-quote-a)

omap <silent> ij <Plug>(textobj-sandwich-auto-i)
omap <silent> aj <Plug>(textobj-sandwich-auto-a)
omap <silent> io <Plug>(textobj-sandwich-bracket-i)
omap <silent> ao <Plug>(textobj-sandwich-bracket-a)
omap <silent> iu <Plug>(textobj-sandwich-quote-i)
omap <silent> au <Plug>(textobj-sandwich-quote-a)

" query
xnoremap <silent><expr> iq textobj#sandwich#query('x', 'i')
xnoremap <silent><expr> aq textobj#sandwich#query('x', 'a')
onoremap <silent><expr> iq textobj#sandwich#query('o', 'i')
onoremap <silent><expr> aq textobj#sandwich#query('o', 'a')

" }}}

" vim: set fdm=marker:
