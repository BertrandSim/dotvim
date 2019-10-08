" sandwich recipes for r

if !exists("g:loaded_sandwich") | finish | endif

let s:local_recipes = [
  \   {
  \     '__filetype__' : 'r',
  \     'buns'         : ['[[', ']]'],
  \     'nesting'      : 1,
  \     'input'        : ['2[', '2]'],
  \   }
  \ ]

call sandwich#util#addlocal(s:local_recipes)
