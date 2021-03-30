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


" File formats {{{1
" ------------
" set fileformat=unix
set fileformats=unix,dos	" use unix by default, o/w try dos

" filepaths and dirs {{{1
" ------------------
" point $VIMHOME to .vim directory 
" ( = dir containing this vimrc file)
let $VIMHOME = expand('<sfile>:p:h')

" use '/' for file paths, even on windows (instead of '\')
set shellslash

" _c_hange _d_irectory to that of _c_urrent file with :CDC
command CDC lcd %:p:h

" use wsl as shell {{{1
" ----------------
" if has('win32') || has('win64')
"   set shell=C:/Windows/System32/wsl.exe
"   set shellpipe=|
"   set shellredir=>
"   set shellcmdflag=
" endif

" alternatively, without the above config,
" one could use `:!wsl` or `:!wsl [cmd]`. 

" filetypes {{{1
" ---------
let g:tex_flavor='latex'			" ft of .tex files to 'tex', not 'plaintex'.


" plugins {{{1
" --------

if has('packages')
" using built-in package manager

  " packages in start:
  "   lifepillar/vim-solarized8		" solarized8 colorscheme
  "   tpope/vim-unimpaired			" handy pairs of mappings
  "   masukmoi/vim-markdown-folding	" expr-folding of markdown files
  "   itchyny/lightline.vim			" lean status line
  "   SirVer/ultisnips				" snippets
  "   jalvesaq/Nvim-R				" interaction between R scripts with R terminal
  "   junegunn/vim-easy-align		" align lines by a char/regex
  "   machakann/vim-sandwich		" surroundings
  "   lervag/vimtex					" plugin for tex files
  "   text objects:
  "     b4winckler/vim-angry			" function argument text object
  "     kana/vim-textobj-user			" custom text objects
  "     kana/vim-textobj-entire
  "     kana/vim-textobj-line
  "   search and navigation:
  "     majutsushi/tagbar			" show tags on a side margin
  "     ludovicchabant/vim-gutentags	" automatically generate tags
  "     kshenoy/vim-signature	" show marks in signs column (left gutter)

  " packages in opt:
  packadd! auto-pairs       	" BertrandSim/auto-pairs;	delims, forked from jiangmiao/auto-pairs
  packadd! incsearch.vim		" hayabusa/incsearch.vim;	improved / ? incsearch
  packadd! vim-arpeggio			" kana/vim-arpeggio;		key chords
  packadd! Colorizer			" chrisbra/Colorizer;		show color codes and names in vim

" elseif " using pathogen plugin manager,
" execute pathogen#infect()

else
  set runtimepath+=~/.vim/pack/bundle/start/vim-solarized8
  set runtimepath+=~/.vim/pack/bundle/start/vim-unimpaired
  set runtimepath+=~/.vim/pack/bundle/start/vim-markdown-folding
  set runtimepath+=~/.vim/pack/bundle/start/lightline.vim
  if v:version >= 704
	set runtimepath+=~/.vim/pack/bundle/start/ultisnips    " -3.1
  endif
  if has('patch-8.0.0946')
	set runtimepath+=~/.vim/pack/bundle/start/Nvim-R
  endif
  set runtimepath+=~/.vim/pack/bundle/start/vim-easy-align
  set runtimepath+=~/.vim/pack/bundle/start/vim-sandwich
  if has('patch-7.4.52')
    set runtimepath+=~/.vim/pack/bundle/start/vimtex
  endif
  set runtimepath+=~/.vim/pack/text-obj/start/vim-angry
  if v:version >= 704
	set runtimepath+=~/.vim/pack/text-obj/start/vim-textobj-user
	set runtimepath+=~/.vim/pack/text-obj/start/vim-textobj-entire
	set runtimepath+=~/.vim/pack/text-obj/start/vim-textobj-line
  endif
  set runtimepath+=~/.vim/pack/search-nav/start/tagbar
  set runtimepath+=~/.vim/pack/search-nav/start/vim-gutentags
  set runtimepath+=~/.vim/pack/search-nav/start/vim-signature


  set runtimepath+=~/.vim/pack/bundle/opt/auto-pairs
  set runtimepath+=~/.vim/pack/bundle/opt/incsearch.vim
  set runtimepath+=~/.vim/pack/bundle/opt/vim-arpeggio
  set runtimepath+=~/.vim/pack/bundle/opt/Colorizer

endif

" plugin configs {{{1
" --------------
"
" TODO: fork / add configs for unimpaired
" TODO [2020-01-02]: setup sandwich exchange / cycle within same recipe group

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
  autocmd Filetype tex nnoremap <silent> <localleader>lw :<C-U>silent update \| VimtexCompile <CR>
augroup END

" [count] std/sTd cycles through 
" \big, \Big, \bigg, \Bigg modifiers
let g:vimtex_delim_toggle_mod_list = [
	  \ ['\bigl' , '\bigr'],
	  \ ['\Bigl' , '\Bigr'],
	  \ ['\biggl', '\biggr'],
	  \ ['\Biggl', '\Biggr'],
	  \]

" Use sandwich.vim-style mappings for ds,cs,ts --> sd, se, st/sT
" temporary solution while transiting to sandwich.vim [TODO]
if isdirectory($VIMHOME."/pack/bundle/opt/vimtex") || 
  \isdirectory($VIMHOME."/pack/bundle/start/vimtex")
  augroup vimtex_maps
	autocmd!
	" autocmd Filetype tex nmap sde <plug>(vimtex-env-delete)
	" autocmd Filetype tex nmap sdc <plug>(vimtex-cmd-delete)
	" autocmd Filetype tex nmap sd$ <plug>(vimtex-env-delete-math)
	" autocmd Filetype tex nmap sdd <plug>(vimtex-delim-delete)
	autocmd Filetype tex nmap see <plug>(vimtex-env-change)
	autocmd Filetype tex nmap sec <plug>(vimtex-cmd-change)
	autocmd Filetype tex nmap se$ <plug>(vimtex-env-change-math)
	" autocmd Filetype tex nmap sed <plug>(vimtex-delim-change-math)
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


" enable folding of sections/envirs/commands
let g:vimtex_fold_enabled = 1
" see :h vimtex-folding, :h g:vimtex_fold_types for more

" Disable scanning of included packages / files in ^p ^n completion 
" this will reduce hang when you first hit ^p or ^n in insert mode
" but will disable `gf` to .sty, package .cls, or included .tex files.
" See https://github.com/lervag/vimtex/issues/1681 " and also issue 1358
let g:vimtex_include_search_enabled = 0


" }}}
" sandwich config {{{2
" ---------------
if isdirectory($VIMHOME."/pack/bundle/opt/vim-sandwich") || 
  \isdirectory($VIMHOME."/pack/bundle/start/vim-sandwich")

  " unmap substitute (s) mapping
  nmap s <Nop>
  xmap s <Nop>

  " load custom mappings
  source $VIMHOME/plugin/sandwich_maps.vim

  " for recipes, text-objects, and other configs, see 
  " [after]/[ft]plugin/**/*sandwich*
endif

" }}}
" Nvim-R config {{{2
" -------------
let R_esc_term = 0
" let <Esc> function as expected in a R console / terminal
" Note: to interrupt a '+' prompt in a console, use ^C instead.

let R_assign = 0		" don't replace _ with <-
let R_rmdchunk = 0		" don't replace ` with ```{r} ``` in .Rmd files
" let R_rnowebchunk = 0	" don't replace < with <<>>= @    in .Rnw files

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
" Ultisnips config {{{2
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
" lightline config {{{2

set noshowmode

let g:lightline = {}
let g:lightline.colorscheme = 'solarized_nomode'
let g:lightline.active = {
  \   'left': [ [ 'mode' ],
  \             [ 'readonly', 'filename', 'modified'] ],
  \ }
let g:lightline.inactive = {
  \   'left': [ [ 'filename_flags' ] ],
  \ }
let g:lightline.component_function = {
  \   'fileformat'   : 'LightlineFileformat',
  \   'fileencoding' : 'LightlineFileencoding',
  \   'filetype'     : 'LightlineFiletype',
  \   'filename_flags' : 'LightlineFilenameFlags',
  \ }


" truncate ff, fenc, ft for narrow windows
function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 60 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 50 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

" join filename with its modifi(ed|able) flags
function! LightlineFilenameFlags()
  let filename = expand('%:t')
  if filename ==# '' | let filename = '[No Name]' | endif
  let mods = ''
  " let mods .= &readonly    ? 'RO' : ''
  let mods .= &modified    ? '+'  : ''
  let mods .= !&modifiable ? '-'  : ''
  return filename . (mods ==# '' ? '' : ' ' . mods)
endfunction

" }}}
" vim-pandoc-syntax {{{2

" use conceal / utf-8 chars for rmd/markdown documents
let g:pandoc#syntax#conceal#use = 1

" disable conceal / utf-8 chars for the following
  " don't replace # in #header
  " don't use smart quotes
  " show ``
  " don't replace ```
  " don't replace ending ```
  " don't hide * for emphasis/strong blocks
let g:pandoc#syntax#conceal#blacklist = [
  \ "atx",
  \ "quotes",
  \ "inlinecode",
  \ "codeblock_start",
  \ "codeblock_delim",
  \ "block",
  \]

" }}}

" tex conceal settings
" let g:tex_conceal = "abdgmsS"
" see h: g:tex_conceal as to the things each alphabet conceals
" change this in tex, markdown, rmd ftplugin files


" NERDTree
nnoremap <silent> <C-n> :<C-u>NERDTreeToggle<CR>

" tagbar
" for .R files
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }

" gutentags: automatic ctags generation
" exclude tagging in the following files
let g:gutentags_ctags_exclude = []
let g:gutentags_ctags_exclude += [
  \ 'Session.vim',
  \ ]

" CtrLP
" basic search modes
let g:ctrlp_types = ['fil', 'buf', 'mru']
" add search modes: search tags, tags in buffer(s)
let g:ctrlp_extensions = ['tag', 'buffertag']
" increase maximum number of results
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:8,results:24'

" for esv_in_vim
source $VIMHOME/macros/esv_api_key.vim

" Autopairs settings
let g:AutoPairsCenterLine = 0		" do not re-center screen after pressing <CR>
let g:AutoPairsMultilineClose = 0	" do not jump past closing delim on another line

" mappings for easy align plugin
if isdirectory($VIMHOME."/pack/bundle/opt/vim-easy-align") || 
  \isdirectory($VIMHOME."/pack/bundle/start/vim-easy-align")

  nmap ga <Plug>(EasyAlign)
  xmap ga <Plug>(EasyAlign)
  nmap gA <Plug>(LiveEasyAlign)
  xmap gA <Plug>(LiveEasyAlign)
  nmap gX <Plug>(LiveEasyAlign)<C-X>
  xmap gX <Plug>(LiveEasyAlign)<C-X>
endif

" mappings for windows transparency (.vim/plugin/*transparent.vim)
if has('gui_running') && 
  \ ( has('win64') || has('win32') )
  let g:transp_default  = 0
  let g:transp_ticksize = 20
  nnoremap <silent> <expr> <C-S-Up>   exists(":Transparency") ? ":\<C-u>Transparency +\<CR>" : ''
  nnoremap <silent> <expr> <C-S-Down> exists(":Transparency") ? ":\<C-u>Transparency -\<CR>" : ''
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
" TODO [2020-05-13]: change statusline and Folded guibg with solarized background swap

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
  " use 'base01.5' solarized color to distinguish folded lines
  " from 'base02' in lightline's statusline
  highlight Folded guibg=#dcd7c8
endif

"" }}}

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see https://sunaku.github.io/vim-256color-bce.html or 
  " http://snk.tuxfamily.org/log/vim-256color-bce.html
set t_ut=
endif


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

" eol and hidden chars {{{1
" --------------------
set wrap		" wrap lines (display)
set linebreak	" don't break lines in between words
if exists("&breakindent") | set breakindent | endif	" wrapped lines preserve indentation
set showbreak=..	" wrapped lines are prepended with ".."

" mapping to toggle wrap
noremap <F3> :set wrap!<CR>
	        \:set wrap?<CR>

" specify how eol and whitespace chars are displayed
set listchars=eol:¬,tab:>\ ,trail:_,extends:>,precedes:<,nbsp:~
if has('patch-7.4.710')
  set listchars+=space:·
endif

" mapping to show/hide these characters
noremap <F4> :set list!<CR>
	        \:set list?<CR>

" show part of last text line in window
set display+=lastline	" eg. a very long line that@@@"
" set display+=truncate

" colors for special chars
if (g:colors_name =~ 'solarized' && 
  \ &background ==# 'light' )
  " meta, special keys, whitespace in list
  hi SpecialKey guifg=#93a1a1
  " showbreak, @, >>, eol
  hi NonText guifg=#93a1a1
endif

" window splits {{{1
" -------------
" don't automatically ^W= after splitting or closing a window
set noequalalways	

" opens splits below, and vsplits to the right
set splitbelow splitright

" use arrow keys to resize splits
nnoremap <expr> <Right> winnr() == winnr('l') ? ( winnr() == winnr('h') ? '' : "\<C-w>".'<' ) : "\<C-w>".'>'
nnoremap <expr> <Left>  winnr() == winnr('l') ? ( winnr() == winnr('h') ? '' : "\<C-w>".'>' ) : "\<C-w>".'<'
nnoremap <expr> <Down>  winnr() == winnr('j') ? ( winnr() == winnr('k') ? '' : "\<C-w>".'-' ) : "\<C-w>".'+'
nnoremap <expr> <Up>    winnr() == winnr('j') ? ( winnr() == winnr('k') ? '' : "\<C-w>".'+' ) : "\<C-w>".'-'

" movement {{{1
" --------

" move full lines with a count supplied, and
"    screen lines without. 
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
vnoremap <expr> j v:count ? 'j' : 'gj'
vnoremap <expr> k v:count ? 'k' : 'gk'

" swap ; and , for f,F,t,T
nnoremap ; ,
nnoremap , ;

" jump forward and back with mouse buttons
nnoremap <X1Mouse> <C-O>
nnoremap <X2Mouse> <C-I>


" edits and inserts {{{1
" -------------------
" key combi to escape from insert mode
" inoremap jk <Esc>
" replaced by moving <Esc>'s keyboard location

" open line(s) and stay in normal mode.

" the code 2 lines below is a macro with keystrokes o, <esc>, k.
" a macro is used to let the remap work with counts.
" nnoremap <C-j> @="o\ek"<CR>
" nnoremap <C-k> @="O\ej"<CR>
" could also use [<Space>, ]<Space>, in vim-unimpaired plugin.
nnoremap <silent> <C-j> :<C-U>call lines#newlinesBelow(v:count1)<CR>
nnoremap <silent> <C-k> :<C-U>call lines#newlinesAbove(v:count1)<CR>

" use a count with 'o' or 'O' to specify how many lines to open
nnoremap <expr> o '<Esc>o' . repeat('<CR>', v:count1 - 1)
nnoremap <expr> O '<Esc>O' . repeat('<CR>', v:count1 - 1) . repeat('<Up>', v:count1 - 1)
" [N]O is not . repeatable

" in insert mode, <BS> ^W etc. is able to delete indents, newlines, 
" and past the starting place of insertion
set backspace=indent,eol,start

" U to _u_njoin lines in normal mode.
" Adds a line break at current char, and
"   stays in normal mode.
" This is dot-repeatable :)
" This masks the 'undo line' feature, (which I never use)
nnoremap U i<CR><Esc>k$


" Use u for t after an operator (UnTil).
" A little easier on the hands
onoremap u t
vnoremap u t

" for changing case of visually selected text, use gu/gU instead
" also to be consistent with gu/gU operators
vnoremap gu u
vnoremap gU U


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


" bracket matching {{{1
" ----------------
" with autopairs plugin	(see AutoPairs setting above)
" and Arpeggio plugin.	(see after/plugin/brackets_arpeggio.vim)


" quick comment {{{1
" -------------

" comment_leader can be specified by user, or extracted from 'commentstring' or 'comment' options.
augroup qcomment
  autocmd!
  autocmd FileType c,cpp,java,scala	let b:comment_leader = '// '
  autocmd FileType sh,python,r		let b:comment_leader = '# '
  autocmd FileType conf,fstab		let b:comment_leader = '# '
  autocmd FileType tex			let b:comment_leader = '% '
  autocmd FileType mail			let b:comment_leader = '> '
  autocmd FileType autohotkey		let b:comment_leader = '; '
  autocmd FileType vim			let b:comment_leader = '" '
  autocmd FileType snippets		let b:comment_leader = '# '
  autocmd FileType gitconfig		let b:comment_leader = '# '
augroup END

augroup qbcomment
  autocmd!
  autocmd Filetype rmd,markdown		let b:block_comment_marks = ['<!--', '-->']
augroup END

" cm / cx to comment / uncomment current line
omap <expr> m v:operator ==# 'c' ? "\<Esc>"."\<Plug>(AddComment)".'_' : 'm'
omap <expr> x v:operator ==# 'c' ? "\<Esc>"."\<Plug>(RmComment)".'_' : 'x'

" [\cm|\cx|\bm|\bx]{motion} to 
" comment|uncomment|block comment|block uncomment lines specified by {motion}
nmap <leader>cm <Plug>(AddComment)
nmap <leader>cx <Plug>(RmComment)
nmap <leader>bm <Plug>(AddBlockComment)
nmap <leader>bx <Plug>(RmBlockComment)
vmap <leader>cm <Plug>(VAddComment)
vmap <leader>cx <Plug>(VRmComment)
vmap <leader>bm <Plug>(VAddBlockComment)
vmap <leader>bx <Plug>(VRmBlockComment)


" cp / cP to copy and comment cur line (normal mode)
omap <expr> p v:operator ==# 'c' ? "\<Esc>"."\<Plug>(ComACop)"  : 'p'
omap <expr> P v:operator ==# 'c' ? "\<Esc>"."\<Plug>(ComACopA)" : 'P'

" \cp / \cP to copy and comment motion / visual selection
" TODO [2020-01-30]: operator for comment-a-copy
" nmap <leader>cp ...
vmap <leader>cp <Plug>(VComACop)
vmap <leader>cP <Plug>(VComACopA)


" folding {{{1
" -------
set foldenable		" enable folding
set foldlevelstart=5	" fold levels >=5 are unfolded (shown)
set fillchars+=fold:\ 	" do not fill folding lines with trailing '-'

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
command! -bang -nargs=* -complete=file E e<bang> <args>

" :help related
" -------------
" :H may overwrite :Hexplore
command! -bang -nargs=? -complete=help H h<bang> <args>
command! -bang -nargs=? -complete=help Vh vert h<bang> <args>
command! -bang -nargs=? -complete=help VH vert h<bang> <args>
command! -bang -nargs=? -complete=help Th tab h<bang> <args>
command! -bang -nargs=? -complete=help TH tab h<bang> <args>

" split view with conceal {{{2
" -----------------------
" eg., viewing tex source code alongside a more readable version
command! Cview 
  \  set scrollbind 
  \| vert split 
  \| set conceallevel=2 concealcursor=nc scrollbind 
  \| wincmd p

"}}}


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

let g:textobj_entire_no_default_key_mappings = 1
omap aE <Plug>(textobj-entire-a)
omap iE <Plug>(textobj-entire-i)
xmap aE <Plug>(textobj-entire-a)
xmap iE <Plug>(textobj-entire-i)

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
