" run commands for Vim GUIs

set guifont=Consolas:h12:cANSI:qDRAFT
set lines=30 columns=120

if has('win64') || has('win32')
      set winaltkeys=no
      " don't use ALT to access the gui menu
      " use :simalt <key> instead. (see :h :simalt)
endif

" see also plugin for windows transparency    (.vim/plugin/*transparent.vim)
" see also plugin for adjusting gui font size (.vim/plugin/guifont_zoom.vim)

