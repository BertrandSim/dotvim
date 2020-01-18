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

if !exists("s:path_to_vimtweak") | finish | endif

" parameters
let s:transp = 0		" current transparency; starts at 0 (fully opaque)
let s:transp_min = 0      	" min allowable transparency; fully opaque
let s:transp_max = 220    	" max allowable transparency; a little less than 255
let s:transp_ticksize = 20	" if using +/- without argument, increment/decrement by this amount

" helper funcs
function s:setTransparency(num)
  let s:transp = a:num
  if (s:transp < s:transp_min) | let s:transp = s:transp_min | endif
  if (s:transp > s:transp_max) | let s:transp = s:transp_max | endif

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

function s:parseTransparency(str)
  " processes the :Transparency command, with 0 or 1 input args

  if a:str ==# ''
    " :Transparency without arg; print current transparency value
    echo "Transparency" s:transp
    return

  elseif a:str ==# '+'
    " :Transparency +
    call s:increaseTransparency(s:transp_ticksize)
  elseif a:str ==# '-'
    " :Transparency -
    call s:decreaseTransparency(s:transp_ticksize)
  elseif a:str =~ '^+\d\+'
    " :Transparency +n
    let amount = str2nr( matchstr(a:str, '\d\+') )
    call s:increaseTransparency(amount)
  elseif a:str =~ '^-\d\+'
    " :Transparency -n
    let amount = str2nr( matchstr(a:str, '\d\+') )
    call s:decreaseTransparency(amount)
  elseif a:str =~ '^\d\+'
    " :Transparency n
    let amount = str2nr( matchstr(a:str, '\d\+') )
    call s:setTransparency(amount)

  else
    echoerr ":Transparency called with invalid argument(s)"
    return

  endif
endfunction

" enduser command
command! -nargs=? Transparency call s:parseTransparency('<args>') 
