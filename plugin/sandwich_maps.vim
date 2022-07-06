if get(g:,'loaded_sandwich_maps', 0) == 1
  finish
endif

let g:loaded_sandwich_maps = 1

" don't use default mappings
let g:sandwich_no_default_key_mappings = 1
let g:textobj_sandwich_no_default_key_mappings = 1
let g:operator_sandwich_no_default_key_mappings = 1

" insert with sa/si
nmap sa <Plug>(operator-sandwich-add)
xmap sa <Plug>(operator-sandwich-add)
omap sa <Plug>(operator-sandwich-g@)
nmap si <Plug>(operator-sandwich-add)
xmap si <Plug>(operator-sandwich-add)
omap si <Plug>(operator-sandwich-g@)

" delete with sd
nmap sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
xmap sd <Plug>(operator-sandwich-delete)

" replace with sc
nmap sc <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
xmap sc <Plug>(operator-sandwich-replace)


" use [count] sw / sW to 
" surround(-add) [count] inner word/WORD(s)
" count excludes non-word/WORD characters
nmap sw <Plug>(operator-sandwich-add)<Plug>(operator-sandwich-release-count)<Plug>(iw-words-only)
nmap sW <Plug>(operator-sandwich-add)<Plug>(operator-sandwich-release-count)<Plug>(iW-WORDs-only)

" use [count] sl to surround(-add) char
nmap sl <Plug>(operator-sandwich-add)<Plug>(operator-sandwich-release-count)l


" TODO [2020-01-02]: Exchange with se

" cycle forward / backward with sf/sF
" nmap sfo   " TODO [2020-01-02]: cycle quotes

" WIP in plugin/sandwich_cycle.vim, 
" pack/usr/start/sandwichext/autoload/textobj/sandwichext.vim, 
"                            autoload/operator/sandwichext.vim

" TODO [2020-01-02]: modify with sm
