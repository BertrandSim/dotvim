" enable vim filetype detection for files named dot_* (in place of .*)

autocmd BufRead,BufNewFile dot_Rprofile     setfiletype r
autocmd BufRead,BufNewFile dot_bash_aliases setfiletype sh
autocmd BufRead,BufNewFile dot_gitconfig    setfiletype gitconfig
autocmd BufRead,BufNewFile dot_inputrc      setfiletype readline
