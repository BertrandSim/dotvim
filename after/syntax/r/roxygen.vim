" Don't mask roxygen block rOBlock syntax highlighting
" redefine these syntax regions again, 
" as they have been masked by syn match rOTitle.
" XXX [2020-03-09] PR has been submitted on github... merged!
finish

if g:r_syntax_hl_roxygen
  " When a roxygen block has a title and additional content, the title
  " consists of one or more roxygen lines (as little as possible are matched),
  " followed either by an empty roxygen line
  syn region rOBlock start="\%^\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*$" end="^\s*\(#\{1,2}'\)\@!" contains=rOTitle,rOTag,rOExamples,@Spell keepend fold
  syn region rOBlock start="^\s*\n\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*$" end="^\s*\(#\{1,2}'\)\@!" contains=rOTitle,rOTag,rOExamples,@Spell keepend fold

  " or by a roxygen tag (we match everything starting with @ but not @@ which is used as escape sequence for a literal @).
  syn region rOBlock start="\%^\(\s*#\{1,2}' .*\n\)\{-}\s*#\{1,2}' @\(@\)\@!" end="^\s*\(#\{1,2}'\)\@!" contains=rOTitle,rOTag,rOExamples,@Spell keepend fold
  syn region rOBlock start="^\s*\n\(\s*#\{1,2}' .*\n\)\{-}\s*#\{1,2}' @\(@\)\@!" end="^\s*\(#\{1,2}'\)\@!" contains=rOTitle,rOTag,rOExamples,@Spell keepend fold
endif


" 1) As stated above, rOBlock should be declared after rOTitle
" 2) For rO*Block*'s, match should not include blank line.
"  I tried to work around this through \zs, 
"  but as :h :syn-multi-line states, 
"  > the start of match is not allowed to start in a following line

" vim: ts=8 sw=2: foldmethod=marker 
