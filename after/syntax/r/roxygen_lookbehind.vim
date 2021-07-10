" modified roxygen syntax:
"   use a lookbehind (\@<=) for new lines above (^\s*\n)
"   combined \%^ and \(^\s*\n\)\@<= into branch regex -> \(\%^\|^\s*\n\)\@<=
"   move syntax definitions that start with #', ##' before rOBlock*, rOTitle*, due to :h:syn-priority

" XXX [2021-07-07] PR has been submitted on github... merged!
finish

" clear these to redefine them again below
syn clear rOTitleBlock
syn clear rOTitle
syn clear rOBlock
syn clear rOBlockNoTitle

" Roxygen
if g:r_syntax_hl_roxygen
  " A roxygen block can start at the beginning of a file (first version) and
  " after a blank line (second version). It ends when a line that does not
  " contain a roxygen comment. In the following comments, any line containing
  " a roxygen comment marker (one or two hash signs # followed by a single
  " quote ' and preceded only by whitespace) is called a roxygen line. A
  " roxygen line containing only a roxygen comment marker, optionally followed
  " by whitespace is called an empty roxygen line.

  " place these above rOBlock*, rOTitle*, due to :h:syn-priority
  syn match rOCommentKey "^\s*#\{1,2}'" contained
  syn region rOExamples start="^#\{1,2}' @examples.*"rs=e+1,hs=e+1 end="^\(#\{1,2}' @.*\)\@=" end="^\(#\{1,2}'\)\@!" contained contains=rOTag fold

  " First we match all roxygen blocks as containing only a title. In case an
  " empty roxygen line ending the title or a tag is found, this will be
  " overridden later by the definitions of rOBlock.
  " syn match rOTitleBlock "\%^\(\s*#\{1,2}' .*\n\)\{1,}" contains=rOCommentKey,rOTitleTag
  " syn match rOTitleBlock "\(^\s*\n\)\@<=\(\s*#\{1,2}' .*\n\)\{1,}" contains=rOCommentKey,rOTitleTag
  syn match rOTitleBlock "\(\%^\|^\s*\n\)\@<=\(\s*#\{1,2}' .*\n\)\{1,}" contains=rOCommentKey,rOTitleTag

  " A title as part of a block is always at the beginning of the block, i.e.
  " either at the start of a file or after a completely empty line.
  " syn match rOTitle "\%^\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*$" contained contains=rOCommentKey,rOTitleTag
  " syn match rOTitle "\(^\s*\n\)\@<=\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*$" contained contains=rOCommentKey,rOTitleTag
  syn match rOTitle "\(\%^\|^\s*\n\)\@<=\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*$" contained contains=rOCommentKey,rOTitleTag
  syn match rOTitleTag contained "@title"

  " When a roxygen block has a title and additional content, the title
  " consists of one or more roxygen lines (as little as possible are matched),
  " followed either by an empty roxygen line
  " syn region rOBlock start="\%^\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*$" end="^\s*\(#\{1,2}'\)\@!" contains=rOTitle,rOTag,rOExamples,@Spell keepend fold
  " syn region rOBlock start="\(^\s*\n\)\@<=\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*$" end="^\s*\(#\{1,2}'\)\@!" contains=rOTitle,rOTag,rOExamples,@Spell keepend fold
  syn region rOBlock start="\(\%^\|^\s*\n\)\@<=\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*$" end="^\s*\(#\{1,2}'\)\@!" contains=rOTitle,rOTag,rOExamples,@Spell keepend fold

  " or by a roxygen tag (we match everything starting with @ but not @@ which is used as escape sequence for a literal @).
  " syn region rOBlock start="\%^\(\s*#\{1,2}' .*\n\)\{-}\s*#\{1,2}' @\(@\)\@!" end="^\s*\(#\{1,2}'\)\@!" contains=rOTitle,rOTag,rOExamples,@Spell keepend fold
  " syn region rOBlock start="\(^\s*\n\)\@<=\(\s*#\{1,2}' .*\n\)\{-}\s*#\{1,2}' @\(@\)\@!" end="^\s*\(#\{1,2}'\)\@!" contains=rOTitle,rOTag,rOExamples,@Spell keepend fold
  syn region rOBlock start="\(\%^\|^\s*\n\)\@<=\(\s*#\{1,2}' .*\n\)\{-}\s*#\{1,2}' @\(@\)\@!" end="^\s*\(#\{1,2}'\)\@!" contains=rOTitle,rOTag,rOExamples,@Spell keepend fold

  " If a block contains an @rdname, @describeIn tag, it may have paragraph breaks, but does not have a title
  " syn region rOBlockNoTitle start="\%^\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*\n\(\s*#\{1,2}'.*\n\)\{-}\s*#\{1,2}' @rdname" end="^\s*\(#\{1,2}'\)\@!" contains=rOTag,rOExamples,@Spell keepend fold
  " syn region rOBlockNoTitle start="\(^\s*\n\)\@<=\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*\n\(\s*#\{1,2}'.*\n\)\{-}\s*#\{1,2}' @rdname" end="^\s*\(#\{1,2}'\)\@!" contains=rOTag,rOExamples,@Spell keepend fold
  syn region rOBlockNoTitle start="\(\%^\|^\s*\n\)\@<=\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*\n\(\s*#\{1,2}'.*\n\)\{-}\s*#\{1,2}' @rdname" end="^\s*\(#\{1,2}'\)\@!" contains=rOTag,rOExamples,@Spell keepend fold
  " syn region rOBlockNoTitle start="\%^\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*\n\(\s*#\{1,2}'.*\n\)\{-}\s*#\{1,2}' @describeIn" end="^\s*\(#\{1,2}'\)\@!" contains=rOTag,rOExamples,@Spell keepend fold
  " syn region rOBlockNoTitle start="\(^\s*\n\)\@<=\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*\n\(\s*#\{1,2}'.*\n\)\{-}\s*#\{1,2}' @describeIn" end="^\s*\(#\{1,2}'\)\@!" contains=rOTag,rOExamples,@Spell keepend fold
  syn region rOBlockNoTitle start="\(\%^\|^\s*\n\)\@<=\(\s*#\{1,2}' .*\n\)\{-1,}\s*#\{1,2}'\s*\n\(\s*#\{1,2}'.*\n\)\{-}\s*#\{1,2}' @describeIn" end="^\s*\(#\{1,2}'\)\@!" contains=rOTag,rOExamples,@Spell keepend fold

  " rOTag list generated from the lists in
  " https://github.com/klutometis/roxygen/R/rd.R and
  " https://github.com/klutometis/roxygen/R/namespace.R
  " using s/^    \([A-Za-z0-9]*\) = .*/  syn match rOTag contained "@\1"/
  " Plus we need the @include tag

  " rd.R
  syn match rOTag contained "@aliases"
  syn match rOTag contained "@author"
  syn match rOTag contained "@backref"
  syn match rOTag contained "@concept"
  syn match rOTag contained "@describeIn"
  syn match rOTag contained "@description"
  syn match rOTag contained "@details"
  syn match rOTag contained "@docType"
  syn match rOTag contained "@encoding"
  syn match rOTag contained "@evalRd"
  syn match rOTag contained "@example"
  syn match rOTag contained "@examples"
  syn match rOTag contained "@family"
  syn match rOTag contained "@field"
  syn match rOTag contained "@format"
  syn match rOTag contained "@inherit"
  syn match rOTag contained "@inheritParams"
  syn match rOTag contained "@inheritDotParams"
  syn match rOTag contained "@inheritSection"
  syn match rOTag contained "@keywords"
  syn match rOTag contained "@method"
  syn match rOTag contained "@name"
  syn match rOTag contained "@md"
  syn match rOTag contained "@noMd"
  syn match rOTag contained "@noRd"
  syn match rOTag contained "@note"
  syn match rOTag contained "@param"
  syn match rOTag contained "@rdname"
  syn match rOTag contained "@rawRd"
  syn match rOTag contained "@references"
  syn match rOTag contained "@return"
  syn match rOTag contained "@section"
  syn match rOTag contained "@seealso"
  syn match rOTag contained "@slot"
  syn match rOTag contained "@source"
  syn match rOTag contained "@template"
  syn match rOTag contained "@templateVar"
  syn match rOTag contained "@title"
  syn match rOTag contained "@usage"
  " namespace.R
  syn match rOTag contained "@export"
  syn match rOTag contained "@exportClass"
  syn match rOTag contained "@exportMethod"
  syn match rOTag contained "@exportPattern"
  syn match rOTag contained "@import"
  syn match rOTag contained "@importClassesFrom"
  syn match rOTag contained "@importFrom"
  syn match rOTag contained "@importMethodsFrom"
  syn match rOTag contained "@rawNamespace"
  syn match rOTag contained "@S3method"
  syn match rOTag contained "@useDynLib"
  " other
  syn match rOTag contained "@include"
endif
