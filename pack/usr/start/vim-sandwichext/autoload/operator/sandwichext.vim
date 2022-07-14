
" cycle

" strategy:
"   _elect_ 'nearest' recipe 
"      (using part of existing code for textobj#sandwich#auto)
"   find its index
"   find the recipe next on the list
"   do the mapping sr{cur}{next}
function! operator#sandwichext#cycle(recipes) abort
  let s:count = v:count1
  let elected = textobj#sandwichext#elect(a:recipes)
  let recipe_cur = elected.recipe

  let index_cur = index(a:recipes, recipe_cur)
  if index_cur == -1
    echoerr 'recipe not found.'
  endif
  let index_new = (index_cur + s:count) % len(a:recipes)
  " TODO: handle negative index, and cycling backwards

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
  execute "normal \<Plug>(operator-sandwich-replace)
    \\<Plug>(operator-sandwich-release-count)
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

