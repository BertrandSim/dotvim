" sandwich recipes for 
" [m]odifiers \bigl, \Bigl, \biggl, \Biggl\, \bigr, \Bigr, \biggr, \Biggr\
" option to include \left ... \right

if !exists("g:loaded_sandwich") | finish | endif
  
let s:mods_recipes = []
let s:mods_recipes += [
      \   {
      \     'buns': ['\left', '\right'],
      \     'nesting': 1,
      \   },
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


let s:local_recipes = [
      \   {
      \     '__filetype__': 'tex',
      \     'external': ["\<Plug>(textobj-sandwich-tex-mods-i)", "\<Plug>(textobj-sandwich-tex-mods-a)"],
      \     'kind'    : ['delete', 'replace', 'auto', 'query'],
      \     'noremap' : 0,
      \     'input'   : ['m'],
      \   },
      \ ]
      " \     'indentkeys': '{,},0{,0}',
      " \     'autoindent': 0,
" TODO [2019-10-01]: revise input 

let s:local_recipes += [
      \   {
      \     '__filetype__': 'tex',
      \     'buns'    : 'Sandwich_filetype_tex_modInput()',
      \     'kind'    : ['add', 'replace'],
      \     'action'  : ['add'],
      \     'listexpr': 1,
      \     'nesting' : 1,
      \     'input'   : ['m'],
      \   }
      \ ]
      " \     'indentkeys-' : '{,},0{,0}',

" TODO [2019-10-07]: lazyload / scriptlocal
function! Sandwich_filetype_tex_modInput()
  echohl MoreMsg
  let modInput = input('Modifier or number: ', '')
  echohl NONE

  " allow numeric input, corresponding to index of mods_recipes: 
  " eg. 0 -> \left...\right, 1 -> \bigl...\bigr, etc.
  if modInput =~# '^\d\+$' 
    let modNum = str2nr(modInput)
    let mods_buns = filter(copy(s:mods_recipes), 'has_key(v:val,"buns")')
    if modNum < len(mods_buns)
      return mods_buns[modNum]['buns']
    endif
  endif

  " TODO: parse modLeft, modRight
  let modLeft  = modInput
  let modRight = modInput
  
  return [printf('\%s', modLeft), printf('\%s', modRight)]
endfunction

let b:sandwich_tex_mods_recipes = deepcopy(s:mods_recipes)
call sandwich#util#addlocal(b:sandwich_tex_mods_recipes)
call sandwich#util#addlocal(s:local_recipes)


xnoremap <silent><expr> <Plug>(textobj-sandwich-tex-mods-i) textobj#sandwich#auto('x', 'i', {'synchro': 0}, b:sandwich_tex_mods_recipes)
xnoremap <silent><expr> <Plug>(textobj-sandwich-tex-mods-a) textobj#sandwich#auto('x', 'a', {'synchro': 0}, b:sandwich_tex_mods_recipes)


" Teardown
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
else
  let b:undo_ftplugin .= ' | '
endif

let b:undo_ftplugin .= 'call sandwich#util#ftrevert("tex")' 
