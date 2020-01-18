" Transparency for gvim on windows os
" requires vimtweak.dll to be installed in the folder containing vim.exe
if has('gui_running')
  if has('win64')
    let s:path_to_vimtweak = globpath(&runtimepath, 'vimtweak64.dll')
  elseif has('win32')
    let s:path_to_vimtweak = globpath(&runtimepath, 'vimtweak32.dll')
  endif
endif

if !exists("s:path_to_vimtweak") | finish | endif

let s:transp_min = 0	 " min allowable transparency; fully opaque
let s:transp_max = 220   " max allowable transparency; a little less than 255
let s:transp_def = 0	 " default transparency; fully opaque

function s:setTransparency(v)
  let s:transp = a:v
  if (s:transp < s:transp_min) | let s:transp = s:transp_min | endif
  if (s:transp > s:transp_max) | let s:transp = s:transp_max | endif

  call libcallnr(s:path_to_vimtweak, 'SetAlpha', 255-s:transp)
  echo "Transparency" s:transp
endfunction

function IncreaseTransparency(num)
  if !exists("s:transp") | let s:transp = s:transp_def | endif
  let s:transp += a:num
  call SetTransparency(s:transp)
endfunction

function! DecreaseTransparency(num)
  if !exists("s:transp") | let s:transp = s:transp_def | endif
  let s:transp -= a:num
  call SetTransparency(s:transp)
endfunction



let s:transp_finetick = 10
let s:transp_coarsetick = 30

" nnoremap <leader>+ :call IncreaseTransparency(30)<CR>		" idea without v:count
nnoremap <leader>+ :<C-u>call IncreaseTransparency(<C-r>=v:count1 * s:transp_coarsetick<CR>)<CR>
nnoremap <leader>- :<C-u>call DecreaseTransparency(<C-r>=v:count1 * s:transp_coarsetick<CR>)<CR>
nnoremap <leader>^ :<C-u>call IncreaseTransparency(<C-r>=v:count1 * s:transp_finetick<CR>)<CR>
nnoremap <leader>_ :<C-u>call DecreaseTransparency(<C-r>=v:count1 * s:transp_finetick<CR>)<CR>
nnoremap <leader>0 :<C-u>call SetTransparency(0)<CR>

