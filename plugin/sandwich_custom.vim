
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

" 'ALL recipes' query 
" sdj, srj to delete, replace any pairs
" replaces sdb, srb
" removed 'kind': 'auto' to prevent recursion
let s:recipe_auto = [
      \   {
      \     'external': ["\<Plug>(textobj-sandwich-auto-i)", "\<Plug>(textobj-sandwich-auto-a)"],
      \     'kind'    : ['delete', 'replace', 'query'],
      \     'noremap' : 0,
      \     'input'   : ['j'],
      \   }
      \ ]


" 'all brackets' TODO [2019-10-07] 

" 'all quotes' TODO [2019-10-07]



call sandwich#util#addlocal(s:recipe_auto)
