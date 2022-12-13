" overwrite VimTeX's indent keys
" by preceding most with '0', 
" so that indent only applies if those keys are typed at the start of line
" merged as of 2021-10-29
" but reverted as of 2022-02-19

setlocal indentkeys=!^F,o,O,0(,0),0],0},\&,0=\\item,0=\\else,0=\\fi

" Add standard closing math delimiters to indentkeys
for s:delim in [
      \ 'rangle', 'rbrace', 'rvert', 'rVert', 'rfloor', 'rceil', 'urcorner']
  let &l:indentkeys .= ',0=\' . s:delim
endfor
