" run commands for Vim GUIs

set lines=30 columns=120		" window size (nr of chars)
set guicursor+=n:blinkon0		" don't blink the cursor in normal mode
set guicursor+=v:hor20-Cursor-blinkon0	" use '_' cursor in visual mode, don't blink

if has('gui_win32')
  set guifont=Consolas:h12:cANSI:qDEFAULT	" font for display: font family, size, ...
  let &printfont=&guifont			" font for printing
endif

if has('win64') || has('win32')
      set winaltkeys=no
      " don't use ALT to access the gui menu
      " use :simalt <key> instead. (see :h :simalt)
      set guioptions+=!
      " run external commands in vim, 
      " instead of a separate terminal window
endif

set guioptions-=m 	" don't show the menu bar
" set guioptions-=T 	" don't show the toolbar

" see also plugin for windows transparency    (.vim/plugin/*transparent.vim)
" see also plugin for adjusting gui font size (.vim/plugin/guifont_zoom.vim)

