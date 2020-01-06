" custom tex recipes / tex surroundings.
" Recipes adapted from vim-sandwich/macros/sandwich/ftplugin/tex.vim
" compound recipes for 
"   commands [c],
"   tex environments [e]
"   quotes [o, lq], 
"   math environments $,$$,\(,\[ [$],
"   math delims [d, dl].
" for tex delims [] and {}, see bracket recipes in .vim/plugin/sandwich_custom.vim

" custom textobjects
"   latex quote text-object [io, ao] 
" for ic, ac; ic, ac; i$, a$; id, ad; see vimtex


if !exists("g:loaded_sandwich") | finish | endif

scriptencoding utf-8


" compound recipes {{{ 

if !exists('s:local_recipes')
  let s:local_recipes = [
        \   {
        \     '__filetype__': 'tex',
        \     'buns'    : 'sandwich#filetype#tex#CmdInput()',
        \     'kind'    : ['add', 'replace'],
        \     'action'  : ['add'],
        \     'listexpr': 1,
        \     'nesting' : 1,
        \     'input'   : ['c'],
        \     'indentkeys-' : '{,},0{,0}',
        \   },
        \   {
        \     '__filetype__': 'tex',
        \     'buns'    : 'sandwich#filetype#tex#EnvInput()',
        \     'kind'    : ['add', 'replace'],
        \     'action'  : ['add'],
        \     'listexpr': 1,
        \     'nesting' : 1,
        \     'linewise' : 1,
        \     'input'   : ['e'],
        \     'indentkeys-' : '{,},0{,0}',
        \     'autoindent' : 0,
        \   },
        \   {
        \     '__filetype__': 'tex',
        \     'buns'    : ['\\\a\+\*\?{', '}'],
        \     'kind'    : ['delete', 'replace', 'auto', 'query'],
        \     'regex'   : 1,
        \     'nesting' : 1,
        \     'input'   : ['c'],
        \     'indentkeys-' : '{,},0{,0}',
        \   },
        \   {
        \     '__filetype__': 'tex',
        \     'buns'    : ['\\begin{[^}]*}\%(\[.*\]\)\?', '\\end{[^}]*}'],
        \     'kind'    : ['delete', 'replace', 'auto', 'query'],
        \     'regex'   : 1,
        \     'nesting' : 1,
        \     'linewise' : 1,
        \     'input'   : ['e'],
        \     'indentkeys-' : '{,},0{,0}',
        \     'autoindent' : 0,
        \   },
	\ ]

  " compound recipes for quotes [o], math envs [$], and math delims [d]
  " remove 'kind': 'auto' as their simple recipes are already included in 'auto'
  " quote tex recipe overwrites global quote recipe, 
  "    as it is added to the back of the list of recipes
  "   (#addlocal vs #insertlocal)
  let s:local_recipes += [
	\   {
	\     '__filetype__': 'tex',
	\     'external': ["\<Plug>(textobj-sandwich-tex-quote-i)", "\<Plug>(textobj-sandwich-tex-quote-a)"],
	\     'kind'    : ['delete', 'replace', 'query'],
	\     'noremap' : 0,
	\     'input'   : ['o', 'lq'],
	\   },
	\   {
	\     '__filetype__': 'tex',
	\     'external': ["\<Plug>(textobj-sandwich-tex-env-math-i)", "\<Plug>(textobj-sandwich-tex-env-math-a)"],
	\     'kind'    : ['delete', 'replace', 'query'],
	\     'noremap' : 0,
	\     'input'   : ['$'],
	\   },
	\   {
	\     '__filetype__': 'tex',
	\     'external': ["\<Plug>(textobj-sandwich-tex-delim-math-i)", "\<Plug>(textobj-sandwich-tex-delim-math-a)"],
	\     'kind'    : ['delete', 'replace', 'query'],
	\     'noremap' : 0,
	\     'input'   : ['d', 'dl'],
	\   },
        \ ]
endif

call sandwich#util#addlocal(s:local_recipes)

" }}}

" build compound recipes {{{
" for quotes, math envs, and math delims

if !exists('s:quote_recipes')
  " ' ' and " " only for deletion / replacement
  let s:quote_recipes = [
        \   {'__filetype__': 'tex', 'buns': [ "`",  "'"],  'nesting': 1, 'input': [ "l'", "l`" ]},
        \   {'__filetype__': 'tex', 'buns': ["``", "''"],  'nesting': 1, 'input': [ 'l"' ]},
        \   {'__filetype__': 'tex', 'buns': ["'", "'"],    'nesting': 0, 'action': ['delete']},
        \   {'__filetype__': 'tex', 'buns': ['"', '"'],    'nesting': 0, 'action': ['delete']},
	\ ]
endif

if !exists('s:env_math_recipes')
  " note: adding 'input':'$' to $...$ will confuse the group recipe.
  " regardless, pressing '$' when adding surrounding will still result in $...$, due to literal query :D
  " thank God for His help!
  let s:env_math_recipes = [
	\   {'__filetype__': 'tex', 'buns': [ '$',  '$'],  'nesting': 0, 'input': [ ]},
        \   {'__filetype__': 'tex', 'buns': ['$$', '$$'],  'nesting': 0, 'input': [ '2$' ]},
        \   {'__filetype__': 'tex', 'buns': ['\(', '\)'],  'nesting': 1, 'input': [ '\(', '\)' ], 'indentkeys-': '{,},0{,0}'},
        \   {'__filetype__': 'tex', 'buns': ['\[', '\]'],  'nesting': 1, 'input': [ 'dm', '\[', '\]' ], 'indentkeys-': '{,},0{,0}'},
	\ ]
endif

if !exists('s:delim_math_recipes')
  let s:delim_math_recipes = [
        \   {'__filetype__': 'tex', 'buns': [ '(',  ')'],  'nesting': 1, 'input': [  '(',  ')' ], 'indentkeys-': '(,)'},
        \   {'__filetype__': 'tex', 'buns': [ '[',  ']'],  'nesting': 1, 'input': [  '[',  ']' ], 'indentkeys-': '[,]'},
        \   {'__filetype__': 'tex', 'buns': ['\{', '\}'],  'nesting': 1, 'input': [ '\{', '\}' ], 'indentkeys-': '{,},0{,0}'},
        \   {'__filetype__': 'tex', 'buns': ['\lvert'  , '\rvert'  ], 'nesting': 1, 'input': [  '|' ]},
        \   {'__filetype__': 'tex', 'buns': ['\lVert'  , '\rVert'  ], 'nesting': 1, 'input': [ '2|' ]},
        \   {'__filetype__': 'tex', 'buns': ['\langle' , '\rangle' ], 'nesting': 1, 'input': [ '<', '>' ]},
        \   {'__filetype__': 'tex', 'buns': ['\lfloor' , '\rfloor' ], 'nesting': 1, 'input': [ 'lf' ]},
        \   {'__filetype__': 'tex', 'buns': ['\lceil'  , '\rceil'  ], 'nesting': 1, 'input': [ 'lc' ]},
	\ ]
endif


let b:sandwich_tex_quote_recipes      = deepcopy(s:quote_recipes)
let b:sandwich_tex_env_math_recipes   = deepcopy(s:env_math_recipes)
let b:sandwich_tex_delim_math_recipes = deepcopy(s:delim_math_recipes)
call sandwich#util#addlocal(b:sandwich_tex_quote_recipes)
call sandwich#util#addlocal(b:sandwich_tex_env_math_recipes)
call sandwich#util#addlocal(b:sandwich_tex_delim_math_recipes)

xnoremap <silent><expr> <Plug>(textobj-sandwich-tex-quote-i) textobj#sandwich#auto('x', 'i', {'synchro': 0}, b:sandwich_tex_quote_recipes)
xnoremap <silent><expr> <Plug>(textobj-sandwich-tex-quote-a) textobj#sandwich#auto('x', 'a', {'synchro': 0}, b:sandwich_tex_quote_recipes)
xnoremap <silent><expr> <Plug>(textobj-sandwich-tex-env-math-i) textobj#sandwich#auto('x', 'i', {'synchro': 0}, b:sandwich_tex_env_math_recipes)
xnoremap <silent><expr> <Plug>(textobj-sandwich-tex-env-math-a) textobj#sandwich#auto('x', 'a', {'synchro': 0}, b:sandwich_tex_env_math_recipes)
xnoremap <silent><expr> <Plug>(textobj-sandwich-tex-delim-math-i) textobj#sandwich#auto('x', 'i', {'synchro': 0}, b:sandwich_tex_delim_math_recipes)
xnoremap <silent><expr> <Plug>(textobj-sandwich-tex-delim-math-a) textobj#sandwich#auto('x', 'a', {'synchro': 0}, b:sandwich_tex_delim_math_recipes)

" }}}

" textobjects {{{

xmap <silent><buffer> io <Plug>(textobj-sandwich-tex-quote-i)
xmap <silent><buffer> ao <Plug>(textobj-sandwich-tex-quote-a)
onoremap <silent><expr><buffer> io textobj#sandwich#auto('o', 'i', {'synchro': 0}, b:sandwich_tex_quote_recipes)
onoremap <silent><expr><buffer> ao textobj#sandwich#auto('o', 'a', {'synchro': 0}, b:sandwich_tex_quote_recipes)

" }}}

" Teardown {{{

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
else
  let b:undo_ftplugin .= ' | '
endif

let b:undo_ftplugin .= 'call sandwich#util#ftrevert("tex")' 

" vim: set fdm=marker:
