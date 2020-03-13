" enduser commands for getting syntax group / syntax stack
" at a cursor's [or given] location
command! -nargs=* SynGroup echo syntax_get#synGroup(<f-args>)
command! -nargs=* SynStack echo syntax_get#synStack(<f-args>)
