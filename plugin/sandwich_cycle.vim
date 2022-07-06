


" TODO: not an operator per-se (does not take in motion, but a list of recipes for now)
" TODO: general mapping that asks (queries?) for a list of recipes thereafter

nmap st <Plug>(operator-sandwich-cycle-forward)
" nmap sT <Plug>(operator-sandwich-cycle-backward)

" nnoremap <Plug>(operator-sandwich-cycle-forward)  :<C-u>call operator#sandwich#cycle()<CR>
" nnoremap <Plug>(operator-sandwich-cycle-backward) :<C-u>call operator#sandwich#cycle()<CR>

nnoremap sto :<C-u>call operator#sandwichext#cycle(g:sandwich_quote_recipes)<CR>
" nnoremap sTo 
