
" get the chosen recipe from a list of recipes
function! textobj#sandwichext#elect(recipes)
  " mimic code from body of textobj#sandwich#auto(),
  "   until textobj.elect()
  let mode = 'n'
  let a_or_i = 'a'
  let kind = 'auto'
  let defaultopt = s:default_options(kind)
  let argopt = {}
  let opt = sandwich#opt#new(kind, defaultopt, argopt)

  let recipes_ = textobj#sandwich#recipes#new(kind, mode, a:recipes)
  call recipes_.uniq(opt)

  let g:textobj#sandwich#object = textobj#sandwich#textobj#new(
          \ kind, a_or_i, mode, 1, recipes_, opt)

  " TODO: handling of count. (currently removed as will spoil when called from external function #cycle() )
	  " \ kind, a_or_i, mode, v:count1, recipes_, opt)


    " mimic textobj#sandwich#select()
    "   until textobj.elect()
    if !exists('g:textobj#sandwich#object')
      return
    endif

    let view = winsaveview()
    let textobj = g:textobj#sandwich#object
    call textobj.initialize()
    let stimeoutlen = max([0, s:get('stimeoutlen', 500)])
    let [virtualedit, whichwrap]   = [&virtualedit, &whichwrap]
    let [&virtualedit, &whichwrap] = ['onemore', 'h,l']
    try
      let candidates = textobj.list(stimeoutlen)
      let elected = textobj.elect(candidates)
      call winrestview(view)
    finally
      let [&virtualedit, &whichwrap] = [virtualedit, whichwrap]
    endtry

  return elected
endfunction


" temporarily copied from vim-sandwich/autoload/textobj/sandwich.vim

" option "{{{
function! s:default_options(kind) abort "{{{
  return get(b:, 'textobj_sandwich_options', g:textobj#sandwich#options)[a:kind]
endfunction
"}}}

function! s:get(name, default) abort  "{{{
  return get(g:, 'textobj#sandwich#' . a:name, a:default)
endfunction
"}}}
