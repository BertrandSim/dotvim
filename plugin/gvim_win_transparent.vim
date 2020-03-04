" Transparency for gvim on windows os
" requires vimtweak.dll to be installed in the folder containing vim.exe
" usage:   
"   :Transparency [<n>|+<n>|-<n>]
"   repeat last command with @:

" initial checks
if has('gui_running')
  if has('win64')
    let s:path_to_vimtweak = globpath(&runtimepath, 'vimtweak64.dll')
  elseif has('win32')
    let s:path_to_vimtweak = globpath(&runtimepath, 'vimtweak32.dll')
  endif
endif

if !exists("s:path_to_vimtweak") || s:path_to_vimtweak ==# '' 
  finish
endif

" parameters
let g:transp_default  = get(g:,"transp_default",0)	" starting transparency; starts at 0 (fully opaque) by default
let g:transp_min      = get(g:,"transp_min",0)      	" min allowable transparency; fully opaque by default
let g:transp_max      = get(g:,"transp_max",220)	" max allowable transparency; a little less than 255
let g:transp_ticksize = get(g:,"transp_ticksize",20)	" if using +/- without argument, increment/decrement by this amount

" helper funcs
function s:setTransparency(num)
  let s:transp = a:num
  if (s:transp < g:transp_min) | let s:transp = g:transp_min | endif
  if (s:transp > g:transp_max) | let s:transp = g:transp_max | endif

  call libcallnr(s:path_to_vimtweak, 'SetAlpha', 255-s:transp)
  echo "Transparency" s:transp
endfunction

function s:increaseTransparency(num)
  let s:transp += a:num
  call s:setTransparency(s:transp)
endfunction

function! s:decreaseTransparency(num)
  let s:transp -= a:num
  call s:setTransparency(s:transp)
endfunction

function s:parseTransparency(...)
  " processes the :Transparency command, with 0 or 1 input args

  if !a:0
    " :Transparency without arg; print current transparency value
    echo "Transparency" s:transp
    return

  elseif a:1 ==# '+'
    " :Transparency +
    call s:increaseTransparency(g:transp_ticksize)
  elseif a:1 ==# '-'
    " :Transparency -
    call s:decreaseTransparency(g:transp_ticksize)
  elseif a:1 =~ '^+\d\+'
    " :Transparency +n
    let amount = str2nr( matchstr(a:1, '\d\+') )
    call s:increaseTransparency(amount)
  elseif a:1 =~ '^-\d\+'
    " :Transparency -n
    let amount = str2nr( matchstr(a:1, '\d\+') )
    call s:decreaseTransparency(amount)
  elseif a:1 =~ '^\d\+'
    " :Transparency n
    let amount = str2nr( matchstr(a:1, '\d\+') )
    call s:setTransparency(amount)

  else
    echoerr ":Transparency called with invalid argument(s)"
    return

  endif
endfunction

" startup
let s:transp = g:transp_default		" tracks current transparency
augroup gvim_transp
  autocmd VimEnter * silent! call s:setTransparency(s:transp)
augroup END

" enduser command
command! -nargs=? Transparency call s:parseTransparency(<f-args>)
