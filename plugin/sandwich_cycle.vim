


" TODO: not an operator per-se (does not take in motion, but a list of recipes for now)
" TODO: general mapping that asks (queries?) for a list of recipes thereafter

nmap st <Plug>(operator-sandwich-cycle-forward)
nmap sT <Plug>(operator-sandwich-cycle-backward)

" nnoremap <Plug>(operator-sandwich-cycle-forward)  :<C-u>call operator#sandwich#cycle(v:count,  1)<CR>
" nnoremap <Plug>(operator-sandwich-cycle-backward) :<C-u>call operator#sandwich#cycle(v:count, -1)<CR>

nnoremap <silent> sto :<C-u>call operator#sandwichext#cycle(g:sandwich_quote_recipes,  1)<CR>
nnoremap <silent> sTo :<C-u>call operator#sandwichext#cycle(g:sandwich_quote_recipes, -1)<CR>
" TODO [2022-07-14]: arg for count
