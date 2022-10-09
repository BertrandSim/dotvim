" Important {{{1
" ---------

set nocompatible

filetype plugin indent on
" turns on filetype detection, and loads filetype-specific plugins and indent files
" see :help filetype-overview

set encoding=utf-8		" the encoding displayed.
set fileencoding=utf-8	" the encoding written to file.

set fileformats=unix,dos	" use unix (line endings) by default, o/w try dos

set nrformats=bin,hex	" get rid of octal annoyance for ^a/^x 
" also consider absolute values only, eg. -2 gets treated as 2. Useful for dates
if has('patch-8.2.0860')
  set nrformats+=unsigned	
endif
  

if has('patch-7.4.793')
  set belloff=all	" turn off audio error bells
endif

" filepaths and dirs {{{1
" ------------------
" point $VIMHOME to .vim directory 
" ( = dir containing this vimrc file)
let $VIMHOME = expand('<sfile>:p:h')

" _c_hange _d_irectory to that of _c_urrent file with :CDC
command CDC lcd %:p:h


" localvim settings {{{1
" -----------------
" add .localvim to rtp if it exists
" and source .localvim/localvimrc if it exists
if isdirectory('.localvim')
  let &rtp .= ','.getcwd().'/.localvim'
  if filereadable('.localvim/localvimrc')
	source .localvim/localvimrc
  endif
endif


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

" helper func for vim-plug conditional activation
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" call plug#begin('~/.vim/plugged')
call plug#begin($VIMHOME.'/plugged')

  " core:
Plug 'lifepillar/vim-solarized8'		" solarized8 colorscheme
Plug 'BertrandSim/vim-unimpaired'		" handy pairs of mappings, forked from tpope
Plug 'itchyny/lightline.vim'			" lean status line
Plug 'SirVer/ultisnips',
  \ Cond(v:version >= 704, { 'tag': '3.2' })		" snippets; v3.2 on Nov 2019
Plug 'junegunn/vim-easy-align'			" align lines by a char/regex
Plug 'machakann/vim-sandwich'			" surroundings
Plug 'rhysd/clever-f.vim',
  \ { 'commit' : 'e852984' }			" highlight f matches and repeat with f/F
Plug 'justinmk/vim-sneak'				" 2-char f/t-like motion
Plug 'machakann/vim-columnmove',
  \ { 'commit' : '21a43d8' }			" column-wise w,b,e,ge,f,t motions
Plug 'BertrandSim/vim-arpeggio', 
  \ { 'branch': 'tmap' }				" key chords, forked to support Arpeggio in terminal mode
Plug 'andymass/vim-matchup'				" navigate and highlight matching pairs

  " ft specific:
Plug 'masukomi/vim-markdown-folding'	" expr-folding of markdown files
Plug 'vim-pandoc/vim-pandoc-syntax'		" syntax highlighting for markdown and related files
Plug 'jalvesaq/Nvim-R',
  \ Cond( has('patch-8.1.1705'), 
  \ { 'branch' : 'master' })			" interaction between R scripts with R terminal
  " \ { 'branch' : 'stable' })			
Plug 'jalvesaq/R-Vim-runtime'			" keep vim R files up to date
Plug 'lervag/vimtex',
  \ Cond(has('patch-7.4.52'),
  \ { 'tag' : 'v2.10' })				" plugin for tex
Plug 'sersorrel/vim-lilypond'			" lilypond runtime files 

  " text objects:
Plug 'b4winckler/vim-angry'				" function argument text object
Plug 'kana/vim-textobj-user',
  \ Cond(v:version >= 704)				" custom text objects
Plug 'kana/vim-textobj-entire',
  \ Cond(v:version >= 704)				" entire buffer 
Plug 'kana/vim-textobj-line',
  \ Cond(v:version >= 704)				" current line (char-wise / linewise)

  " git integration:
Plug 'tpope/vim-fugitive'				" git wrapper for vim
Plug 'BertrandSim/gv.vim'				" git commit browser in vim
Plug 'itchyny/vim-gitbranch'			" show current git branch

  " search and navigation:
Plug 'preservim/nerdtree',				" file explorer in vim
  \{ 'on': 'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'				" fuzzy finder
Plug 'majutsushi/tagbar'				" show tags on a side margin
Plug 'ludovicchabant/vim-gutentags'		" automatically generate tags
Plug 'kshenoy/vim-signature'			" show marks in signs column (left gutter)

  " misc and backups:
Plug 'simnalamburt/vim-mundo'			" graphical undo tree
Plug 'haya14busa/incsearch.vim'			" improved / ? incsearch
Plug 'chrisbra/Colorizer', 
  \{ 'on': ['ColorHighlight'] }			" show color codes and names in vim
Plug 'BertrandSim/auto-pairs',
  \{ 'on': [] }							" pairs of delims, forked from jiangmiao/auto-pairs.
										"   superceded by brackets_arpeggio.vim, and pairspace.vim

call plug#end()

" plugin configs {{{1
" --------------
"
" TODO [2020-01-02]: setup sandwich exchange / cycle within same recipe group
" TODO [2022-07-07]: find a map (or a command) for toggling frac. current: 'stf'
" TODO [2022-07-07]: decide which text-objects to keep (see :h vimtex-features)
"   [c]ommands/ [d]elimiters/ [e]nvironments/ math environments [$]/ sections [P]/ items [m]

" vimtex settings {{{2

" use Sumatra as pdfviewer
let g:vimtex_view_general_viewer = 'SumatraPDF'
" setup forward search
let g:vimtex_view_general_options
	  \ = '-reuse-instance -forward-search @tex @line @pdf'
" for inverse search (backward search), enter this in SumatraPDF:
"   `vim -v --not-a-term -T dumb -c "VimtexInverseSearch %l '%f'"`
"   as seen in :h :VimtexInverseSearch .
" open in a new tab for a backward search
let g:vimtex_view_reverse_search_edit_cmd = 'tabedit'

" use single shot compilation instead of continuous mode
if !exists('g:vimtex_compiler_latexmk') |
  let g:vimtex_compiler_latexmk = {}
endif
let g:vimtex_compiler_latexmk.continuous = 0

" use pplatex to preprocess latexlog output
let g:vimtex_quickfix_method = 'pplatex'

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

" st$ cycles through math envs 
"   $ -> \[ -> equation -> $
let g:vimtex_env_toggle_math_map = {
  \ '$': '\[',
  \ '\[': 'equation',
  \ 'equation': '$',
  \ '\(': '$',
  \ '$$': '\[',
  \}


" Use sandwich.vim-style mappings for ds,cs,ts --> sd, se, st/sT
" temporary solution while transiting to sandwich.vim [TODO]
if isdirectory($VIMHOME."/plugged/vimtex")

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
	autocmd Filetype tex nmap st$ <plug>(vimtex-env-toggle-math)
	autocmd Filetype tex nmap std <plug>(vimtex-delim-toggle-modifier)
	autocmd Filetype tex xmap std <plug>(vimtex-delim-toggle-modifier)
	autocmd Filetype tex nmap sTd <plug>(vimtex-delim-toggle-modifier-reverse)
	autocmd Filetype tex xmap sTd <plug>(vimtex-delim-toggle-modifier-reverse)
	autocmd Filetype tex nmap stf <plug>(vimtex-cmd-toggle-frac)
	autocmd Filetype tex xmap stf <plug>(vimtex-cmd-toggle-frac)
  augroup END
endif

let g:vimtex_mappings_disable = {
  \   'n': [
  \      'dse', 'dsc', 'ds$', 'dsd', 
  \      'cse', 'csc', 'cs$', 'csd', 
  \      'tse', 'tsc', 'ts$', 'tsd', 'tsD', 'tsf',
  \   ],
  \   'x': ['tsd', 'tsD', 'tsf']
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
" matchup settings {{{2
" ----------------
" don't show offscreen matches
let g:matchup_matchparen_offscreen = {}

" }}}
" sandwich config {{{2
" ---------------
if isdirectory($VIMHOME."/plugged/vim-sandwich")

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
if isdirectory($VIMHOME."/plugged/Nvim-R")

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

" convenience commands
command! USRS call UltiSnips#RefreshSnippets()
command! USEdit UltiSnipsEdit

" }}}
" lightline config {{{2

set noshowmode

let g:lightline = {}
let g:lightline.colorscheme = 'solarized_nomode'
let g:lightline.active = {
  \   'left': [ [ 'mode' ],
  \             [ 'filename_commit', 'flags'],
  \             [ 'gitbranch' ] ],
  \ }

let g:lightline.inactive = {
  \   'left': [ [ 'filename_commit_flags' ] ],
  \ }

" truncate _after_ the displayed mode and filename
let g:lightline.component = {
  \   'gitbranch' : '%<%{LightlineGitBranch()}',
  \
  \   'lineinfo'  : '%3l:%-2(%c%V%)',
  \ }
  " if statusline {% re-evaluation is supported,
  " \   'filename_commit'       : '%{%LightlineFilenameCommit()%}',
  " \   'lineinfo'  : '%3l:%-2(%{%"%c%V"%}%)',

let g:lightline.component_function = {
  \   'filename_commit'       : 'LightlineFilenameCommit',
  \   'filename_commit_flags' : 'LightlineFilenameCommitFlags',
  \   'flags'                 : 'LightlineFlags',
  \
  \   'fileformat'   : 'LightlineFileformat',
  \   'fileencoding' : 'LightlineFileencoding',
  \   'filetype'     : 'LightlineFiletype',
  \ }

" truncate ff, fenc, ft for narrow windows
function! LightlineFileformat()
  return winwidth(0) > 80 ? &fileformat : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 60 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction


" filename, git HEAD, and related components {{{

" helpers {{{

" current filename without dir | [No Name]
function! s:llfilename()
  " simply return '%t' if vim supports {% re-evaluation
  return expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

" readonly and modifi(ed|able) flags
function! s:llflags(active)
  let flags = ''
  if a:active
    let flags .= &readonly    ? 'RO' : ''
  endif
  let flags .= &modified    ? '+'  : ''
  let flags .= !&modifiable ? '-'  : ''
  return flags
endfunction

" check if filename string matches a fugitive commit
" 'fugitive://{dir_path}.git//{commit_hash}[/{file_name}]'
function! s:isFugitiveCommit(string, partial)
  let endchar = a:partial ? '[\/]' : '$'
  return a:string =~ '^fugitive:///\=.\{-}\.git//\x\+'.endchar
endfunction

" }}}

" shortened commit hash, otherwise filename
function! LightlineFilenameCommit()
  let filename = expand('%')
  if s:isFugitiveCommit(filename, 0)
    return matchstr(filename, '\x\+$')[0:6]
  else
    return s:llfilename()
endfunction

" RO+-
function! LightlineFlags()
  return s:llflags(1) 
endfunction

" join filename/commit hash with its modifi(ed|able) flags
function! LightlineFilenameCommitFlags()
  let filename = LightlineFilenameCommit()
  let flags = s:llflags(0) " +-, no RO shown
  return filename . (flags ==# '' ? '' : ' ' . flags)
endfunction

" current file's commit dir, otherwise current HEAD
function! LightlineGitBranch()
  let filename = expand('%')
  if s:isFugitiveCommit(filename, 1)
    return matchstr(filename, '\.git//\zs\x\+')[0:6]
  else
    return gitbranch#name()
    " return FugitiveHead(7)
endfunction

" }}}

" update lightline colorscheme when background is changed 
" to use light/dark variant.
" see github issue #424
augroup lightline-bg
  autocmd!
  autocmd OptionSet background
	\ execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/'.g:lightline.colorscheme.'.vim')
	\ | call lightline#colorscheme() 
	\ | call lightline#update()
augroup END

" tabline
let g:lightline.tab = {
		    \ 'active': [ 'tabnum', 'filename', 'modified' ],
		    \ 'inactive': [ 'tabnum', 'filename', 'numsplitmodified' ] }

let g:lightline.tab_component_function = {
		      \ 'modified': 'LightlineTabModified', 
		      \ 'numsplitmodified': 'LightlineTabNumSplitModified' }

function! LightlineTabModified_0(tabnum)
  let bufnrlist = tabpagebuflist(a:tabnum)
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      return v:true
	  " break
    endif
  endfor
  return v:false
endfunction

function! LightlineTabModified(tabnum)
  return LightlineTabModified_0(a:tabnum) ? '+' : ''
endfunction

function! LightlineTabNumSplitModified(tabnum)
  let tabnumwin = tabpagewinnr(a:tabnum, '$')
  let tabmodified = LightlineTabModified_0(a:tabnum)
  return (tabnumwin == 1 ? '' : '<'.tabnumwin.'>') . (tabmodified ? '+' : '')
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
" vim-sneak settings {{{2

map K <Plug>Sneak_s
map M <Plug>Sneak_S

" use smartcase
let g:sneak#use_ic_scs = 1	

" label mode
let g:sneak#label = 1
" " use labels that are unlikely to be used in the next command
" let g:sneak#target_labels = 'fjklwetunq/SFGHLTUNRMQZ?0'
" use numeric labels, which will mostly not be used in the next command (unless a count is needed)
let g:sneak#target_labels = '234567890'

" highlighting
" highlight link SneakScope Cursor
highlight link SneakLabel Folded
" highlight link Sneak Folded

augroup hl-vim-sneak
  autocmd!
  autocmd ColorScheme * highlight link SneakLabel Folded
augroup END

" }}}
" clever-f settings {{{2

" let f always go forward, F always backward
let g:clever_f_fix_key_direction = 1

" " exit ongoing f-search after some time
" let g:clever_f_timeout_ms = 2000
" let g:clever_f_highlight_timeout_ms = 2000

" exit ongoing f-search with <Esc>
exe '
  \nnoremap <silent> <Esc> :<C-u>call clever_f#reset()<CR>
  \' . maparg('<Esc>', 'n')
  " maparg() extends an existing mapping (if any)

" show matching chars, with a specific color/highlighting
let g:clever_f_mark_char = 1 
let g:clever_f_mark_char_color = 'CleverFDefaultLabel'
highlight link CleverFDefaultLabel MatchParen

" show directly reachable chars, with a specific color/highlighting
let g:clever_f_mark_direct = 1 
let g:clever_f_mark_direct_color = 'CleverFDirectLabel'

augroup hl-clever-f
  autocmd!
  autocmd ColorScheme * :call s:clever_f_mark_direct_hl_init()
augroup END

function! s:clever_f_mark_direct_hl_init()
  let s:guifg = synIDattr(synIDtrans(hlID('Underlined')), 'fg', 'gui')  "purple fg #6c71c4
  let s:guibg = synIDattr(synIDtrans(hlID('Pmenu')), 'bg', 'gui')  " greyish bg #eee8d5
  " let s:gui = 'bold,underline'
  if &background ==# 'light'
    let s:gui = 'underline'
  else 
    let s:gui = 'bold'
  endif
  exe 'highlight CleverFDirectLabel guifg='.s:guifg.' guibg='.s:guibg.' gui='.s:gui
endfunction


" }}}
" gv.vim {{{2

" shortcuts
" git log --graph --all [--simplify-by-decoration]
if isdirectory($VIMHOME."/plugged/gv.vim")
  command! -bang -nargs=* GVA  GV<bang> --all <args>
  command! -bang -nargs=* GVAD GV<bang> --all --simplify-by-decoration <args>
endif

" }}}
" vim-columnmove settings {{{2

" define own mappings
let g:columnmove_no_default_key_mappings = 1

" up to the start of para
map H <Plug>(columnmove-b)
map L <Plug>(columnmove-e)
" down to the end of para

let g:columnmove_strict_wbege = 0 
" only check blank lines, not keywords
let g:columnmove_stop_on_space = 1
" allow stopping on spaces in the first/last line of a para

" similar to above, but can be used to 
"   skip over leading spaces (indent spaces)
" probably due to columnmove-WBEgE not 
"   being affected by g:columnmove_stop_on_space
map gh <Plug>(columnmove-B)
map gl <Plug>(columnmove-E)

" }}}


" tex conceal settings -> superseded by vimtex 2.0
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
" exclude files in .gitignore
let g:gutentags_file_list_command = {
  \ 'markers': {
  \   '.git': 'git ls-files',
  \ },
  \}

" vim-signature: show marks in side column
" use omap for 'dm' mapping
let g:SignatureMap = {'DeleteMark' : ''}	" remove normal-mode mapping
" see 'nmaps to omaps' below 

" CtrlP
" basic search modes
let g:ctrlp_types = ['fil', 'buf', 'mru']
" add search modes: search tags, tags in buffer(s)
let g:ctrlp_extensions = ['tag', 'buffertag']
" allow project-specific .ctrlpignore file
let g:ctrlp_extensions += ['autoignore']
" increase maximum number of results
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:8,results:24'

" Mundo
nnoremap <F6> :<C-U>MundoToggle<CR>
let g:mundo_verbose_graph = 0	" use shorter graph to save space
let g:mundo_inline_undo = 0		" don't show inline diffs inside graph 
								"  (default, toggle with `i`)
  " see also after/ftplugin/Mundo.vim
  " see also undo settings

" for esv_in_vim
source $VIMHOME/macros/esv_api_key.vim

" mappings for easy align plugin
if isdirectory($VIMHOME."/plugged/vim-easy-align")

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


" file related settings {{{1
" ---------------------
" use '/' for file paths, even on windows (instead of '\')
set shellslash	" set this after plug#begin()

" do not treat '{' or '}' as part of a filename
set isfname-={
set isfname-=}


" undo {{{1
" ----
if has('persistent_undo')
  " use persistent undo
  set undofile        
  set undolevels=200
  " place undo files in ~/.vim/.undo
  " and save them with their corresponding full paths ('//')
  if !isdirectory($VIMHOME."/.undo")
	call mkdir($VIMHOME."/.undo")
  endif
  let &undodir=$VIMHOME."/.undo//"
endif

" UI {{{1
" -------
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

" spell {{{1
" ----------

" limit the number of spelling suggestions
" (so that `z=` does not take up the whole screen  )
set spellsuggest+=12 
" For a script shows results on the cli (not on the pager),
" see https://vi.stackexchange.com/a/19681/21495

" quickly fix last word before cursor with 'sp' 
" and return to previous position
nnoremap sp [s1z=<C-O>


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
  highlight Folded guibg=#dcd7c8
endif

augroup hl-solarized-folded-bg
  autocmd!
  autocmd OptionSet background call s:hl_solarized_folded()
  autocmd ColorScheme solarized8* call s:hl_solarized_folded()
augroup END


function! s:hl_solarized_folded()
  " use 'base01.5' solarized color to distinguish folded lines
  "   vs 'base02' in lightline's statusline
  if g:colors_name =~ 'solarized8'
    if &background == 'light'
      highlight Folded guibg=#dcd7c8
    else
      highlight Folded guibg=#204554
    endif
  endif
endfunction

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

" yp / yP to yank and paste cur line 
" (short for yyp / yyP)
" see 'nmaps to omaps' below 


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

" turn off search highlighting with \<space> or <Esc>
nnoremap <leader><space> :nohlsearch<CR>
" nnoremap <leader><space> :let @/=""<CR>

exe '
  \nnoremap <silent> <Esc> :<C-u>nohlsearch<CR>
  \' . maparg('<Esc>', 'n')
  " maparg() extends an existing mapping (if any)

" n/N always searches forward/backward. 
" respects 'foldopen' and shows search count [n/nn]
nnoremap n :<C-u>call feedkeys(v:count1 . (v:searchforward ? 'n' : 'N'), 'nt')<CR>
nnoremap N :<C-u>call feedkeys(v:count1 . (v:searchforward ? 'N' : 'n'), 'nt')<CR>
" these don't 'foldopen'
  " nnoremap <expr> n (v:searchforward ? 'n':'N') 
  " nnoremap <expr> N (v:searchforward ? 'N':'n')
" these don't show search count [n/nn]
" From vi.se/*/how-can-i-get-n-to-go-forward-even-if-*
  " nnoremap <expr> n (v:searchforward ? 'n':'N') . (&foldopen=~'search\\|all' ? 'zv' : '')
  " nnoremap <expr> N (v:searchforward ? 'N':'n') . (&foldopen=~'search\\|all' ? 'zv' : '')
  " nnoremap <expr> n 'Nn'[v:searchforward].(&foldopen=~'search\\|all'?'zv':'')
  " nnoremap <expr> N 'nN'[v:searchforward].(&foldopen=~'search\\|all'?'zv':'')

" highlight search matches without jumping to it
" nnoremap z/ :let @/=""<Left>
" replaced with incsearch.vim

" incsearch.vim 
if isdirectory($VIMHOME."/plugged/incsearch.vim")

  " map / <Plug>(incsearch-forward)
  " map ? <Plug>(incsearch-backward)

  " highlight search matches without jumping to it
  map z/ <Plug>(incsearch-stay)

  " let n always search forward, N always backward
  let g:incsearch#consistent_n_direction = 1
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

" enter search with word boundaries \<...\>
nnoremap g/ /\<\><Left><Left>
" nmap <expr> gz/ incsearch#go({'command': '/', 'pattern': '\<', 'is_stay': 1 })
" nmap <expr> gz/ incsearch#go({'command': '/', 'pattern': '\<\>', 'is_stay': 1 })."\<Left>\<Left>" "doesn't work

" search between marks
" use '>< {snippet-trigger}' in search (/?)

" search within visual selection
" use 'VV {snippet-trigger}' in search (/?)


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


" quick comment {{{1
" -------------

" comment_leader can be specified by user, or extracted from 'commentstring' or 'comment' options.
augroup qcomment
  autocmd!
  autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
  autocmd FileType sh,python,r      let b:comment_leader = '# '
  autocmd FileType conf,fstab       let b:comment_leader = '# '
  autocmd FileType tex              let b:comment_leader = '% '
  autocmd FileType mail             let b:comment_leader = '> '
  autocmd FileType autohotkey       let b:comment_leader = '; '
  autocmd FileType vim              let b:comment_leader = '" '
  autocmd FileType snippets         let b:comment_leader = '# '
  autocmd FileType gitconfig        let b:comment_leader = '# '
augroup END

augroup qbcomment
  autocmd!
  autocmd Filetype rmd,markdown		let b:block_comment_marks = ['<!--', '-->']
augroup END

" cm / cx to comment / uncomment current line
" see 'nmaps to omaps' below 

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
" see 'nmaps to omaps' below 

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

" :Vsb, short for :vert :sb
" command! -count -addr=buffers -nargs=* -complete=buffer Vsb vertical
" <count>sbuffer <args>	" does not work if no count given
command! -nargs=* -complete=buffer Vsb vertical sbuffer <args>
command! -nargs=* -complete=buffer VSb vertical sbuffer <args>

" :Less, a better vim pager
" from https://www.reddit.com/r/vim/comments/xvhw4w/comment/ir5pljt/
" -------------------------
command! -nargs=+ -complete=command Less call Less(win_getid(), <q-mods>, <q-args>)

function! Less(winid, mods, args) abort
  execute (len(a:mods) ? a:mods . ' new' : 'botr 20new')
  call setline(1,split(win_execute(a:winid, a:args),"\n"))
  setl bt=nofile bh=wipe nobl nomod
endfunction

" split view with conceal {{{1
" -----------------------
" eg., viewing tex source code alongside a more readable version
command! Cview 
  \  set scrollbind 
  \| vertical split 
  \| set conceallevel=2 concealcursor=nc scrollbind 
  \| wincmd p

" cmdline + Ultisnips {{{1
" -------------------
" quick expand snippet via cmdline window
cnoremap ;: <C-r>=&cedit<CR>:startinsert<CR><C-r>=UltiSnips#ExpandSnippet()<CR>

" change <Tab> from cmdline-completion to snippet expansion
" by unmapping <Tab>.
augroup cmdline_window
    autocmd!
    autocmd CmdWinEnter [:>] silent! iunmap <buffer> <Tab>
    autocmd CmdWinEnter [:>] silent! nunmap <buffer> <Tab>
augroup END

" see UltiSnips/all_vim_cmdline.snippets for the snippets themselves

" }}}
" Ultisnips snippet operator {{{1
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


" 2022-09-22: also consider wrapping with some ultisnips snippet custom {trigger}:
" vnoremap <c-e> :<c-u>call UltiSnips#SaveLastVisualSelection()<CR>gvs{trigger}<C-R>=UltiSnips#ExpandSnippet()<CR>

" }}}
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

" nmaps to omaps {{{1
" --------------------
" compound mappings beginning with an operator (eg. c/d/y)
" to be switched to operator pending mappings

" cm/cx -> comment/uncomment line
" cp/cP -> comment line and put below/above
" yp/yP -> yank line and put below/above
" dm -> remove mark (vim-signature)
omap <expr> <silent> m 
  \ v:operator ==# 'c' ? "\<Esc>"."\<Plug>(AddComment)".'_' : 
  \ v:operator ==# 'd' ? "\<Esc>".":\<C-U>call signature#utils#Remove(v:count)\<CR>" : 
  \ 'm'
omap <expr> x v:operator ==# 'c' ? "\<Esc>"."\<Plug>(RmComment)".'_' : 'x'
omap <expr> p 
  \ v:operator ==# 'c' ? "\<Esc>"."\<Plug>(ComACop)" : 
  \ v:operator ==# 'y' ? "\<Esc>"."yy".v:count1."p" : 
  \ 'p'
omap <expr> P 
  \ v:operator ==# 'c' ? "\<Esc>"."\<Plug>(ComACopA)" : 
  \ v:operator ==# 'y' ? "\<Esc>"."yy".v:count1."P" : 
  \ 'P'

" misc {{{1
" ----
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
