" Code folding options, using custom syntax
" see .vim/after/syntax/r/r_after.vim

autocmd Filetype r setlocal foldmethod=syntax

let g:r_syn_fold = {
  \ 'paren' : 0,
  \ 'curly' : 0,
  \ 'brace' : 0,
  \ 'section' : 1,
  \ 'funcArgs' : 1,
  \ 'funcBody' : 1,
\}

