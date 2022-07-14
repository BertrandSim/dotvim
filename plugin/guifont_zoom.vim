" Plugin to adjust gui font-size for gVim on windows
" Usage:
"   Plug mappings
"     <Plug>(guifont-zoom-in)    : Increase font size
"     <Plug>(guifont-zoom-out)   : Decrease font size 
"     <Plug>(guifont-zoom-reset) : Reset font size
"   Default mappings
"     <C-Up>                     : Increase font size
"     <C-Down>                   : Decrease font size
"   Commands
"     :ZoomIn                    : Increase font size
"     :ZoomOut                   : Decrease font size 
"     :ZoomReset                 : Reset font size
"     :ZoomSet <n>               : Set font size to <n>
" inspired by zoom.vim, from https://www.vim.org/scripts/script.php?script_id=2321

if !has('gui_running') || ( !has('win32') && !has('win64') )
  finish
endif

if &cp || exists("g:loaded_zoom")
  finish
endif
let g:loaded_zoom = 1

let s:save_cpo = &cpo
set cpo&vim

" " keep current guifont, if reset is needed
" let s:current_font = &guifont
" does not work if font is set from gvimrc

" default font size, set to 12 if not specified
let g:font_size_default = get(g:, 'font_size_default', 12)     

" print current font
function! s:fontPrint()
  echo &guifont
endfunction

" get current font size
function! s:fontSizeGet()
  let l:fsize = matchstr(&guifont, '^.*:h\zs[^:]*\ze.*$')
  if l:fsize ==# ''
    let l:fsize = g:font_size_default
  else 
    let l:fsize = str2nr(l:fsize)
  endif
  return l:fsize
endfunction

" set font size
function! s:fontSizeSet(num)
  " check if font size > 0, otherwise do not modify it
  if a:num > 0  
    if match(&guifont, '^.*:h\zs[^:]*\ze.*$') == -1
      " if 'guifont' does not contain :h option, add it in.
      let &guifont .= ':h' . a:num
    else 
      let &guifont = substitute(&guifont, ':h\([^:]*\)', ':h' . a:num, '')
    endif
  endif

  " show new guifont
  redraw
  call s:fontPrint()
endfunction

" guifont size + 1
function! s:fontSizePlus()
  let l:fsize = s:fontSizeGet()
  " echo 'size: ' . l:fsize
  call s:fontSizeSet(l:fsize + 1)
endfunction

" guifont size - 1
function! s:fontSizeMinus()
  let l:fsize = s:fontSizeGet()
  call s:fontSizeSet(l:fsize - 1)
endfunction

" reset guifont size
function! s:fontSizeReset()
  call s:fontSizeSet(g:font_size_default)
endfunction

" plug maps
nnoremap <expr> <Plug>(guifont-zoom-in) <SID>fontSizePlus()
nnoremap <expr> <Plug>(guifont-zoom-out) <SID>fontSizeMinus()
nnoremap <expr> <Plug>(guifont-zoom-reset) <SID>fontSizeReset()

" commands
command! -nargs=0 ZoomIn    :call s:fontSizePlus()
command! -nargs=0 ZoomOut   :call s:fontSizeMinus()
command! -nargs=0 ZoomReset :call s:fontSizeReset()
command! -nargs=1 ZoomSet   :call s:fontSizeSet(<args>)

nmap <C-Up> <Plug>(guifont-zoom-in)
nmap <C-Down> <Plug>(guifont-zoom-out)

let &cpo = s:save_cpo
