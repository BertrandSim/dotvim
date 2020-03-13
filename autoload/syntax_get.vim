function! syntax_get#synGroup(...)
  " returns the syntax group at the cursor's [or given] location
  " in the form [ group, translated group ]
  if !exists("*synID") | return | endif

  let l:line = a:0 ? a:1 : line('.')
  let l:col  = a:0 == 2 ? a:2 : 
             \ a:0 == 1 ?   1 : col('.')
 
  let ID = synID(l:line, l:col, 1)

  return [
    \  ID->synIDattr('name'),
    \  ID->synIDtrans()->synIDattr('name')
    \]
endfunction

function! syntax_get#synStack(...)
  " returns the stack of syntax groups at the cursor's [or given] location
  " in the form [
  "   [ inner group, translated inner group ], 
  "   [ outer group, translated outer group ],
  "   ...
  " ]
  if !exists("*synstack") | return | endif

  let l:line = a:0 ? a:1 : line('.')
  let l:col  = a:0 == 2 ? a:2 : 
             \ a:0 == 1 ?   1 : col('.')

  let IDstack = synstack(l:line, l:col)

  return IDstack->
    \reverse()->
    \map("[ 
    \  synIDattr(v:val, 'name'), 
    \  synIDtrans(v:val)->synIDattr('name') 
    \]")
endfunction
