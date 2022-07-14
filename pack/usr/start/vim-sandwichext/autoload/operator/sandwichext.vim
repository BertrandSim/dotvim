
" cycle

" strategy:
"   _elect_ 'nearest' recipe 
"      (using part of existing code for textobj#sandwich#auto)
"   find its index
"   find the recipe next on the list
"   do the mapping sr{cur}{next}

function! operator#sandwichext#cycle(recipes, count, direction) abort
  " recipes is a list of recipes to cycle through
  " direction can be +1 (forward) or -1 (backward)

  let elected = textobj#sandwichext#elect(a:recipes)
  let recipe_cur = elected.recipe

  let index_cur = index(a:recipes, recipe_cur)
  if index_cur == -1
    echoerr 'recipe not found.'
  endif
  let length = len(a:recipes)
  let index_new = ((index_cur + a:direction * a:count) % length + length) % length
  let recipe_new = a:recipes[index_new]

  let input_cur = s:getinput(recipe_cur)
  let input_new = s:getinput(recipe_new)

  """ debug
  if get(g:, "sandwichext_debug")
    echo "index_cur:". index_cur
    echo "index_new:". index_new
    echo "input_cur:". input_cur
    echo "input_new:". input_new
  endif

  let kind = 'replace'
  let mode = 'n'

  " perform normal keymap sr{old}{new}
  " without passing count to the textobject
  execute "normal \<Plug>(operator-sandwich-replace)
    \\<Plug>(operator-sandwich-squash-count)
    \\<Plug>(textobj-sandwich-query-a)" 
    \. input_cur . input_new

  " call operator#sandwich#keymap(kind, mode, {}, a:recipes)  " doesn't work
  " call operator#sandwich#keymap(kind, mode)
  " call feedkeys(input_cur . input_new, 'inx')
endfunction

function! s:getinput(recipe)
  if has_key(a:recipe, 'input')
    return a:recipe.input
  elseif has_key(a:recipe, 'buns')
    return a:recipe.buns[0]
  else
    echoerr 'recipe has no ''input'' nor ''buns''!'
  endif
endfunction

