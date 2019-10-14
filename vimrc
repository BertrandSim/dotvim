" Last modified: 2019-09-06
" -------------------------
" defaults from windows gvim 8.1 install {{{1
" --------------------------------------
"version 6.0
"if &cp | set nocp | endif
"let s:cpo_save=&cpo
"set cpo&vim
"map! <S-Insert> *
"vmap  "*d
"omap <silent> % <Plug>(MatchitOperationForward)
"xmap <silent> % <Plug>(MatchitVisualForward)
"nmap <silent> % <Plug>(MatchitNormalForward)
"map Q gq
"omap <silent> [% <Plug>(MatchitOperationMultiBackward)
"xmap <silent> [% <Plug>(MatchitVisualMultiBackward)
"nmap <silent> [% <Plug>(MatchitNormalMultiBackward)
"omap <silent> ]% <Plug>(MatchitOperationMultiForward)
"xmap <silent> ]% <Plug>(MatchitVisualMultiForward)
"nmap <silent> ]% <Plug>(MatchitNormalMultiForward)
"xmap a% <Plug>(MatchitVisualTextObject)
"omap <silent> g% <Plug>(MatchitOperationBackward)
"xmap <silent> g% <Plug>(MatchitVisualBackward)
"nmap <silent> g% <Plug>(MatchitNormalBackward)
"vmap gx <Plug>NetrwBrowseXVis
"nmap gx <Plug>NetrwBrowseX
"vmap <silent> <Plug>(MatchitVisualTextObject) <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward)
"onoremap <silent> <Plug>(MatchitOperationMultiForward) :call matchit#MultiMatch("W",  "o")
"onoremap <silent> <Plug>(MatchitOperationMultiBackward) :call matchit#MultiMatch("bW", "o")
"vnoremap <silent> <Plug>(MatchitVisualMultiForward) :call matchit#MultiMatch("W",	"n")
m'gv``
"vnoremap <silent> <Plug>(MatchitVisualMultiBackward) :call matchit#MultiMatch("bW", "n")
m'gv``
"nnoremap <silent> <Plug>(MatchitNormalMultiForward) :call matchit#MultiMatch("W",	"n")
"nnoremap <silent> <Plug>(MatchitNormalMultiBackward) :call matchit#MultiMatch("bW", "n")
"onoremap <silent> <Plug>(MatchitOperationBackward) :call matchit#Match_wrapper('',0,'o')
"onoremap <silent> <Plug>(MatchitOperationForward) :call matchit#Match_wrapper('',1,'o')
"vnoremap <silent> <Plug>(MatchitVisualBackward) :call matchit#Match_wrapper('',0,'v')
m'gv``
"vnoremap <silent> <Plug>(MatchitVisualForward) :call matchit#Match_wrapper('',1,'v')
m'gv``
"nnoremap <silent> <Plug>(MatchitNormalBackward) :call matchit#Match_wrapper('',0,'n')
"nnoremap <silent> <Plug>(MatchitNormalForward) :call matchit#Match_wrapper('',1,'n')
"vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
"nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())
"vmap <C-Del> "*d
"vmap <S-Del> "*d
"vmap <C-Insert> "*y
"vmap <S-Insert> "-d"*P
"nmap <S-Insert> "*P
"inoremap  u
"let &cpo=s:cpo_save
"unlet s:cpo_save
"set backup
"set display=truncate
"set guioptions=egmrLT
"set helplang=En
"set history=200
"set langnoremap
"set nolangremap
"set mousemodel=extend
"set nrformats=bin,hex
"set runtimepath=~/vimfiles,C:\\Program\ Files\\Vim/vimfiles,C:\\Program\ Files\\Vim\\vim81,C:\\Program\ Files\\Vim\\vim81\\pack\\dist\\opt\\matchit,C:\\Program\ Files\\Vim/vimfiles/after,~/vimfiles/after
"set ttimeout
"set ttimeoutlen=100
"set undofile
"" }}}

" Important {{{1
" ---------

set nocompatible

filetype plugin indent on
" turns on filetype detection, and loads filetype-specific plugins and indent files
" see :help filetype-overview

set encoding=utf-8		" The encoding displayed.
set fileencoding=utf-8	" The encoding written to file.

" use '/' for file paths, even on windows (instead of '\')
set shellslash

" point $VIMHOME to .vim directory 
" ( = dir containing this vimrc file)
let $VIMHOME = expand('<sfile>:p:h')


" File formats {{{1
" ------------
" set fileformat=unix
set fileformats=unix,dos	" use unix by default, o/w try dos

" filetypes {{{1
" ---------
let g:tex_flavor='latex'			" ft of .tex files to 'tex', not 'plaintex'.


" plugins {{{1
" --------

if has('packages')
" using built-in package manager

  " packages in start:
  "	 lifepillar/vim-solarized8		" solarized8 colorscheme
  "	 tpope/vim-unimpaired			" handy pairs of mappings
  "	 masukmoi/vim-markdown-folding	" expr-folding of markdown files
  "	 SirVer/ultisnips				" snippets
  "  b4winckler/vim-angry			" function argument text object
  "  lervag/vimtex					" plugin for tex files
  "  kana/vim-textobj-user			" custom text objects
  " 	vim-textobj-entire
  " 	vim-textobj-line

  " packages in opt:
  packadd! Nvim-R           	" jalvesaq/Nvim-R --forked;	interaction between R scripts with R terminal
  " packadd! vim-latex-1.10.0 	" vim-latex or latex suite
  " packadd! vim-surround-2.1-usr	" surroundings; usr changed to use omap for ds,cs, etc.
  packadd! auto-pairs       	" jiangmiao/auto-pairs;		delims
  packadd! vim-easy-align   	" junegunn/vim-easy-align;	align lines by a char/regex
  packadd! incsearch.vim		" hayabusa/incsearch.vim;	improved / ? incsearch
  packadd! vim-sandwich		" machakann/vim-sandwich;	surroundings

" elseif " using pathogen plugin manager,
" execute pathogen#infect()

else
  set runtimepath+=~/.vim/pack/bundle/start/vim-solarized8
  set runtimepath+=~/.vim/pack/bundle/start/vim-unimpaired
  set runtimepath+=~/.vim/pack/bundle/start/vim-markdown-folding
  if v:version >= 704
	set runtimepath+=~/.vim/pack/bundle/start/ultisnips    " -3.1
  endif
  set runtimepath+=~/.vim/pack/bundle/start/vim-angry
  set runtimepath+=~/.vim/pack/bundle/start/vim-easy-align
  if v:version >= 704
	set runtimepath+=~/.vim/pack/bundle/start/vim-textobj-user-0.7.6
	set runtimepath+=~/.vim/pack/text-obj/start/vim-textobj-entire
	set runtimepath+=~/.vim/pack/text-obj/start/vim-textobj-line
  endif


  if has('patch-8.0.0946')
	set runtimepath+=~/.vim/pack/bundle/opt/Nvim-R
  endif
  " set runtimepath+=~/.vim/pack/bundle/opt/vim-latex-1.10.0
  " set runtimepath+=~/.vim/pack/bundle/opt/vim-surround-2.1-usr
  set runtimepath+=~/.vim/pack/bundle/opt/auto-pairs
  if has('patch-7.4.52')
    set runtimepath+=~/.vim/pack/bundle/start/vimtex
  endif
  set runtimepath+=~/.vim/pack/bundle/opt/incsearch.vim
  set runtimepath+=~/.vim/pack/bundle/opt/vim-sandwich


endif

" plugin configs {{{1
" --------------
"
" TODO: fork / add configs for unimpaired
" TODO: setup sandwich

" vimtex settings {{{2

" use Sumatra as pdfviewer
let g:vimtex_view_general_viewer = 'SumatraPDF'
" setup forward and backward search
let g:vimtex_view_general_options
	  \ = '-reuse-instance -forward-search @tex @line @pdf'
	  \ . ' -inverse-search "gvim --servername ' . v:servername
	  \ . ' --remote-send \"^<C-\^>^<C-n^>'
	  \ . ':drop \%f^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'
	  \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
	  \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
	  \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

" use single shot compilation instead of continuous mode
let g:vimtex_compiler_latexmk = { 'continuous':0 }

" \lw to write and compile.
augroup vimtex_config
  autocmd!
  autocmd Filetype tex nnoremap <localleader>lw :silent update \| VimtexCompile <CR>
augroup END

" [count] tsd/tsD cycles through 
" \big, \Big, \bigg, \Bigg modifiers
let g:vimtex_delim_toggle_mod_list = [
	  \ ['\bigl' , '\bigr'],
	  \ ['\Bigl' , '\Bigr'],
	  \ ['\biggl', '\biggr'],
	  \ ['\Biggl', '\Biggr'],
	  \]


" TODO [2019-09-30] use sandwich.vim-style mappings for ds,cs,ts
" temporary solution while transiting to sandwich.vim
if isdirectory($VIMHOME."/pack/bundle/opt/vimtex") || 
  \isdirectory($VIMHOME."/pack/bundle/start/vimtex")
  augroup vimtex_maps
	autocmd!
	autocmd Filetype tex nmap sde <plug>(vimtex-env-delete)
	autocmd Filetype tex nmap sdc <plug>(vimtex-cmd-delete)
	autocmd Filetype tex nmap sd$ <plug>(vimtex-env-delete-math)
	autocmd Filetype tex nmap sdd <plug>(vimtex-delim-delete)
	autocmd Filetype tex nmap sre <plug>(vimtex-env-change)
	autocmd Filetype tex nmap src <plug>(vimtex-cmd-change)
	autocmd Filetype tex nmap sr$ <plug>(vimtex-env-change-math)
	autocmd Filetype tex nmap srd <plug>(vimtex-delim-change-math)
	autocmd Filetype tex nmap ste <plug>(vimtex-env-toggle-star)
	autocmd Filetype tex nmap stc <plug>(vimtex-cmd-toggle-star)
	autocmd Filetype tex nmap std <plug>(vimtex-delim-toggle-modifier)
	autocmd Filetype tex xmap std <plug>(vimtex-delim-toggle-modifier)
	autocmd Filetype tex nmap sTd <plug>(vimtex-delim-toggle-modifier-reverse)
	autocmd Filetype tex xmap sTd <plug>(vimtex-delim-toggle-modifier-reverse)
  augroup END
endif

let g:vimtex_mappings_disable = {
  \   'n': ['dse', 'dsc', 'ds$', 'dsd', 'cse', 'csc', 'cs$', 'csd', 'tse', 'tsc', 'tsd', 'tsD'],
  \   'x': ['tsd', 'tsD']
  \ }


" }}}
" sandwich config {{{2
" ---------------
if isdirectory($VIMHOME."/pack/bundle/opt/vim-sandwich") || 
  \isdirectory($VIMHOME."/pack/bundle/start/vim-sandwich")

  " unmap substitute (s) mapping
  nmap s <Nop>
  xmap s <Nop>

  " unuse text-obj auto (ib,ab) and query (is, as) mappings
  let g:textobj_sandwich_no_default_key_mappings = 1

  " use sw / sW to surround inner word
  " TODO [2019-10-11]: sw add count for number of inner words, 
  " NOT including whitespace
  nmap sw <Plug>(operator-sandwich-add)iw
  nmap sW <Plug>(operator-sandwich-add)iW
endif

" for further recipes and configs, see 
" [after]/[ft]plugin/**/*sandwich*

" }}}
" Nvim-R config {{{2
" -------------
let R_esc_term = 0
" let <Esc> function as expected in a R console / terminal
" Note: to interrupt a '+' prompt in a console, use ^C instead.

" let R_assign = 2 	" type two _'s to get <-
let R_assign = 0	" disable shortcut for <-.
" See .vim/after/ftplugin/r_conf for the replacement.

" run RStudio console instead of R console :)
" let R_in_buffer = 0
" let RStudio_cmd = 'C:\Program Files\RStudio\bin\rstudio'

let R_rconsole_width = 0	" split rconsole window horizontally
let R_rconsole_height = 15	" num lines in rconsole window

let rout_follow_colorscheme = 1		" highlight R output in current colorscheme

let R_clear_line = 1
" clears console line with <C-a><C-k> when sending from buffer to terminal

" open documentation in a vertical split
let R_nvimpager = 'vertical'
" let R_nvimpager = 'tabnew'	" new tab, without overwriting existing help windows

" map __ and >> in terminal [Rterm] 
" see after/ftplugin/r_mappings.vim

" keybindings
" disable comment mappings
if isdirectory($VIMHOME."/pack/bundle/opt/Nvim-R") || 
  \isdirectory($VIMHOME."/pack/bundle/start/Nvim-R")

  augroup Nvim-R_config
	autocmd!
	autocmd filetype R unmap <buffer> <localleader>xx
	autocmd filetype R unmap <buffer> <localleader>xc
	autocmd filetype R unmap <buffer> <localleader>xu
  augroup END
endif

" }}}
" Ultsnips config {{{2
" ---------------
" mappings
let g:UltiSnipsExpandTrigger       = '<Tab>'
let g:UltiSnipsListSnippets        = '<C-Tab>'
let g:UltiSnipsJumpForwardTrigger  = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" unmap ^j, ^k, 
" can be confusing especially when unsure if in a snippet or not
inoremap <C-j> <Nop>
inoremap <C-k> <Nop>

" Open snippets file in a horizontal or vertical split, depending on context
let g:UltiSnipsEditSplit='context'	

" }}}


" Autopairs settings
let g:AutoPairsCenterLine = 0		" do not re-center screen after pressing <CR>
let g:AutoPairsMultilineClose = 0	" do not jump past closing char on another line

" mappings for easy align plugin
if isdirectory($VIMHOME."/pack/bundle/opt/vim-easy-align") || 
  \isdirectory($VIMHOME."/pack/bundle/start/vim-easy-align")

  nmap ga <Plug>(EasyAlign)
  xmap ga <Plug>(EasyAlign)
  nmap gA <Plug>(LiveEasyAlign)
  xmap gA <Plug>(LiveEasyAlign)
endif


" UI {{{1
" -------------------
if v:version > 703 "version 7.3 or newer
  " show (absolute) current line number and relative numbers for the other lines
  set number relativenumber
else
  " show (absolute) line numbers
  set number
endif

set showcmd			" show command in bottom bar
"set cursorline		" highlight current line
set ruler			" show cursor position (ln,col)
set wildmenu		" displays a visual bar containing autocomplete options when using :<command> TAB
set laststatus=2	" always show bottom status line
set lazyredraw		" Do not update screen redraw during macro and script execution
"set showmatch		" highlight matching [{()}]

set scrolloff=1		" keep n line(s) above and below the cursor

syntax enable		" enable syntax processing

" colorschemes	{{{1
" ------------
" toggle background light/dark
map <F5> :set background=<C-R>=&background == "dark" ? "light" : "dark"<CR><CR>

colorscheme darkblue		" fallback to preinstalled colorscheme (if others unavailable)

"" solarized8 colorscheme (downloaded from github) {{{2
"" also suited for 24bit color terminals :)
"" -----------------------------------------------

if has('termguicolors')
  set termguicolors
endif

silent! colorscheme solarized8

if g:colors_name == 'solarized8'
  set background=light
endif

"" }}}

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see https://sunaku.github.io/vim-256color-bce.html or 
  " http://snk.tuxfamily.org/log/vim-256color-bce.html
set t_ut=
endif

" gvim {{{1
augroup gvimm
  autocmd!
  autocmd VimEnter * 
	  \if has('gui_running')
	  \  | set guifont=Consolas:h12:cANSI:qDRAFT
	  \  | set lines=30 columns=120
	  \|endif
augroup END

if has('gui_running')
  if has('win64') || has('win32')
	set winaltkeys=no
	" don't use ALT to access the gui menu
	" use :simalt instead.
  endif
endif


" Transparency for gvim on windows os
" requires vimtweak.dll to be installed in the folder containing vim.exe
if has('gui_running')
  if has('win64')
	let g:path_to_vimtweak = globpath(&runtimepath, 'vimtweak64.dll')
  elseif has('win32')
	let g:path_to_vimtweak = globpath(&runtimepath, 'vimtweak32.dll')
  endif

  if exists("g:path_to_vimtweak")

	let g:transp_min = 0	 " min allowable transparency; fully opaque
	let g:transp_max = 220   " max allowable transparency; a little less than 255
	let g:transp_def = 0	 " default transparency; fully opaque

	function SetTransparency(v)
	  let g:transp = a:v
	  if (g:transp < g:transp_min) | let g:transp = g:transp_min | endif
	  if (g:transp > g:transp_max) | let g:transp = g:transp_max | endif

	  call libcallnr(g:path_to_vimtweak, 'SetAlpha', 255-g:transp)
	  echo "Transparency" g:transp
	endfunction

	function IncreaseTransparency(num)
	  if !exists("g:transp") | let g:transp = g:transp_def | endif
	  let g:transp += a:num
	  call SetTransparency(g:transp)
	endfunction

	function! DecreaseTransparency(num)
	  if !exists("g:transp") | let g:transp = g:transp_def | endif
	  let g:transp -= a:num
	  call SetTransparency(g:transp)
	endfunction



	let g:transp_finetick = 10
	let g:transp_coarsetick = 30

	" nnoremap <leader>+ :call IncreaseTransparency(30)<CR>		" idea without v:count
	nnoremap <leader>+ :<C-u>call IncreaseTransparency(<C-r>=v:count1 * g:transp_coarsetick<CR>)<CR>
	nnoremap <leader>- :<C-u>call DecreaseTransparency(<C-r>=v:count1 * g:transp_coarsetick<CR>)<CR>
	nnoremap <leader>^ :<C-u>call IncreaseTransparency(<C-r>=v:count1 * g:transp_finetick<CR>)<CR>
	nnoremap <leader>_ :<C-u>call DecreaseTransparency(<C-r>=v:count1 * g:transp_finetick<CR>)<CR>
	nnoremap <leader>0 :<C-u>call SetTransparency(0)<CR>
  endif

endif

" search options {{{1
" -------------------
set incsearch		" jump to first search as characters are entered
set ignorecase		" required for smartcase
set smartcase		" *\c*ase insensitive when search is fully in lowercase, and 
					" *\C*ase Sensitive when search contains uppercase chars

set hlsearch		" highlight matches

if has('patch-8.1.1270')
  set shortmess-=S	" show match position [n/N] when searching
endif

" search related mappings {{{1
" -----------------------

" turn off search highlighting with \<space>
nnoremap <leader><space> :nohlsearch<CR>
" nnoremap <leader><space> :let @/=""<CR>

" incsearch.vim mappings
if isdirectory($VIMHOME."/pack/bundle/opt/incsearch.vim") || 
  \isdirectory($VIMHOME."/pack/bundle/start/incsearch.vim")

  " map / <Plug>(incsearch-forward)
  " map ? <Plug>(incsearch-backward)
  map z/ <Plug>(incsearch-stay)

  " let n always search forward, N always backward
  " let g:incsearch#consistent_n_direction = 1
endif

" z*, gz*, z#, gz#
" search word under cursor (like *), but without moving the cursor
nnoremap <silent>  z* :let @/ = '\<'.expand('<cword>').'\>' \| set hlsearch \|
	  \ call histadd("/", @/) \| echo @/<CR>
nnoremap <silent> gz* :let @/ =      expand('<cword>')      \| set hlsearch \|
	  \ call histadd("/", @/) \| echo @/<CR>
nnoremap <silent>  z# :let @/ = '\<'.expand('<cword>').'\>' \| set hlsearch \| let v:searchforward=0 \|
	  \ call histadd("/", @/) \| echo @/<CR>
nnoremap <silent> gz# :let @/ =      expand('<cword>')      \| set hlsearch \| let v:searchforward=0 \|
	  \ call histadd("/", @/) \| echo @/<CR>

" highlight search matches without jumping to it
" nnoremap <leader>/ :let @/=""<Left>
" replaced with incsearch.vim?

" enter search with word boundaries \<...\>
nnoremap g/ /\<\><Left><Left>
" nmap <expr> gz/ incsearch#go({'command': '/', 'pattern': '\<', 'is_stay': 1 })
" nmap <expr> gz/ incsearch#go({'command': '/', 'pattern': '\<\>', 'is_stay': 1 })."\<Left>\<Left>" "doesn't work

" search between marks
nnoremap m/ /\%>'s\%(\)\%<'e<Left><Left><Left><Left><Left><Left><Left>

" search within visual selection
vnoremap / <Esc>/\%V\%(\)\%V<Left><Left><Left><Left><Left>


" tabs and spacing {{{1
" -------------------
" set tabstop=4			" number of visual spaces per TABstop
" set softtabstop=4		" number of spaces inserted per TAB when editing (eg. in insert mode)
" set shiftwidth=4		" number of spaces for an indent
" set expandtab			" Tabstops are expanded to spaces
" set nosmarttab		" disabled. If on, TAB adds a shiftwidth at the start of a line, and a softtabstop elsewhere

set tabstop=8			" number of visual spaces per TABstop
set softtabstop=0		" number of spaces inserted per TAB when editing (eg. in insert mode) " to be the same as tabstop
set shiftwidth=2		" number of spaces for an indent
set noexpandtab			" Tabstops are not expanded to spaces
set smarttab			" TAB adds a shiftwidth at the start of a line, and a softtabstop elsewhere

" whitespace and eol {{{1

set wrap		" wrap lines (display)
set linebreak	" don't break lines in between words
if exists("&breakindent") | set breakindent | endif	" wrapped lines preserve indentation
set showbreak=..	" wrapped lines are prepended with ".."

" mapping to toggle wrap
noremap <F3> :set wrap!<CR>
	        \:set wrap?<CR>

" specify how eol and ws chars are displayed
set listchars=eol:¬,tab:>\ ,trail:_,extends:>,precedes:<,nbsp:~
if has('patch-7.4.710')
  set listchars+=space:·
endif

" mapping to show/hide these characters
noremap <F4> :set list!<CR>
	        \:set list?<CR>

" movement and scrolling {{{1
" --------------

" move screen lines without a count supplied, and 
" full lines with a count supplied.
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'

" swap ; and , for f,F,t,T
nnoremap ; ,
nnoremap , ;


" view help, nomodifiable buffers {{{1
" -------------------------------
augroup nomod_maps
  autocmd!
  autocmd BufWinEnter,BufRead *
	\ if !&l:modifiable|
	\   nnoremap <buffer> d <C-d>|
	\   nnoremap <buffer> u <C-u>|
	\   nnoremap <buffer> q :<C-u>q<CR>|
	\ endif
augroup END


" edits and inserts {{{1
" -------------------
" key combi to escape from insert mode
" inoremap jk <Esc>
" replaced by moving <Esc>'s keyboard location

" open line(s) and stay in command mode.
" the code 2 lines below is a macro with keystrokes o, <esc>, k.
" a macro is used to let the remap work with counts.
" nnoremap <C-j> @="o\ek"<CR>
" nnoremap <C-k> @="O\ej"<CR>
" nnoremap <leader>o @="o\ek"<CR>
" nnoremap <leader>O @="O\ej"<CR>
nnoremap <C-n> @="o\ek"<CR>
nnoremap <C-p> @="O\ej"<CR>
" could also use [<Space>, ]<Space>, in vim-unimpaired plugin.

" use a count with 'o' or 'O' to specify how many lines to open
nnoremap <expr> o '<Esc>o' . repeat('<CR>', v:count1 - 1)
nnoremap <expr> O '<Esc>O' . repeat('<CR>', v:count1 - 1) . repeat('<Up>', v:count1 - 1)
" [N]O is not . repeatable

" in insert mode, <BS> ^W etc. is able to delete indents, newlines, 
" and past the starting place of insertion
set backspace=indent,eol,start

" Use u for t after an operator (UnTil).
" A little easier on the hands
" onoremap u t


" bracket matching {{{1
" ----------------
" change ( to (|), with cursor at |.
" see :h i^gU --- does not break undo or . repeat
" if has('patch-7.4.849')
  " inoremap ( ()<C-G>U<Left>
  " inoremap [ []<C-G>U<Left>
  " inoremap { {}<C-G>U<Left>
" else
  " inoremap ( ()<Left>
  " inoremap [ []<Left>
  " inoremap { {}<Left>
" endif

" replaced with autopairs plugin (for now)...

"
" quick comment {{{1
" -------------

" comment_leader can be specified by user, or extracted from 'commentstring' or 'comment' options.
" [TODO] use SID for functions
" [TODO] migrate to a plugin


augroup qcomment
  autocmd!
  autocmd FileType c,cpp,java,scala	let b:comment_leader = '// '
  autocmd FileType sh,python,r		let b:comment_leader = '# '
  autocmd FileType conf,fstab		let b:comment_leader = '# '
  autocmd FileType tex				let b:comment_leader = '% '
  autocmd FileType mail				let b:comment_leader = '> '
  autocmd FileType autohotkey		let b:comment_leader = '; '
  autocmd FileType vim				let b:comment_leader = '" '
  autocmd FileType snippets			let b:comment_leader = '# '
  autocmd FileType gitconfig		let b:comment_leader = '# '
augroup END


nmap <leader>c <Plug>(AddComment)
nmap <leader>x <Plug>(RmComment)
nmap <leader>bc <Plug>(AddBlockComment)
nmap <leader>bx <Plug>(RmBlockComment)
vmap <leader>c <Plug>(VAddComment)
vmap <leader>x <Plug>(VRmComment)
vmap <leader>bc <Plug>(VAddBlockComment)
" vmap <leader>bx <Plug>(VRmBlockComment)

nnoremap <silent> <Plug>(AddComment) :<C-U>set opfunc=AddCommentOp<CR>g@
nnoremap <silent> <Plug>(RmComment) :<C-U>set opfunc=RemoveCommentOp<CR>g@
nnoremap <silent> <Plug>(AddBlockComment) :<C-U>set opfunc=AddBlockCommentOp<CR>g@
" nnoremap <silent> <Plug>(RmBlockComment) :<C-U>set opfunc=RemoveCommentOp<CR>g@
vnoremap <silent> <Plug>(VAddComment) :<C-U>call AddCommentOp(visualmode())<CR>
vnoremap <silent> <Plug>(VRmComment) :<C-U>call RemoveCommentOp(visualmode())<CR>
vnoremap <silent> <Plug>(VAddBlockComment) :<C-U>call AddBlockCommentOp(visualmode())<CR>
" vnoremap <silent> <Plug>(VRmBlockComment) :<C-U>call RemoveCommentOp(visualmode())<CR>



nnoremap <silent> <leader>bx :<C-u>call RemoveBlockComment()<CR>
vnoremap <silent> <leader>bx :<C-u>call RemoveBlockComment()<CR>

function! AddCommentOp(type)
  let comleader = GetCommentLeader()

  if a:type ==# 'char' || a:type ==# 'line' || a:type ==# 'block'
	let startline = line("'[")
	let endline   = line("']")
  else "if a:type ==# 'v' || a:type ==# 'V' || a:type ==# ''
	let startline = line("'<")
	let endline   = line("'>")
  endif

  let minindent = GetMinIndent( range(startline, endline) )
  let shiftwidth_ =  has('patch-7.3.694') ? shiftwidth() : &sw == 0 ? &ts : &sw
  let minsw = minindent / shiftwidth_

  execute "silent" . startline.','.endline . repeat('<', minsw)
  execute "silent" . startline.','.endline . 'normal 0i'.comleader."\<Esc>"
  execute "silent" . startline.','.endline . repeat('>', minsw)

  nohlsearch
endfunction


function! RemoveCommentOp(type)
  if a:type ==# 'char' || a:type ==# 'line' || a:type ==# 'block'
    let startline = line("'[")
	let endline   = line("']")
  else "if a:type ==# 'v' || a:type ==# 'V' || a:type ==# ''
	let startline = line("'<")
	let endline   = line("'>")
  endif

  call RemoveComment(startline, endline)

endfunction

function! RemoveComment(startline, endline)
  let comleader = GetCommentLeader()
  execute a:startline . ',' a:endline . 'substitute' . '/' .
	\ '\v(^\s*)' . '\V'.escape(comleader,'\/') . '/' .
	\ '\1' . '/e'
  nohlsearch
endfunction

function! GetCommentLeader()
  if exists("b:comment_leader")  " user defined
	let commentstart = b:comment_leader
  elseif len(split(&commentstring, '%s')) == 1
	" if 'commentstring' xx%sxx contains no end part
	let commentstart = split(&commentstring, '%s')[0]
  elseif match(&comments, '\v(,|^):[^,:]*,')
    " if 'comment' contains ',:xxx,'
    let commentstart = matchstr(&comments, '\v(,|^):\zs[^,:]*\ze,')
  else
	echoerr "unable to find comment leader."
  endif

  let commentstart = AppendSpace( commentstart )
  return commentstart
endfunction

function! GetMinIndent(range)

  let foundNonBlank = 0

  for lnum in a:range

	" find first nonblank line as a starting comparison
    if !foundNonBlank
	  if !IsBlankLine(lnum)
		let minIndent = indent(lnum)
		let foundNonBlank = 1
	  elseif lnum == a:range[-1]
	  " ie. if last line and all other lines blank
		return 0
	  endif

	elseif !IsBlankLine(lnum) && indent(lnum) < minIndent
	  let minIndent = indent(lnum)

	endif

  endfor

  return minIndent

endfunction


function! IsBlankLine(lnum)
  return getline(a:lnum) =~ '\v^\s*$'
endfunction


function! AddBlockCommentOp(type)
  let [comstart, comend] = GetBlockCommentMarks()
  let [markstart, markend] = GetOpMarks(a:type)

  " get position / coordinates of start/end marks
  " getpos() only allows 'x, not `x
  let opstart = getpos(substitute(markstart,"`","'",""))
  let opend   = getpos(substitute(markend,  "`","'",""))

  if a:type ==# 'char' || a:type ==# 'v'
	" character wise
	exec 'normal' . markend . 'a'.comend."\<Esc>"
	call setpos( substitute(markstart,"`","'",""), opstart)		" to recall `[ position ; setpos() only allows 'x, not `x
	exec 'normal' . markstart .'i'.comstart."\<Esc>" . markstart
  elseif a:type ==# 'line' || a:type ==# 'V'
	" linewise
	exec 'normal' . markend . 'o'.comend."\<Esc>"
	call setpos( markstart, opstart)
	exec 'normal' . markstart .'O'.comstart."\<Esc>" . markstart
  endif

  " idea of the above (in visual mode):
  " if a:type ==# 'v'	" character wise
  "   exec 'normal' . '`>'. 'a'.comend."\<Esc>" . '`<' .'i'.comstart."\<Esc>" . '`<'
  " elseif a:type ==# 'V'	" linewise
  "   exec 'normal' . '`>'. 'o'.comend."\<Esc>" . '`<' .'O'.comstart."\<Esc>" . '`<'
  " endif
endfunction

function! RemoveBlockComment()
  let [comstart, comend] = GetBlockCommentMarks()
  let comstart_len = len(comstart)
  let comend_len   = len(comend)

  " search outward for comment markers
  " for now, cursor must NOT be on the comment markers [FIXME]
  let startpos = searchpairpos('\V'.escape(comstart,'/'), '', '\V'.escape(comend,'\'), 'bnW')
  " echo 'startpos: ' . string(startpos)
  let endpos   = searchpairpos('\V'.escape(comstart,'/'), '', '\V'.escape(comend,'\'),  'nW')
  " echo 'endpos: '   . string(endpos)

  if startpos != [0,0] && endpos != [0,0]
  " ie. block comment markers found
	let curcurpos = getcurpos()

	" remove comment markers
	call cursor(endpos)
	exec 'norm' . comend_len.'x'
	call cursor(startpos)
	exec 'norm' . comstart_len.'x'

	" restore cursor position
	let curcurpos[2] -= comstart_len  " shift left
	let curcurpos[4] = 0	" remove curswant
	" echo string(curcurpos)
	call setpos('.', curcurpos)
  endif

endfunction


function! GetBlockCommentMarks()
  if len(split(&commentstring, '%s')) == 2
	" if 'commentstring' xx%sxx contains start and end part
	let commentstartend = split(&commentstring, '%s')
	let commentstart = commentstartend[0]
	let commentend   = commentstartend[1]

	return [commentstart, commentend]
  endif
  echoerr "Unable to find block comment syntax markers."
endfunction


function AppendSpace(str)
" adds a space to the back of str if there isn't one
  let len=strlen(a:str)
  let outstr = a:str

  if a:str[len-1] != ' '
    let outstr = outstr.' '
  endif
  return outstr
endfunction

function! GetOpMarks(type)
  " returns [start, end] `marks' of operator action
  if     a:type ==# 'char'	" character wise
	let [_start, _end] = [ "`[", "`]" ]
  elseif a:type ==# 'line'	" linewise
	let [_start, _end] = [ "'[", "']" ]
  elseif a:type ==# "v"	" character wise
	let [_start, _end] = [ "`<", "`>" ]
  elseif a:type ==# 'V'	" linewise
	let [_start, _end] = [ "'<", "'>" ]
  endif
  return [_start, _end]
endfunction


" v1: the idea
" noremap <silent> <leader>cc 
	  " \:<C-B>silent <C-E>
	  " \s/^\s*/&<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>
	  " \:nohlsearch<CR>
" noremap <silent> <leader>cu 
	  " \:<C-B>silent <C-E>
	  " \s/\v(^\s{-})\V<C-R>=escape(b:comment_leader,'\/')<CR>/\1/e<CR>
	  " \:nohlsearch<CR>



" comment a copy {{{1

" Copies cur line or visual selection,
" comments the copied lines above, and
" positions cursor at the copy below.
" Requires quick comment.

" known issue: does not work if _ is remapped.

function! ComACop()
  let curpos_save = getcurpos()
  copy -
  execute 'normal'."\<Plug>(AddComment)" .'_'
  " restore cursor
  " curpos_save[1] += 1   " adjust line after changing buffer
  call setpos('.', curpos_save) 
  normal! j
endfunction

function! VComACop()
  let curpos_save = getcurpos() 
  let numlines = line("'>") - line("'<") + 1
  '<,'>copy '<-

  "comment
  execute 'normal!' ."'<". repeat('k', numlines)
  execute 'normal' ."\<Plug>(AddComment)" .numlines.'_'

  "restore cursor
  " curpos_save[1] += numlines
  call setpos('.', curpos_save)
  execute 'normal!'.numlines.'j'
endfunction

" nnoremap <silent> <Plug>(ComACop)  :<C-U>copy  -\|:execute 'normal'."\<Plug>(AddComment)_j"<CR>
" vnoremap <silent> <Plug>(VComACop) :     copy '>\|:execute 'normal! gv'\|:execute 'normal'."\<Plug>(VAddComment)"\|
" ^ old ver.
nnoremap <silent> <Plug>(ComACop)  :<C-U>call ComACop()<CR>
vnoremap <silent> <Plug>(VComACop) :<C-U>call VComACop()<CR>

"cp to copy and comment cur line (normal mode)
omap <expr> p v:operator ==# 'c' ? "\<Esc>"."\<Plug>(ComACop)" : 'p'
"or F7 to copy and comment cur line / visual selection
nmap <F7> <Plug>(ComACop)
vmap <F7> <Plug>(VComACop)


" folding {{{1
" -------
set foldenable			" enable folding
set foldlevelstart=5	" fold levels >=5 are unfolded (shown)

" z<Space> to open/close folds
nnoremap z<Space> za

" \zo to open _o_nly current fold (close all folds)
nnoremap <leader>zo zMzv
" \zO to _O_pen current fold, and other nested folds 
nnoremap <leader>zO zMzO

" ex-commands {{{1
" -----------

" typos
" -----
" changes :W to :w, and others.
command! -bang          Q q<bang>
command! -bang -nargs=? W w<bang> <args>
command! -bang          QA qa<bang>
command! -bang          Qa qa<bang>
command! -bang          Wa wa<bang>
command! -bang          WA wa<bang>
command! -bang -nargs=? Wq wq<bang> <args>
command! -bang -nargs=? WQ wq<bang> <args>

" :edit file. May overwrite :Explore
command! -bang -nargs=* E e<bang> <args>

" :help related
" -------------
" :H may overwrite :Hexplore
command! -bang -nargs=? -complete=help H h<bang> <args>
command! -bang -nargs=? -complete=help Vh vert h<bang> <args>
command! -bang -nargs=? -complete=help VH vert h<bang> <args>
command! -bang -nargs=? -complete=help Th tab h<bang> <args>
command! -bang -nargs=? -complete=help TH tab h<bang> <args>

" cmdline + Ultisnips {{{1
" -------------------
" quick expand snippet via cmdline window
cnoremap ;: <C-r>=&cedit<CR>:call UltiSnips#ExpandSnippet()<CR>

" change <Tab> from cmdline-completion to snippet expansion
" by unmapping <Tab>.
augroup cmdline_window
    autocmd!
    autocmd CmdWinEnter [:>] silent! iunmap <buffer> <Tab>
    autocmd CmdWinEnter [:>] silent! nunmap <buffer> <Tab>
augroup END

" see UltiSnips/vim_cmdline.snippets for the snippets themselves

" }}}
" Ultisnip snippet operator {{{1
" an operator wrapper to {Visual} + UltiSnips#ExpandSnippet()
nnoremap <leader><Tab>
	  \ :<C-U>set opfunc=SnippetOp<CR>
	  \:echo &opfunc<CR>
	  \g@

function! SnippetOp(type)
  "  an operator wrapper to {Visual} + UltiSnips#ExpandSnippet()

  if     a:type ==# 'char' | let vtype='v'
  elseif a:type ==# 'line' | let vtype='V'
  endif

  execute 'normal! `['.vtype.'`]'."\<Esc>"
  call UltiSnips#SaveLastVisualSelection()
  " normal! gvs	"
  " startinsert	" cursor is off by one to the left..
  call feedkeys('gvs', 'n')
endfunction

" }}}
" tex delims insert [TODO] {{{1
" ------------------

" augroup ft_tex
"   autocmd!
"   " swap [ and {
"   autocmd Filetype tex
"    \ if exists("g:AutoPairsLoaded")
" 	 \| inoremap <buffer> [ <C-R>=AutoPairsInsert('{')<CR>
" 	 \| inoremap <buffer> ] <C-R>=AutoPairsInsert('}')<CR>
" 	 \| inoremap <buffer> { <C-R>=AutoPairsInsert('[')<CR>
" 	 \| inoremap <buffer> } <C-R>=AutoPairsInsert(']')<CR>
"    \| else
" 	 \| inoremap <buffer> [ {
" 	 \| inoremap <buffer> ] }
" 	 \| inoremap <buffer> { [
" 	 \| inoremap <buffer> } ]
"    \| endif
"   " add \(, \[, \{ pairs
"   " but does not trigger after typing '\(', as it starts with \ .
"   autocmd Filetype tex 
"     \ if exists ("g:AutoPairsLoaded")
"   	\| let b:AutoPairs = AutoPairsDefine({'\\(':'\\)', '\\[':'\\]', '\\{':'\\}'})
"     \| endif
" augroup END


" R code folding [TODO] {{{1
" ------

" code folding, using native vim's syntax / Nvim-R
autocmd Filetype r setlocal foldmethod=syntax
" let r_syntax_folding=1
let r_syntax_brace_folding=1
" or using custom fold expr instead... via plugin [TODO]
" autocmd Filetype r setlocal foldmethod=expr

" window splits {{{1
" -------------
" don't automatically ^W= after splitting or closing a window
set noequalalways	

" opens splits below, and vsplits to the right
set splitbelow splitright

" terminal {{{1
" --------

if has('terminal')

  " key to enter terminal normal mode
  tnoremap <F2> <C-W>N
  " ... and back to terminal job mode
  augroup termm
	autocmd!
	if (v:version >= 801)
	  autocmd TerminalOpen * if &buftype ==# 'terminal' | nnoremap <buffer> <F2> i| endif
	else
	  autocmd BufWinEnter *  if &buftype ==# 'terminal' | nnoremap <buffer> <F2> i| endif
	endif
  augroup END

  " ^r to insert register (^w" in terminal job mode)
  tnoremap <C-r> <C-w>"

endif


" clipboard {{{1
" ---------
if has('clipboard')
  set clipboard=unnamed  " use the * register (system clipboard) by default
endif

" quick edit vimrc {{{1
" ---------------- 
nnoremap <leader>ev :tabedit $MYVIMRC<CR>
" nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" reload vimrc (if it is in current window): write, source, edit, show cursor
nnoremap <silent> <leader>rv 
	  \:if expand('%:p') ==? expand($MYVIMRC) \|
	  \  write \|
	  \  source % \|
	  \  edit \|
	  \  exec "norm zv" \|
	  \  nohlsearch \|
	  \endif<CR>

" custom text objects {{{1
" -------------------
" ported all these to vim-textobj-user

" TODO: save gv register for onoremap's

" inner line text object
" selects entire line without surrounding whitespace
" vnoremap il :norm g_v^<CR>
" onoremap il :norm vil<CR>
" see vim-textobj-line

" 'a everything' or 'absolutely everything' text object
" selects entire buffer
" vnoremap ae :normal GVgg<CR>
" onoremap ae :normal Vae<CR>
" see vim-textobj-entire

" 'R function'
" autocmd FileType R xnoremap af :call SelectRFunc()<CR>
" autocmd Filetype R onoremap af :normal vaf<CR>
" see vim-textobj-rfunc (working version, WIP, at time of writing)


" misc {{{1
" ----
if has('patch-7.4.793')
  set belloff=all " turn off audio error bells
endif

set diffopt+=vertical	  " when starting diffmode, use vertical splits by default, such as with :diffsplit

function PosCompare(p1, p2)
  " compares if one position is later than the other
  " returns -1 ( p1 < p2 ), +1 ( p1 > p2 ), or 0 ( p1 == p2 )
  " p1 and p2 are positions, in the same format as the output for getpos()
  if     a:p1[1] < a:p2[1] || (a:p1[1] == a:p2[1] && a:p1[2] < a:p2[2]) | return -1
  elseif a:p1[1] > a:p2[1] || (a:p1[1] == a:p2[1] && a:p1[2] > a:p2[2]) | return  1
  else														| return  0 | endif
endfunction

" modelines for folding of this file {{{1
" ----------------------------------
set modelines=2
" vim: filetype=vim ts=4 sw=2 sts=4 noet sta
" vim: foldmethod=marker foldlevel=0 fileformat=unix
