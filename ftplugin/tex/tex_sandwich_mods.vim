" sandwich recipes for 
" modifiers \bigl, \Bigl, \biggl, \Biggl\, \bigr, \Bigr, \biggr, \Biggr\
" option to include \left ... \right

let s:mods_recipes = []
let s:mods_recipes += [
      \   {
      \	    'buns': ['\bigl', '\bigr'],
      \	    'nesting': 1,
      \   },
      \   {
      \	    'buns': ['\Bigl', '\Bigr'],
      \	    'nesting': 1,
      \   },
      \   {
      \	    'buns': ['\biggl', '\biggr'],
      \	    'nesting': 1,
      \   },
      \   {
      \	    'buns': ['\Biggl', '\Biggr'],
      \	    'nesting': 1,
      \   },
      \ ]

if exists("b:sandwich_tex_mods_useleftright") && b:sandwich_tex_mods_useleftright
  let s:mods_recipes += [
	\   {
	\     'buns': ['\left', '\right'],
	\     'nesting': 1,
	\   },
	\ ]
endif

let b:sandwich_tex_mods_recipes = deepcopy(s:mods_recipes)

let s:local_recipes = [
      \   {
      \     '__filetype__': 'tex',
      \     'external': ["\<Plug>(textobj-sandwich-tex-mods-i)", "\<Plug>(textobj-sandwich-tex-mods-a)"],
      \     'kind'    : ['delete', 'replace', 'auto', 'query'],
      \     'noremap' : 0,
      \     'input'   : ['mo'],
      \   },
      \ ]
      " \     'indentkeys': '{,},0{,0}',
      " \     'autoindent': 0,
" TODO [2019-10-01]: revise input 

let s:local_recipes += [
      \   {
      \     '__filetype__': 'tex',
      \     'buns'    : 's:sandwich_filetype_tex_modInput()',
      \     'kind'    : ['add', 'replace'],
      \     'action'  : ['add'],
      \     'listexpr': 1,
      \     'nesting' : 1,
      \     'input'   : ['m'],
      \   }
      \ ]
      " \     'indentkeys-' : '{,},0{,0}',

call sandwich#util#addlocal(s:local_recipes)
call sandwich#util#addlocal(b:sandwich_tex_mods_recipes)


xnoremap <silent><expr> <Plug>(textobj-sandwich-tex-mods-i) textobj#sandwich#auto('x', 'i', {'synchro': 0}, b:sandwich_tex_mods_recipes)
xnoremap <silent><expr> <Plug>(textobj-sandwich-tex-mods-a) textobj#sandwich#auto('x', 'a', {'synchro': 0}, b:sandwich_tex_mods_recipes)


function! s:sandwich_filetype_tex_modInput()
  echohl MoreMsg
  let modInput = input('Modifier: ', '')
  echohl NONE
  " todo: parse modLeft, modRight
  let modLeft  = modInput
  let modRight = modInput
  
  return [printf('\%s', modLeft), print('\%s', modRight)]
endfunction



